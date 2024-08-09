import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
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
    return WillPopScope(
      onWillPop: () async {
        // Close the app when the back button is pressed
        SystemNavigator.pop();
        return false; // Return false to prevent the default back navigation behavior
      },

      child: Consumer2<Auth, MomoCustom>(
        builder: (__, auth, momos, _) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey.shade100,
            title: Text('H O M E  P A G E'),
            leading: SizedBox(),
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
                  icon: Icon(Icons.logout, size: 30),
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              // Centered background SVG
              Center(
                child: Opacity(
                  opacity: 0.1,
                  child: SvgPicture.asset(
                    'images/logo.svg',
                    semanticsLabel: 'Logo',
                    height: 400,
                    width: 400,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              // Content that maintains its position
              CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.13), // Space between the top and content
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MyButton(
                                    onTap: () {
                                      Navigator.pushNamed(context, 'vendorspage');
                                    },
                                    text: "Create New Vendor",
                                  ),
                                  const SizedBox(height: 16),
                                  UpdateVendorWidget(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
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
  bool _isEditing = false;

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  final formKey = GlobalKey<FormState>();

  String? _validateWallet(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    } else if (value.length != 10) {
      return 'The number must be 10 digits';
    }
    return null;
  }

  final TextEditingController walletController = TextEditingController();

  clearWalletController() {
    walletController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Integration>(
      builder: (__, integrate, _) => Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyButton(onTap: _toggleEdit, text: "Update Vendor"),  
              SizedBox(height: 26),
              Form(
                key: formKey,
                child: AnimatedOpacity(
                  opacity: _isEditing ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 300),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: TextFormField(
                            controller: walletController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Vendor Wallet Number',
                              hintStyle: TextStyle(fontSize: 11),
                              labelStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                            ),
                            validator: _validateWallet,
                            minLines: 1,
                            maxLines:
                                1, // Change maxLines to 1 to prevent growth
                            style: TextStyle(color: Colors.black),
                            cursorColor: Colors.black,
                          ),
                        ),
                      ),
                    
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 25),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: integrate.isLoading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      CustomColors.customColor),
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
                                              builder: (context) =>
                                                  ConfirmDetailsPage(
                                                update: true,
                                                user: user,
                                                clearControllers:
                                                    clearWalletController,
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
                                    child: Icon(Icons.arrow_forward,
                                        color: Colors.white),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
        ),
      ),
    );
  }
}
