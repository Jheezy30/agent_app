
import 'package:agent_app/pages/vendors_page.dart';
import 'package:agent_app/services/geo_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (context) => Geoservice(context: context),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VendorsPage(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade100,
      ),
    );
  }
}
