class Apis {
  static const String baseUrl =
      'https://srrw9ss6bj.execute-api.eu-west-1.amazonaws.com/dev/api';

  static String get login => '$baseUrl/login';

  static String get addVendors => '$baseUrl/add/vendors';

  static String get resetPassword => '$baseUrl/password/email';
}
