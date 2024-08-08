import 'package:agent_app/components/custom_color.dart';
import 'package:agent_app/components/my_button.dart';
import 'package:agent_app/components/my_textform_field.dart';
import 'package:agent_app/model/user.dart';
import 'package:agent_app/pages/confirm_details_page.dart';
import 'package:agent_app/pages/vendors_page.dart';
import 'package:agent_app/services/auth.dart';
import 'package:agent_app/services/geo_service.dart';
import 'package:agent_app/services/integration.dart';
import 'package:agent_app/services/momo_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<Geoservice>().startListeningForLocationUpdates();
    });
  }

  final TextEditingController walletController = TextEditingController();

  clearWalletController() {
    walletController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<Auth, MomoCustom>(
      builder: (__, auth, momos, _) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade100,
          title: Text('H O M E  P A G E'),
          leading: SizedBox(), // Removes the default leading icon
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                onPressed: () {
                  auth.logout();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    'login',
                    (route) => false,
                  );
                },
                icon: Icon(
                  Icons.logout,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.topCenter, // Center horizontally
              child: Padding(
                padding: const EdgeInsets.only(top: 150), // Push container up from the top
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 600, // Optional: set a max width for better layout control
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20), // Padding around the buttons
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MyButton(
                              onTap: () {
                                Navigator.pushNamed(context, 'vendorspage');
                              },
                              text: "Create New Vendor",
                            ),
                            const SizedBox(height: 16), // Space between buttons
                            UpdateVendorWidget(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UpdateVendorWidget extends StatefulWidget {
  @override
  _UpdateVendorWidgetState createState() => _UpdateVendorWidgetState();
}

class _UpdateVendorWidgetState extends State<UpdateVendorWidget> {
  bool _isEditing = false; // State to manage the visibility of the text box and button

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  final formKey = GlobalKey<FormState>();

  String? _validateWallet(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    } else if (value.length < 10) {
      return 'Digit is not up to 10';
    }
    return null;
  }
  final TextEditingController walletController = TextEditingController();

  clearWalletController() {
    walletController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => Future.value(false),
      child: Consumer<Integration>(
        builder: (__, integrate,  _) => Container(
          padding: const EdgeInsets.symmetric(vertical: 10), // Padding around the container
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyButton(onTap: _toggleEdit, text: "Update Vendor"),
              if (_isEditing) ...[
                SizedBox(height: 16), // Space between text box and button
                Form(
                  key: formKey,
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min, // Fit the content
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 28), // Adjusted padding
                            child: TextFormField(
                              controller: walletController,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Enter Vendor Wallet Number',
                                hintStyle: TextStyle(
                                  fontSize: 11, // Increase font size for hint text
                                ),
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 15, // Increase padding
                                ),
                              ),
                              validator: _validateWallet,
                              minLines: 1, // Minimum number of lines
                              maxLines: 3,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              cursorColor: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(width: 5), // Space between TextFormField and button
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 25), // Adjusted padding
                          child: integrate.isLoading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(CustomColors.customColor),
                                )
                              : InkWell(
                                  onTap: () async {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      await integrate.fetchUserByPhoneNumber(
                                        context,
                                        walletController.text,
                                        onSuccess: (User user) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ConfirmDetailsPage(
                                                update: true,
                                                user: user,
                                                clearControllers: clearWalletController,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: CustomColors.customColor,
                                    ),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

