import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:agent_app/components/custom_alert_dialogue.dart';
import 'package:agent_app/components/my_textform_field.dart';
import 'package:agent_app/model/td.dart';
import 'package:agent_app/pages/vendors_page.dart';
import 'package:agent_app/services/auth.dart';
import 'package:agent_app/components/custom_color.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController userNameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    // logo
                    SvgPicture.asset(
                      'images/logo.svg',
                      semanticsLabel: 'korba Logo',
                      height: 100,
                      width: 100,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    // welcome back message
                    Text(
                      "Login Agent",
                      style: TextStyle(
                        color: Colors.grey.shade900,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    // email textfield
                    MyTextFormField(
                      controller: userNameController,
                      labelText: "User Name",
                      isRequired: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // password textfield
                    MyTextFormField(
                      controller: passwordController,
                      labelText: "Password",
                      isObsecureText: true,
                      isRequired: true,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    // sign in button
                    ElevatedButton(
                      onPressed: () async {
                        final td = TD(
                            username: userNameController.text,
                            password: passwordController.text);
                        bool myresult = await auth.login(td);
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VendorsPage(),
                            ),
                          );
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
                        child: auth.isLoading
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Signing In...",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Colors.grey.shade100,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Forgot PIN?",
                      style: TextStyle(
                        color: Colors.grey.shade900,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Create Account",
                      style: TextStyle(
                        color: Colors.grey.shade900,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
