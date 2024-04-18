import 'package:agent_app/components/custom_alert_dialogue.dart';
import 'package:agent_app/components/my_button.dart';
import 'package:agent_app/components/my_textform_field.dart';
import 'package:agent_app/model/td.dart';
import 'package:agent_app/pages/vendors_page.dart';
import 'package:agent_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  TD td;
  
  LoginPage({super.key, required this.td});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
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

                  //sign in button
                  MyButton(
                    onTap: () async {
                      bool result = await auth.send(widget.td);
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VendorsPage(),
                        ),
                      );
                    },
                    text: "Sign In",
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
    );
  }
}
