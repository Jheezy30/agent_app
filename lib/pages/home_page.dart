import 'package:agent_app/components/custom_color.dart';
import 'package:agent_app/components/custom_table_row.dart';
import 'package:agent_app/components/my_button.dart';
import 'package:agent_app/components/my_textform_field.dart';
import 'package:agent_app/model/user.dart';
import 'package:agent_app/pages/confirm_details_page.dart';
import 'package:agent_app/pages/login_page.dart';
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

  @override
  Widget build(BuildContext context) {
    return Consumer3<Auth, FormController, MomoCustom>(
      builder: (__, auth, formController, momos, _) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade100,
          title: Text('H O M E  P A G E'),
          actions: [],
        ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 30), // Add horizontal padding
              child: Column(
                mainAxisSize:
                    MainAxisSize.min, // Use min size to fit the content
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center content vertically
                children: [
                  Spacer(
                    flex: 1,
                  ),
                  MyButton(
                    onTap: () {
                      Navigator.pushNamed(context, 'vendorspage');
                    },
                    text: "Create New Vendor",
                  ),
                  const SizedBox(height: 20), // Space between buttons
                  UpdateVendorWidget(),
                  Spacer(
                    flex: 2,
                  ),
                ],
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
  bool _isEditing =
      false; // State to manage the visibility of the text box and button
  final TextEditingController walletController = TextEditingController();

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  clearWalletController() {
    walletController.clear();
  }

  String? _nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Integration>(
      builder: (__, integrate, _) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: MyButton(onTap: _toggleEdit, text: "Update Vendor"),
          ),
          if (_isEditing) ...[
            SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min, // Use min size to fit the content
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, top: 15),
                    child: MyTextFormField(
                      controller: walletController,
                      labelText: "wallet",
                      isNumericOnly: true,
                      validator: _nameValidator,
                    ),
                  ),
                ),
                const SizedBox(
                    width:
                        10), // Adjusted space between TextFormField and button
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: integrate.isLoading
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              CustomColors.customColor),
                        )
                      : InkWell(
                          onTap: () async {
                            await integrate.fetchUserByPhoneNumber(
                                context, walletController.text,
                                onSuccess: (User user) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ConfirmDetailsPage(
                                      user: user, clearControllers: () {}),
                                ),
                              );
                            });
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
          ],
        ],
      ),
    );
  }
}
