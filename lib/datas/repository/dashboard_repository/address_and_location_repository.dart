import 'package:dexter_mobile/datas/services/dashboard_services/location_and_address_services.dart';
import 'package:dio/dio.dart';

class AddressAndLocationRepository {
  final LocationAndAddressServices _locationAndAddressServices;
  AddressAndLocationRepository(this._locationAndAddressServices);
  Future<Response?> getAddress({required String id}) => _locationAndAddressServices.getAddress(id: id);
  Future<Response?> addAddress({required String address}) => _locationAndAddressServices.addAddress(address: address);
  Future<Response?> removeAddress({required String id}) => _locationAndAddressServices.removeAddress(id: id);
}