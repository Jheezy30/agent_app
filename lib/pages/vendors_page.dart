import 'package:agent_app/components/my_button.dart';
import 'package:agent_app/components/my_drop_down_button.dart';
import 'package:agent_app/components/my_textform_field.dart';
import 'package:agent_app/pages/confirm_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../components/custom_alert_dialogue.dart';
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
  final TextEditingController businessRegistrationNumberController =
      TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController momosController = TextEditingController();
  final TextEditingController momosNumberController = TextEditingController();
  final TextEditingController isAmbassadorController = TextEditingController();
  final TextEditingController isLandTenureAgentController = TextEditingController();
  String _networkType = '';
  String _zone = '';
  String _idType = '';
  User? user;
  final _formKey = GlobalKey<FormState>();

  String? _nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }



  @override
  Widget build(BuildContext context) {
    return Consumer<Geoservice>(
      builder: (__, geoservice, _) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 75),
          child: Form(
            key:_formKey,
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
                        const SizedBox(height: 50,),
                        MyTextFormField(
                          controller: nameController,
                          labelText: "Name",
                          isRequired: true,
                          validator: _nameValidator,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // business name
                        MyTextFormField(
                          controller: businessNameController,
                          labelText: "Business Name",
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        // business_registration_number
                        MyTextFormField(
                          controller: businessRegistrationNumberController,
                          labelText: "Business Registration Number",
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        // contact
                        MyTextFormField(
                          controller: contactController,
                          labelText: "contact",
                          isRequired: true,
                          isNumericOnly: true,
                        ),


                        const SizedBox(
                          height: 10,
                        ),

                       MyDropDownButton(
                        items: [ 'Ghana Card' , 'Driver License'],
                         selectedValue: _idType,
                          onChanged: (value){
                            setState(() {
                              _idType = value!;
                            });
                          }, hintText: 'Id Type',
                          ),

                           const SizedBox(
                          height: 15,
                        ),
                        //id_number
                        MyTextFormField(
                          controller: idNumberController,
                          labelText: "Id Number",
                        ),

                        const SizedBox(height: 10,),
                        MyTextFormField(
                          controller: momosController,
                          labelText: "Momos",
                          isRequired: true,
                          isNumericOnly: true,
                          validator: _nameValidator,

                        ),

                        const SizedBox(height: 10,),
                        MyTextFormField(
                          controller: momosNumberController,
                          labelText: "Momos Number",
                          isRequired: true,
                          isNumericOnly: true,
                          validator: _nameValidator,

                        ),


                        // momo type
                        const SizedBox(
                          height: 15,
                        ),

                        MyDropDownButton(
                          items: [
                            'MTN',
                            'Telecel',
                            'AirtelTigo'
                          ],
                          selectedValue: _networkType,
                          validator: _nameValidator,
                          onChanged: (value) {
                            setState(() {
                              _networkType = value!;
                            });
                          }, hintText: 'Momos Network',
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        // Wallet number
                        MyTextFormField(
                          controller: isAmbassadorController,
                          labelText: "isAmbassador",
                        ),
                        const SizedBox(height: 10,),
                        MyTextFormField(
                          controller: isLandTenureAgentController,
                          labelText: "isLandTenureAgent",
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
                          selectedValue: _zone,
                          onChanged: (value) {
                            setState(() {
                              _zone = value!;
                            });
                          }, hintText: 'Zone',
                        ),

                        const SizedBox(
                          height: 25,
                        ),
                        MyButton(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              user = User(
                                name: nameController.text,
                                businessName:
                                businessNameController.text.isNotEmpty
                                    ? businessNameController.text
                                    : null,
                                businessRegistrationNumber:
                                businessRegistrationNumberController
                                    .text.isNotEmpty
                                    ? businessRegistrationNumberController
                                    .text
                                    : null,
                                contact: contactController.text,
                                idNumber: idNumberController.text.isNotEmpty
                                    ? idNumberController.text
                                    : null,
                                idType: _idType,
                                momos: momosController.text,
                                momosNumber: momosNumberController.text,
                                momosNetwork: _networkType,
                                isAmbassador:
                                isAmbassadorController.text.isNotEmpty
                                    ? isAmbassadorController.text
                                    : null,
                                isLandTenureAgent:
                                isLandTenureAgentController.text.isNotEmpty
                                    ? isAmbassadorController.text
                                    : null,
                                zone: _zone,
                                location: '${geoservice.town ?? 'N/A'}',
                                longitude:
                                '${geoservice.currentPosition?.longitude ?? 'N/A'}',
                                latitude:
                                '${geoservice.currentPosition?.latitude ?? 'N/A'}',
                              );




                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ConfirmDetailsPage(
                                    user: user!,
                                  ),
                                ),
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => CustomAlertDialog(
                                  title: 'Empty Fields',
                                  message:
                                  'Please fill in all required fields.',
                                ),
                              );
                            }
                          },
                          text: 'Confirm details',
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
      ),
    );
  }
}
