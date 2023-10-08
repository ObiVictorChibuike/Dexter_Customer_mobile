import 'package:location/location.dart';

class GetLocation {
  static GetLocation? _instance;
  static GetLocation? get instance {
    _instance ??= GetLocation._init();
    return _instance;
  }
  GetLocation._init();
  Future<LocationData> get checkLocation => checkLocationPermission();

  // Future<LocationData> checkLocationPermission() async{
  //   LocationData currentPosition; bool _serviceEnabled;
  //   PermissionStatus _permissionGranted;
  //   _serviceEnabled = await Location().serviceEnabled();
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await Location().requestService();
  //     if (!_serviceEnabled) {
  //       return Future.error("Location Service Disabled");
  //     }
  //   }
  //   _permissionGranted = await Location().hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await Location().requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       return Future.error("Location services permission not granted");
  //     }
  //   }
  //   currentPosition = await Location().getLocation();
  //   // Location().onLocationChanged.listen((LocationData currentLocation) {
  //     Location().enableBackgroundMode(enable: true);
  //     Location().changeSettings(accuracy: LocationAccuracy.high);
  //     // currentPosition = currentLocation;
  //   // });
  //   return currentPosition;
  // }

  Future<LocationData> checkLocationPermission() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return Future.error("Location Service Disabled");
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return Future.error("Location services permission not granted");
      }
    }

    locationData = await location.getLocation();
    return locationData;
  }
}