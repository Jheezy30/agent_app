import 'package:agent_app/components/custom_table_row.dart';
import 'package:agent_app/components/my_button.dart';
import 'package:flutter/material.dart';

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
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
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
            MyButton(onTap: (){}, text: 'Register'),

            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
