import 'package:geolocator/geolocator.dart';

class Locatedhelper{

  static  Future<Position> determinePosition() async {

    bool serviceEnabled;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {

      await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high

    );
  }





}