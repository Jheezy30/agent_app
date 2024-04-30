import 'package:agent_app/components/custom_color.dart';
import 'package:agent_app/components/custom_table_row.dart';
import 'package:agent_app/components/my_button.dart';
import 'package:agent_app/pages/home_page.dart';
import 'package:agent_app/pages/vendors_page.dart';
import 'package:agent_app/services/auth.dart';
import 'package:agent_app/services/geo_service.dart';
import 'package:agent_app/services/integration.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_alert_dialogue.dart';
import '../model/user.dart';

class ConfirmDetailsPage extends StatefulWidget {
  final User user;
  final Function clearControllers;

  ConfirmDetailsPage({
    super.key,
    required this.user,
    required this.clearControllers,
  });

  @override
  State<ConfirmDetailsPage> createState() => _ConfirmDetailsPageState();
}

class _ConfirmDetailsPageState extends State<ConfirmDetailsPage> {
  late Geoservice geo;
  @override
  void dispose() {
    super.dispose();
    Future.microtask(() {
      context.read<Geoservice>().stopListeningForLocationUpdates();
    });
  }

  @override
  Widget build(BuildContext context) {
    final integrate = Provider.of<Integration>(context, listen: true);
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 50, left: 25, right: 25, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(right: 100),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: CustomTableRow(user: widget.user)),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                bool myresult = await integrate.send(widget.user);
                if (!myresult) {
                  showDialog(
                    context: context,
                    builder: (context) => CustomAlertDialog(
                      title: 'Operation Failed',
                      message:
                          'An error occurred while performing the operation.',
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => CustomAlertDialog(
                      title: 'Success',
                      message: 'Agent is registered successfully',
                    ),
                  ).then((_) {
                    widget.clearControllers();
                    Navigator.pushReplacementNamed(context, 'vendorspage');
                  });
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  CustomColors.customColor,
                ),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              child: Container(
                width: 260,
                padding: EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.center,
                child: integrate.isLoading
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Registering...",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.grey.shade100,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
