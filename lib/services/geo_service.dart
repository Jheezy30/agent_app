

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';


class Geoservice extends ChangeNotifier {
  Position? currentPosition;
  String? country;
  String? locality;

  void getCurrentLocation() async {
    LocationPermission permission = await getLocationPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    } else if (permission == LocationPermission.deniedForever) {
      await openAppSettings();
    } else {
      // it means the location permission is granted
      try {
        Position position = await getCurrentPosition();

        print('Current position: $position');
        currentPosition = position;

        await getPlacemark(position);
        notifyListeners();
      } catch (e) {
        print(e);
      }
    }

  }

  Future<LocationPermission> getLocationPermission() async {
    PermissionStatus permissionStatus = await Permission.location.request();
    return permissionStatus.isGranted
        ? LocationPermission.always
        : LocationPermission.denied;
  }

  Future<Position> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
  }

  Future<void> getPlacemark(Position position) async {
    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        country = placemark.country;
        locality = placemark.street;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }
















}



