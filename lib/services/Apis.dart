class Apis {
  static const String baseUrl =
      'https://srrw9ss6bj.execute-api.eu-west-1.amazonaws.com/dev/api';

  static String get login => '$baseUrl/login';

  static String get addVendors => '$baseUrl/add/vendors';

  static String get resetPassword => '$baseUrl/password/email';
  static String get updateVendors => '$baseUrl/update/vendors/with/cordinates';
  static String getUserDataUrl(String phoneNumber) {
    return '$baseUrl/get-vendor-with-momo-number-$phoneNumber';
  }

  
}
