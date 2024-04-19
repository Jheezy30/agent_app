import 'package:agent_app/model/td.dart';
import 'package:agent_app/pages/login_page.dart';
import 'package:agent_app/pages/vendors_page.dart';
import 'package:agent_app/services/auth.dart';
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
        create: (context) => Geoservice(),
        ),
        ChangeNotifierProvider(
          create: (context) => Integration(),
        ),
         ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: VendorsPage(),
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
