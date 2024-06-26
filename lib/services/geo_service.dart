import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class Geoservice extends ChangeNotifier {
  Position? currentPosition;
  StreamSubscription<Position>? positionStreamSubscription;
  String? formattedAddress;
  bool isLoading = false;
  String? address;
  String? region;
  String? district;
  String? location;
  String? town;
  bool isListening = false;

  Geoservice();

  void startListeningForLocationUpdates() {
    if (!isListening) {
      getCurrentLocation();
      isListening = true;
    }
  }

  void stopListeningForLocationUpdates() {
    if (isListening) {
      cancelSubscription();
      isListening = false;
    }
  }

  Future<void> getCurrentLocation() async {
    LocationPermission permission = await getLocationPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    } else if (permission == LocationPermission.deniedForever) {
      openAppSettings();
    } else {
      try {
        final LocationSettings locationSettings = LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
        );

        positionStreamSubscription = Geolocator.getPositionStream(
          locationSettings: locationSettings,
        ).listen((Position? position) async {
          if (position != null) {
            currentPosition = position;
            notifyListeners();
          }
        });
      } catch (e) {
        print(e);
      }
    }
  }

  void cancelSubscription() {
    positionStreamSubscription?.cancel();
  }

  Future<LocationPermission> getLocationPermission() async {
    PermissionStatus permissionStatus = await Permission.location.request();
    return permissionStatus.isGranted
        ? LocationPermission.always
        : LocationPermission.denied;
  }

  Future<void> search() async {
    if (currentPosition == null) {
      // Location not available yet, return or show error
      return;
    }
    isLoading = true;
    notifyListeners();
    final dio = Dio();
    try {
      final response = await dio.get(
          'https://api.geoapify.com/v1/geocode/reverse?lat=${currentPosition?.latitude}&lon=${currentPosition?.longitude}&apiKey=6d7d8b56210b44aeafb740c2d7cb0cde');
      if (response.statusCode == 200) {
        final data = response.data;
        final features = data['features'];
        address = features[0]['properties']['address_line2'];
        location = features[0]['properties']['formatted'];
        region = features[0]['properties']['state'];
        district = features[0]['properties']['county'];
        town = features[0]['properties']['suburb'];

        print(location);
        print(region);
      } else {
        // Request failed
        // Handle error
      }
    } catch (e) {
      // Error occurred during the request
      // Handle error
    }
    isLoading = false;
    notifyListeners();
  }
}
