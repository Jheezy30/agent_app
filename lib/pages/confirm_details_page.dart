import 'package:agent_app/components/custom_alert_dialogue.dart';
import 'package:agent_app/components/my_button.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';
import '../services/geo_service.dart';
import 'home_page.dart';

class ConfirmDetailsPage extends StatefulWidget {
  final User user;

  const ConfirmDetailsPage({super.key, required this.user});

  @override
  State<ConfirmDetailsPage> createState() => _ConfirmDetailsPageState();
}

class _ConfirmDetailsPageState extends State<ConfirmDetailsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      context.read<Geoservice>().getCurrentLocation();
    });
  }

  void send() async {
    final dio = Dio();
    try {
      Response response = await dio.post(
        'https://srrw9ss6bj.execute-api.eu-west-1.amazonaws.com/dev/api/add/vendors',
        data: widget.user.toJson(),
      );
      if (response.statusCode == 201) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => CustomAlertDialog(
            title: 'Operation Failed',
            message: 'The operation was not successful.',
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
          title: 'Operation Failed',
          message: 'An error occurred while performing the operation.',
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Geoservice>(
      builder: (__, geo, _) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 100, left: 25, right: 25),
          child: Column(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back)),
              const SizedBox(
                height: 25,
              ),
              Text('Name : ${widget.user.name}'),
              const SizedBox(
                height: 15,
              ),
              Text('Business Name : ${widget.user.businessName}'),
              const SizedBox(
                height: 15,
              ),
              Text(
                  'Business Registration Number : ${widget.user.businessRegistration}'),
              const SizedBox(
                height: 15,
              ),
              Text('Phone Number : ${widget.user.phone}'),
              const SizedBox(
                height: 15,
              ),
              Text('Id Number : ${widget.user.idNumber}'),
              const SizedBox(
                height: 15,
              ),
              Text('IdType : ${widget.user.idType}'),
              const SizedBox(
                height: 15,
              ),
              Text('Network Type : ${widget.user.selectedValue}'),
              const SizedBox(
                height: 15,
              ),
              Text('Wallet Number: ${widget.user.wallet}'),
              const SizedBox(
                height: 15,
              ),
              Text('Zone : ${widget.user.selected}'),
              const SizedBox(
                height: 15,
              ),
              Text(
                'latitude : ${geo.currentPosition?.latitude ?? 'N/A'}',
              ),
              const SizedBox(
                height: 15,
              ),
              Text('longitude : ${geo.currentPosition?.longitude ?? 'N/A'}'),
              const SizedBox(
                height: 15,
              ),
              Text('locality: ${geo.locality ?? 'N/A'}'),
              const SizedBox(
                height: 15,
              ),
              MyButton(onTap: send, text: "Send"),
            ],
          ),
        ),
      ),
    );
  }
}
