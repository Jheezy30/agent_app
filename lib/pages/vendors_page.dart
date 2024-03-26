import 'package:agent_app/components/my_button.dart';
import 'package:agent_app/components/my_drop_down_button.dart';
import 'package:agent_app/pages/confirm_details_page.dart';
import 'package:flutter/material.dart';

import '../components/my_textfield.dart';
import '../model/user.dart';

class VendorsPage extends StatefulWidget {
  const VendorsPage({Key? key}) : super(key: key);

  @override
  State<VendorsPage> createState() => _VendorsPageState();
}

class _VendorsPageState extends State<VendorsPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController businessRegistrationController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController idTypeController = TextEditingController();
  final TextEditingController walletController = TextEditingController();
  String _selectedValue = 'NETWORK TYPE';
  String _selected = 'ZONE';
  User ? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.only(top: 75),
        child: Column(
          children: [
            // logo
            // logo
            Icon(
              Icons.lock_open_rounded,
              size: 100,
              color: Colors.grey.shade900,
            ),

            const SizedBox(
              height: 25,
            ),

            Text(
              "Registration",
              style: TextStyle(
                color: Colors.grey.shade900,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 25,
            ),

            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    //name field
                    MyTextField(
                      controller: nameController,
                      hintText: "Name",
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // business name
                    MyTextField(
                      controller: businessNameController,
                      hintText: "Business Name",
                      obscureText: false,
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    // business_registration_number
                    MyTextField(
                      controller: businessRegistrationController,
                      hintText: "Business Registration Number",
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    // contact
                    MyTextField(
                      controller: phoneController,
                      hintText: "Phone Number",
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    //id_number
                    MyTextField(
                      controller: idNumberController,
                      hintText: "Id Number",
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // id_type
                    MyTextField(
                      controller: idTypeController,
                      hintText: "IdType",
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // momo type
                    const SizedBox(
                      height: 10,
                    ),
                    MyDropDownButton(
                      items: ['NETWORK TYPE', 'MTN', 'TELECEL', 'AIRTELTIGO'],
                      selectedValue: _selectedValue,
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value!;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Wallet number
                    MyTextField(
                      controller: walletController,
                      hintText: "Wallet Number",
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyDropDownButton(
                      items: [
                        'ZONE',
                        'GREATER ACCRA',
                        'EASTERN ',
                        'MIDDLE BELT',
                        'NOTHERN',
                        'WESTERN',
                      ],
                      selectedValue: _selected,
                      onChanged: (value) {
                        setState(() {
                          _selected = value!;
                        });
                      },
                    ),

                    const SizedBox(
                      height: 25,
                    ),
                    MyButton(
                        onTap: () {
                          user = User(
                              name: nameController.text,
                              businessName:businessNameController.text.isNotEmpty ?
                              businessNameController.text : null,
                              businessRegistration: businessRegistrationController.text.isNotEmpty ?
                              businessRegistrationController.text : null,
                              phone: phoneController.text,
                              selectedValue: _selectedValue,
                              selected: _selected,
                              wallet: walletController.text,
                              idNumber: idNumberController.text.isNotEmpty ?  idNumberController.text: null,
                              idType: idTypeController.text.isNotEmpty ? idTypeController.text: null,
                          );
                          Navigator.push(
                              context, MaterialPageRoute(
                              builder: (context) => ConfirmDetailsPage(user: user!)
                          ),
                          );
                        },
                        text: "Confirm details",
                    ),

                    const SizedBox(
                      height: 200,
                    ),

                    // momo's network
                    // is ambassador boolean
                    //is_land_tenure agent boolean
                    // zone
                    //region
                    // coordinates
                    //latitude
                    // longitude
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
