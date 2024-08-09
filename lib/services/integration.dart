import 'package:agent_app/components/custom_color.dart';
import 'package:agent_app/services/geo_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/custom_alert_dialogue.dart';
import '../model/user.dart';
import 'Apis.dart';

class Integration extends ChangeNotifier {
  bool isLoading = false;
  String message = '';
  bool success = false;
  String? _token; // Added variable to store the token

  // Getter for token
  String? get token => _token;

  Future<void> send(User user, BuildContext context,
      {required Function onSuccess}) async {
    isLoading = true;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Read token
    _token = prefs.getString('token');
    print('Token retrieved: $_token');

    if (_token == null) {
      print('No token found');
      isLoading = false;
      notifyListeners();
      // Handle the missing token case (e.g., show an error dialog or redirect to login)
      return;
    }

    try {
      final dio = Dio();

      // Log request details
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            print('Request URL: ${options.uri}');
            print('Request Headers: ${options.headers}');
            print('Request Body: ${options.data}');
            return handler.next(options);
          },
          onResponse: (response, handler) {
            print('Response Status: ${response.statusCode}');
            print('Response Data: ${response.data}');
            return handler.next(response);
          },
          onError: (error, handler) {
            print('Error: $error');
            return handler.next(error);
          },
        ),
      );

      Response response = await dio.post(
        Apis.addVendors,
        data: user.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $_token', // Include the bearer token
            'Content-Type': 'application/json',
          },
        ),
      );

      // Handle the API response based on success field
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        success = responseData['success'] ??
            false; // Check for the actual 'success' field
        message = responseData['message'];
        print(response.data);

        isLoading = false;
        notifyListeners();
        print(success);
        if (success) {
          onSuccess();
        }
      } else {
        isLoading = false;
        notifyListeners();
        if (!success) {
          showDialog(
            context: context,
            builder: (context) => CustomAlertDialog(
              title: 'Wallet Assigned',
              message: 'The wallet number has already been assigned',
            ),
          );
        }
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Wallet already assigned"),
          content: Text(
            'The wallet number has already been assigned.\n'
            'Do you want to update the vendor details?',
          ),
        ),
      );
    }
  }

  Future<void> updateUser(User user, BuildContext context,
      {required Function onUpdate}) async {
    isLoading = true;
    notifyListeners();
    // Fetch the token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print('Token retrieved: $token');

    if (token == null) {
      print('No token found');
      isLoading = false;
      notifyListeners();
      // Handle the missing token case (e.g., show an error dialog or redirect to login)
      return;
    }

    try {
      final dio = Dio();

      // Log request details
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            print('Request URL: ${options.uri}');
            print('Request Headers: ${options.headers}');
            print('Request Body: ${options.data}');
            return handler.next(options);
          },
          onResponse: (response, handler) {
            print('Response Status: ${response.statusCode}');
            print('Response Data: ${response.data}');
            return handler.next(response);
          },
          onError: (error, handler) {
            print('Error: $error');
            return handler.next(error);
          },
        ),
      );

      Response response = await dio.post(
        Apis.updateVendors,
        data: {
          "vendor_id": user.user_id,
          "location": user.location,
          "longitude": user.longitude,
          "latitude": user.latitude,
          "region": user.region,
          "zone":
              user.zone ?? 'Greater Accra', // Ensure default value if needed
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      // Print response details
      print('Response status code: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        bool success = responseData['success'] ?? false;
        String message = responseData['message'] ?? 'No message provided';
        print('Success: $success');
        print('Message: $message');

        if (success) {
          isLoading = false;
          notifyListeners();
          onUpdate();
        } else {
          showDialog(
            context: context,
            builder: (context) => CustomAlertDialog(
              title: 'Update Error',
              message: 'Update failed',
            ),
          );
        }
      } else {
        isLoading = false;
        notifyListeners();
        showDialog(
          context: context,
          builder: (context) => CustomAlertDialog(
            title: 'Error',
            message: 'Update failed with status code ${response.statusCode}',
          ),
        );
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
          title: 'Error',
          message: 'An unexpected error occurred:',
        ),
      );
    }
  }

  Future<void> fetchUserByPhoneNumber(BuildContext context, String phoneNumber,
      {required Function(User) onSuccess}) async {
    final dio = Dio();
    final url = Apis.getUserDataUrl(phoneNumber);
    isLoading = true;
    notifyListeners();

    try {
      final response = await dio.get(url);

      print(response.statusCode); // Print status code for debugging
      print(response.data); // Print response data for debugging

      if (response.statusCode == 200) {
        final data = response.data;

        if (data['success'] == true) {
          final userData = data['message'];
         

          if (userData != null && userData is Map<String, dynamic>) {
            try {
              final user = User.fromJson(userData);
              print("Parsed User: $user");
              // Print user data for debugging
              final geo = Provider.of<Geoservice>(context, listen: false);
              await geo.search();
              user.location = geo.location.toString();
              user.region = geo.region.toString();
              user.longitude = geo.currentPosition?.longitude.toString() ?? '';
              user.latitude = geo.currentPosition?.latitude.toString() ?? '';
              print('location: ${user.location}');
              print('geo.region: ${user.region}');
              print(user.longitude);
              print(user.latitude);
              isLoading = false;
              notifyListeners();
              onSuccess(user);
            } catch (e) {
              isLoading = false;
              notifyListeners();
              print("Error parsing user data: "); // Print parsing error
              showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  title: 'Error',
                  message: 'Error parsing user data: $e',
                ),
              );
            }
          } else {
            isLoading = false;
            notifyListeners();
            print("No user data found"); // Debug message
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Error',
                message: 'No user data found.',
              ),
            );
          }
        } else {
          isLoading = false;
          notifyListeners();
          print("Vendors not found"); // Debug message
          showDialog(
            context: context,
            builder: (context) => CustomAlertDialog(
              title: 'Vendor Status',
              message: 'Vendor not found.',
            ),
          );
        }
      } else {
        isLoading = false;
        notifyListeners();
        print(
            "Failed to load user data: ${response.statusCode}"); // Debug message
        showDialog(
          context: context,
          builder: (context) => CustomAlertDialog(
            title: 'Error',
            message: 'Failed to load user data: ${response.statusCode}.',
          ),
        );
      }
    } catch (e) {
      print("Error fetching user data: $e"); // Print error
      showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
          title: 'Error',
          message: 'Error fetching user data: $e',
        ),
      );
    }
  }
}
