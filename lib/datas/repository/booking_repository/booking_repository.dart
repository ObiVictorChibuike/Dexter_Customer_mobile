import 'package:dexter_mobile/datas/services/bookings_services/booking_services.dart';
import 'package:dio/dio.dart';

class BookingRepository {
  final BookingServices _bookingServices;
  BookingRepository(this._bookingServices);
  Future<Response?> getActiveRequest() => _bookingServices.getActiveRequest();
  Future<Response?> getCompletedRequest() => _bookingServices.getCompletedRequest();
  Future<Response?> getPendingRequest() => _bookingServices.getPendingRequest();
}