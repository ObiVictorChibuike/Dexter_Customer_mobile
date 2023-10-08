import 'dart:convert';
import 'package:dexter_mobile/datas/model/shop_response/card_response.dart';
import 'package:dexter_mobile/domain/local/local_storage.dart';
import 'package:dexter_mobile/presentation/customer/pages/shop/pages/booking_placed_success_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class ChargeAndAddCard {
  ChargeAndAddCard(
      {this.ctx,
      required this.paystackPlugin,
      required this.secretKey,
      required this.amount,
      required this.email,
      cardNumber = "",
      cvv = "",
      expiryMonth = "",
      expiryYear = "",
      });
  // final SessionManager _sessionManager = SessionManager();
  BuildContext? ctx;
  PaystackPlugin paystackPlugin;
  String secretKey;
  String amount;
  String email;
  String cardNumber = "";
  String cvv = "";
  int expiryMonth = 0;
  int expiryYear = 0;

  String _getReference() {
    var uuid = const Uuid();
    return uuid.v1();
  }

  PaymentCard _getCardFromPayStackUI() {
    return PaymentCard(
        number: cardNumber,
        cvc: cvv,
        expiryMonth: expiryMonth,
        expiryYear: expiryYear);
  }

  Future<String>createAccessCode(skTest, _getReference) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $skTest'};
    Map data = {"amount": 600, "email": email, "reference": _getReference};
    String payload = json.encode(data); http.Response response = await http.post(Uri.parse('https://api.paystack.co/transaction/initialize'),
        headers: headers,
        body: payload);
    final Map dataResponse = jsonDecode(response.body);
    String accessCode = dataResponse['data']['access_code'];
    return accessCode;
  }

  checkoutCard() async {
    Charge charge = Charge()
      ..amount = int.parse(amount) * 100
      ..email = email
      ..accessCode = await createAccessCode(secretKey, _getReference())
      ..card = _getCardFromPayStackUI()
      ..reference = _getReference()
      ..putCustomField("Charged From", "Flutter SDK");

    CheckoutResponse response = await paystackPlugin.checkout(ctx!,
        charge: charge,
        method: CheckoutMethod.selectable,
        fullscreen: false,
        logo: Image.asset(
          'assets/png/splash_logo.png',
          height: 50,
          width: 50,
        ));
     await tokeniseCard(response,charge.reference!).then((value){
       Get.offAll(()=> BookingPlaced());
     });
  }


  Future<void> tokeniseCard(CheckoutResponse response,String reference) async {
    if (response.status) {
      var url = Uri.parse("https://api.paystack.co/transaction/verify/${reference}");
      var res = await http.get(url, headers: {"Authorization": "Bearer $secretKey"});
      if (res.statusCode == 200) {
        var jsonResponse = jsonDecode(res.body);
        CardResponse cardResponse = CardResponse.fromJson(jsonResponse['data']);
        Get.put<LocalCachedData>(await LocalCachedData.create());
        await LocalCachedData.instance.cacheCardResponse(cardResponse: cardResponse);
      }
    }
  }
}
