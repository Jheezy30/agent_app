import 'package:agent_app/components/custom_table_row.dart';
import 'package:agent_app/components/my_button.dart';
import 'package:agent_app/services/integration.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_alert_dialogue.dart';
import '../model/user.dart';

class ConfirmDetailsPage extends StatefulWidget {
  final User user;

  ConfirmDetailsPage({
    super.key,
    required this.user,
  });

  @override
  State<ConfirmDetailsPage> createState() => _ConfirmDetailsPageState();
}

class _ConfirmDetailsPageState extends State<ConfirmDetailsPage> {
  bool _isLoading = false;



  @override
  Widget build(BuildContext context) {
    final integration = Provider.of<Integration>(context, listen: false);
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
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: CustomTableRow(user: widget.user)),
            ),
            const SizedBox(
              height: 20,
            ),
            MyButton(
              onTap: () async {
                bool result = await integration.send(widget.user);
                if (!result) {
                  showDialog(
                    context: context,
                    builder: (context) => CustomAlertDialog(
                      title: 'Operation Failed',
                      message:
                          'An error occurred while performing the operation.',
                    ),
                  );
                }
              },
              text: 'Register',
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
