import 'package:agent_app/pages/vendors_page.dart';
import 'package:agent_app/services/momo_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:agent_app/pages/login_page.dart';
import 'package:agent_app/services/auth.dart';
import 'package:agent_app/services/geo_service.dart';
import 'package:agent_app/services/integration.dart';

void main() async {
  String initialRoute;

  // Handle exceptions caused by making main async
  WidgetsFlutterBinding.ensureInitialized();

  // Init a shared preferences variable
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Read token
  String? token = prefs.getString('token');
  print(token);

  // Use Dart's null safety operator
  if (token?.isEmpty ?? true)
    initialRoute = 'login';
  else
    initialRoute = 'vendorspage';

  // Create a Flutter Material app as usual
  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Geoservice(),
        ),
        ChangeNotifierProvider(
          create: (context) => Integration(),
        ),
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (context) => MomoCustom(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: initialRoute,
        routes: {
          'login': (context) => LoginPage(),
          'vendorspage': (context) => VendorsPage(),
        },
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey.shade100,
          textTheme: TextTheme(),
          inputDecorationTheme: InputDecorationTheme(isDense: true),
          dropdownMenuTheme: DropdownMenuThemeData(
            inputDecorationTheme: InputDecorationTheme(isDense: false),
          ),
        ),
      ),
    );
  }
}
