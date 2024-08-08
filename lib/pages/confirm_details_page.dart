import 'package:agent_app/components/custom_color.dart';
import 'package:agent_app/components/custom_table_row.dart';
import 'package:agent_app/pages/home_page.dart';
import 'package:agent_app/pages/vendors_page.dart';
import 'package:agent_app/services/geo_service.dart';
import 'package:agent_app/services/integration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_alert_dialogue.dart';
import '../model/user.dart';

class ConfirmDetailsPage extends StatefulWidget {
  final User user;
  final bool update;
  final Function clearControllers;

  ConfirmDetailsPage(
      {super.key,
      required this.user,
      this.update = false,
      required this.clearControllers});

  @override
  State<ConfirmDetailsPage> createState() => _ConfirmDetailsPageState();
}

class _ConfirmDetailsPageState extends State<ConfirmDetailsPage> {
  late Geoservice geo;

 @override
void dispose() {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    geo.stopListeningForLocationUpdates();
    widget.clearControllers();
  });
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
                    if (widget.update) {
                      integrate.updateUser(widget.user, context, onUpdate: () {
                        showDialog(
                            context: context,
                            builder: (context) => CustomAlertDialog(
                                  title: 'Success',
                                  message:
                                      'Vendor details is updated successfully',
                                )).then((_) {
                          Navigator.pushReplacementNamed(context, 'home');
                        });
                      });
                    } else {
                      await integrate.send(
                        widget.user,
                        context,
                        onSuccess: () {
                          showDialog(
                            context: context,
                            builder: (context) => CustomAlertDialog(
                              title: 'Success',
                              message: 'Vendor is registered successfully',
                            ),
                          ).then((_) {
                            Navigator.pushReplacementNamed(context, 'home');
                          });
                        },
                      );
                    }
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
                          widget.update ? "Update" : "Register",
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
