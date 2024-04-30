import 'dart:convert';
import 'package:agent_app/model/td.dart';
import 'package:agent_app/services/momo_custom.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../components/custom_alert_dialogue.dart';
import '../components/custom_color.dart';
import '../components/my_button.dart';
import '../components/my_drop_down_button.dart';
import '../components/my_textform_field.dart';
import '../model/momo.dart';
import '../model/user.dart';
import '../pages/confirm_details_page.dart';
import '../services/auth.dart';
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
    geoservice.startListeningForLocationUpdates();
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController businessRegistrationNumberController =
      TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController momosNumberController = TextEditingController();

  bool isAmbassador = false;
  bool isLandTenureAgent = false;
  List<Momo> momos = [];

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

  void clearControllers() {
    nameController.clear();
    businessNameController.clear();
    businessRegistrationNumberController.clear();
    contactController.clear();
    idNumberController.clear();
    momosNumberController.clear();
    _zone = '';
    _networkType = '';
    _idType = '';
    isAmbassador = false;
    isLandTenureAgent = false;
    Provider.of<MomoCustom>(context, listen: false).clearMomos();

  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    String currentId = auth.user_id;
    return Consumer2<Geoservice, MomoCustom>(
      builder: (__, geoservice, momo, _) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 75),
          child: Form(
            key: _formKey,
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
                        const SizedBox(
                          height: 50,
                        ),
                        MyTextFormField(
                          controller: nameController,
                          labelText: "name",
                          isRequired: true,
                          validator: _nameValidator,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // business name
                        MyTextFormField(
                          controller: businessNameController,
                          labelText: "Business name",
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        // business_registration_number
                        MyTextFormField(
                          controller: businessRegistrationNumberController,
                          labelText: "Business Registration Number",
                          isNumericOnly: true,
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
                          items: ['Ghana Card', 'Driver License'],
                          selectedValue: _idType,
                          onChanged: (value) {
                            setState(() {
                              _idType = value!;
                            });
                          },
                          hintText: 'Id Type',
                        ),

                        const SizedBox(
                          height: 15,
                        ),
                        //id_number
                        MyTextFormField(
                          controller: idNumberController,
                          labelText: "Id Number",
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        ElevatedButton(
                          style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.symmetric(
                                  vertical: 25.0, horizontal: 100.0),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              CustomColors.customColor,
                            ),
                          ),
                          onPressed: () {

                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('MOMO Number Details'),
                                content: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      children: [
                                      
                                        
                                        MyTextFormField(
                                          controller: momosNumberController,
                                          labelText: "Momos Number",
                                          isRequired: true,
                                          isNumericOnly: true,
                                          validator: _nameValidator,
                                         
                                          
                                        ),
                                        const SizedBox(height: 15),
                                        MyDropDownButton(
                                          isRequired: true,
                                          items: ['MTN', 'TELECEL', 'AT'],
                                          selectedValue: _networkType,
                                          validator: _nameValidator,

                                          onChanged: (value) {
                                            _networkType = value!;
                                            setState(() {
                                              _networkType = _networkType;
                                            });
                                          },
                                          hintText: 'Momos Network',
                                        ),
                                        const SizedBox(height: 15),
                                      ],
                                    ),
                                  ),
                                ),
                                actions: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                       TextButton(
                                        onPressed: () {
                                          if(momosNumberController.text.isNotEmpty && _networkType.isNotEmpty){
                                            momo.addMomo(momosNumberController.text, _networkType);
                                          }
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'ok',
                                          style: TextStyle(
                                            color: CustomColors.customColor,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'cancel',
                                          style: TextStyle(
                                            color: CustomColors.customColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                                insetPadding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.1,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "Add Momo number",
                            style: TextStyle(
                              color: Colors.grey.shade100,
                              fontSize: 16.0,
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                          Text('Added Momos:'),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16),
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: momo.momos.length,
                                            itemBuilder: (context, index) {
                                              final item = momo.momos[index];
                                              return ListTile(
                                                title: Text(item.number),
                                                subtitle: Text(item.network),
                                                trailing: IconButton(
                                                  onPressed: (){
                                                    momo.deleteMomo(index);
                                                  },
                                                   icon: Icon(Icons.delete,
                                                   color: CustomColors.customColor,
                                                   ),
                                                   ),
                                              );
                                            },
                                          ),
                                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: SwitchListTile(
                              value: isAmbassador,
                              activeTrackColor: CustomColors.customColor,
                              inactiveTrackColor: Colors.grey.shade300,
                              title: Text('isAmbassdor'),
                              onChanged: (value) {
                                setState(() {
                                  isAmbassador = value;
                                });
                              }),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: SwitchListTile(
                              value: isLandTenureAgent,
                              activeTrackColor: CustomColors.customColor,
                              inactiveTrackColor: Colors.grey.shade300,
                              title: Text('isLandTenureAgent'),
                              onChanged: (value) {
                                setState(() {
                                  isLandTenureAgent = value;
                                });
                              }),
                        ),

                        // Wallet number

                        const SizedBox(
                          height: 15,
                        ),
                        MyDropDownButton(
                          items: [
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
                          },
                          hintText: 'Zone',
                        ),

                        const SizedBox(
                          height: 25,
                        ),
                        MyButton(
                          onTap: () {
                            if (_formKey.currentState!.validate() &&
                                nameController.text.isNotEmpty &&
                                contactController.text.isNotEmpty &&
                                momosNumberController.text.isNotEmpty &&
                                _networkType.isNotEmpty) {
                              _formKey.currentState!.save();

                              final user = User(
                                user_id: currentId,
                                name: nameController.text,
                                business_name:
                                    businessNameController.text.isNotEmpty
                                        ? businessNameController.text
                                        : null,
                                business_registration_number:
                                    businessRegistrationNumberController
                                            .text.isNotEmpty
                                        ? businessRegistrationNumberController
                                            .text
                                        : null,
                                contact: contactController.text,
                                id_number: idNumberController.text.isNotEmpty
                                    ? idNumberController.text
                                    : null,
                                id_type: _idType,
                                momos: momo.momos,
                                is_ambassador: isAmbassador,
                                is_land_tenure_agent: isLandTenureAgent,
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
                                    user: user,
                                    clearControllers: clearControllers,
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
