import 'package:agent_app/components/my_button.dart';
import 'package:agent_app/components/my_textform_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                        
                  //sign in button
                  MyButton(
                    onTap: (){},
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
