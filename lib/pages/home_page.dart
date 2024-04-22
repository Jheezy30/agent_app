import 'package:agent_app/components/custom_color.dart';
import 'package:agent_app/services/integration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Integration>(
      builder: (_, Integrate, __) => Scaffold(
        body: Integrate.isLoading
            ? Center(child: CircularProgressIndicator(
              backgroundColor: CustomColors.customColor,
            )
            )
            : Column(
                children: [
                  // Your other widgets
                ],
              ),
      ),
    );
  }
}
