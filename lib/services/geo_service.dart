import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../components/custom_alert_dialogue.dart';

class Geoservice extends ChangeNotifier {
  final BuildContext context;
  Position? currentPosition;
  StreamSubscription<Position>? positionStreamSubscription;
  String? formattedAddress;
  bool isLoading = false;
  String? address;
  String? region;
  String? district;
  String? location;
  String? town;

  Geoservice({
    required this.context,
  });

  Future<void> getCurrentLocation() async {
    LocationPermission permission = await getLocationPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    } else if (permission == LocationPermission.deniedForever) {
      await openAppSettings();
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
            
          }
        });
      } catch (e) {
        print(e);
      }
    }
  }

  void cancelSubscription(){
    positionStreamSubscription?.cancel();
  }


  Future<LocationPermission> getLocationPermission() async {
    PermissionStatus permissionStatus = await Permission.location.request();
    return permissionStatus.isGranted
        ? LocationPermission.always
        : LocationPermission.denied;
  }

/*
  Future<void> addressSearch() async {
    const String googleApiKey =
        'AIzaSyA2e0qYEm1s5blKSZJfBfxzzxiHoeHNkN8'; // Replace with your API key
    final bool isDebugMode = true;
    final api = GoogleGeocodingApi(googleApiKey, isLogged: isDebugMode);

    try {
      final reversedSearchResults = await api.reverse(
        '${currentPosition?.latitude}, ${currentPosition?.longitude}',
        language: 'en',
      );
      if (reversedSearchResults.results.isNotEmpty) {
        final result = reversedSearchResults.results.first;

        // Extract formatted address
        formattedAddress = result.formattedAddress;

        // Extract administrative area level 1 and level 2
        result.addressComponents.forEach((component) {
          if (component.types.contains('administrative_area_level_1')) {
            administrativeAreaLevel1 = component.longName;
          } else if (component.types.contains('administrative_area_level_2')) {
            administrativeAreaLevel2 = component.longName;
          }
        });
      }
      notifyListeners();
    } catch (e) {
      print('Error occurred during address search: $e');
    }
  }

 */

  Future<void> search() async {
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
      } else {
        // Request failed
        showDialog(
          context: context,
          builder: (context) => CustomAlertDialog(
            title: 'Operation Failed',
            message: 'The operation was not successful.',
          ),
        );
      }
    } catch (e) {
      // Error occurred during the request
      showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
          title: 'Operation Failed',
          message: 'An error occurred while performing the operation.',
        ),
      );
    }
    isLoading = false;
    notifyListeners();
  }
}
