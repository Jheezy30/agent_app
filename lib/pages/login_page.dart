import 'package:agent_app/components/custom_alert_dialogue.dart';
import 'package:agent_app/components/custom_color.dart';
import 'package:agent_app/components/my_textform_field.dart';
import 'package:agent_app/model/td.dart';
import 'package:agent_app/pages/vendors_page.dart';
import 'package:agent_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

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
                      height: 50,
                      width: 50,
                    ),

                    const SizedBox(
                      height: 25,
                    ),
                    // welcome back message
                    Text(
                      "Login",
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
                      controller: emailController,
                      labelText: "Email",
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
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          final td = TD(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          await auth.login(td, context);
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
                        child: auth.isLoading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Colors.grey.shade100,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    Consumer<Auth>(
                      builder: (context, auth, child) {
                        return GestureDetector(
                          onTap: () async {
                            await auth.resetPassword(
                                context, emailController.text);
                          },
                          child: auth.isResetting
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : Text(
                                  "Reset Password",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                        );
                      },
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
