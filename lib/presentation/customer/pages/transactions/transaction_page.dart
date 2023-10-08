import 'package:dexter_mobile/app/shared/app_colors/app_colors.dart';
import 'package:dexter_mobile/presentation/customer/pages/bookings/booking_screen.dart';
import 'package:dexter_mobile/presentation/customer/pages/orders/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: TabBar(
            indicatorColor: greenPea,
            unselectedLabelColor: black, splashFactory: NoSplash.splashFactory,
            tabs: [
              Tab(icon: Column(
                children: [
                  Icon(Iconsax.shop, color: greenPea,),
                  const SizedBox(height: 2,),
                  Text('Orders', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: greenPea, fontSize: 12),)
                ],
              )),
              Tab(icon: Column(
                children: [
                  Icon(Iconsax.calendar, color: greenPea,),
                  const SizedBox(height: 2,),
                  Text('Appointments', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: greenPea, fontSize: 12),)
                ],
              )),
            ],
          ),
          title: Text('Transaction', style: Theme.of(context).textTheme.bodySmall!.copyWith(color: black, fontSize: 20, fontWeight: FontWeight.w700),),
        ),
        body: TabBarView(
          children: [
            OrderScreen(),
            BookingScreen()
          ],
        ),
      ),
    );
  }
}
