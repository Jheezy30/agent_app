import 'package:agent_app/components/custom_color.dart';
import 'package:agent_app/components/custom_table_row.dart';
import 'package:agent_app/services/geo_service.dart';
import 'package:agent_app/services/integration.dart';
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
    geo.stopListeningForLocationUpdates();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    geo = context.read<Geoservice>();
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
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 50,
                width: 250,
                child: ElevatedButton(
                  onPressed: () async {
                    await integrate.send(
                      widget.user,
                      context,
                      onSuccess: () {
                        showDialog(
                          context: context,
                          builder: (context) => CustomAlertDialog(
                            title: 'Success',
                            message: 'Agent is registered successfully',
                          ),
                        ).then((_) {
                          widget.clearControllers();
                          Navigator.pushReplacementNamed(context, 'home');
                        });
                      },
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      CustomColors.customColor.shade800,
                    ),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  child: integrate.isLoading
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.grey.shade100,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
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
