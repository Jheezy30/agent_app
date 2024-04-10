import 'package:agent_app/pages/login_page.dart';
import 'package:agent_app/pages/vendors_page.dart';
import 'package:agent_app/services/geo_service.dart';
import 'package:agent_app/services/integration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
        create: (context) => Geoservice(context: context),
        ),
        ChangeNotifierProvider(
          create: (context) => Integration(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey.shade100,
          textTheme: TextTheme(

          ),
          inputDecorationTheme: InputDecorationTheme(

          )
        ),
      ),
    );
  }
}
