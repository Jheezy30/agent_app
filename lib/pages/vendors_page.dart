import 'package:agent_app/components/my_button.dart';
import 'package:agent_app/components/my_drop_down_button.dart';
import 'package:agent_app/pages/confirm_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../components/my_textfield.dart';
import '../model/user.dart';
import '../services/geo_service.dart';

class VendorsPage extends StatefulWidget {
  const VendorsPage({Key? key}) : super(key: key);

  @override
  State<VendorsPage> createState() => _VendorsPageState();
}

class _VendorsPageState extends State<VendorsPage> {
  late Geoservice geoservice;

  @override
  void initState() {
    super.initState();
    geoservice = Provider.of<Geoservice>(context, listen: false);
    geoservice.getCurrentLocation();
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController businessRegistrationController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController walletController = TextEditingController();
  String _selectedValue = 'Network Type';
  String _selected = 'Zone';
  String _idType = 'Id Type';
  User? user;

  @override
  Widget build(BuildContext context) {
    return Consumer<Geoservice>(
      builder: (__, geoservice, _) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 75),
          child: Column(
            children: [
              SvgPicture.asset(
                'images/logo.svg',
                semanticsLabel: 'korba Logo',
                height: 100,
                width: 100,
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "Register Agent",
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

                     MyDropDownButton(
                      items: ['Id Type', 'Ghana Card' , 'Driver License'],
                       selectedValue: _idType,
                        onChanged: (value){
                          setState(() {
                            _idType = value!;
                          });
                        },
                        ),

                         const SizedBox(
                        height: 15,
                      ),
                      //id_number
                      MyTextField(
                        controller: idNumberController,
                        hintText: "Id Number",
                        obscureText: false,
                      ),
                     
                      // momo type
                      const SizedBox(
                        height: 15,
                      ),

                      MyDropDownButton(
                        items: [
                          'Network Type',
                          'Mtn',
                          'Telecel',
                          'Airtel Tigo'
                        ],
                        selectedValue: _selectedValue,
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value!;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // Wallet number
                      MyTextField(
                        controller: walletController,
                        hintText: "Wallet Number",
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      MyDropDownButton(
                        items: [
                          'Zone',
                          'Greater Accra',
                          'Eastern ',
                          'Middle Belt',
                          'Nothern',
                          'Western',
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
                            businessName: businessNameController.text.isNotEmpty
                                ? businessNameController.text
                                : null,
                            businessRegistration:
                                businessRegistrationController.text.isNotEmpty
                                    ? businessRegistrationController.text
                                    : null,
                            phone: phoneController.text,
                            selectedValue: _selectedValue,
                            selected: _selected,
                            wallet: walletController.text,
                            idNumber: idNumberController.text.isNotEmpty
                                ? idNumberController.text
                                : null,
                            idType: _idType,
                           
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ConfirmDetailsPage(
                                      user: user!,


                                    )),
                          );
                        },
                        text: "Confirm details",
                      ),

                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
