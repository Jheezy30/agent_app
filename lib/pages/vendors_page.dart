import 'dart:convert';
import 'package:agent_app/model/td.dart';
import 'package:agent_app/pages/login_page.dart';
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
import '../components/text_divider.dart';
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
 

  User? user;

  final _formKey = GlobalKey<FormState>();

  String? _nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }
   final TextEditingController nameController = TextEditingController();
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController businessRegistrationNumberController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController momosNumberController = TextEditingController();

  bool isAmbassador = false;
  bool isLandTenureAgent = false;
  List<Momo> momos = [];

  String networkType = '';
  String zone = '';
  String idType = '';

  void clearControllers() {
    nameController.clear();
    businessNameController.clear();
    businessRegistrationNumberController.clear();
    contactController.clear();
    idNumberController.clear();
    momosNumberController.clear();
    zone = '';
    networkType = '';
    idType = '';
    isAmbassador = false;
    isLandTenureAgent = false;
    momos = [];
  }

  

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    String currentId = auth.user_id;
    return Consumer2<Geoservice, MomoCustom>(
      builder: (__, geoservice, momo, _) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: SvgPicture.asset(
                                'images/logo.svg',
                                semanticsLabel: 'korba Logo',
                                height: 35,
                                width: 35,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              child: Text(
                                "Register Vendor",
                                style: TextStyle(
                                  color: Colors.grey.shade900,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          //name field
                          const SizedBox(
                            height: 25,
                          ),
                          TextDivider(
                            text: 'Personal Details',
                            width: 350,
                            height: 1,
                            textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade900,
                            ),
                            padding: EdgeInsets.only(left: 8, top: 8),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          MyTextFormField(
                            controller: nameController,
                            labelText: "Name",
                            isRequired: true,
                            validator: _nameValidator,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          MyTextFormField(
                            controller: contactController,
                            labelText: "Contact",
                            isRequired: true,
                            isNumericOnly: true,
                          ),
                          // business name

                          const SizedBox(
                            height: 10,
                          ),
                          MyDropDownButton(
                            items: ['Ghana Card', 'Driver License'],
                            selectedValue: idType,
                            onChanged: (value) {
                              setState(() {
                                idType = value!;
                              });
                            },
                            hintText: 'Id Type',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          //id_number
                          MyTextFormField(
                            controller: idNumberController,
                            labelText: "Id Number",
                          ),

                          const SizedBox(
                            height: 50,
                          ),

                          TextDivider(
                            text: 'Business Details',
                            width: 350,
                            height: 1,
                            textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade900,
                            ),
                            padding: EdgeInsets.only(left: 8, top: 8),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          MyTextFormField(
                            controller:businessNameController,
                            labelText: "Business Name",
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          MyTextFormField(
                            controller:businessRegistrationNumberController,
                            labelText: "Business Registration Number",
                            isNumericOnly: true,
                          ),

                          const SizedBox(
                            height: 50,
                          ),

                          TextDivider(
                            text: 'Momos Details',
                            width: 350,
                            height: 1,
                            textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade900,
                            ),
                            padding: EdgeInsets.only(left: 8, top: 8),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          ElevatedButton(
                            style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all<EdgeInsetsGeometry>(
                                EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 100.0),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                CustomColors.customColor.shade800,
                              ),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Momo Number Details'),
                                  content: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        children: [
                                          MyTextFormField(
                                            controller:momosNumberController,
                                            labelText: "Momos Number",
                                            isRequired: true,
                                            isNumericOnly: true,
                                            validator: _nameValidator,
                                          ),
                                          const SizedBox(height: 15),
                                          MyDropDownButton(
                                            isRequired: true,
                                            items: ['MTN', 'TELECEL', 'AT'],
                                            selectedValue: networkType,
                                            validator: _nameValidator,
                                            onChanged: (value) {
                                            networkType = value!;
                                              setState(() {
                                              networkType = networkType;
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
                                            if ( momosNumberController
                                                    .text.isNotEmpty &&
                                              networkType.isNotEmpty) {
                                              momo.addMomo(
                                                 momosNumberController.text,
                                                networkType);
                                            }
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'ok',
                                            style: TextStyle(
                                              color: CustomColors.customColor,
                                              fontSize: 18,
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
                                              fontSize: 18,
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
                              "Add Momo Number",
                              style: TextStyle(
                                color: Colors.grey.shade100,
                                fontSize: 15.0,
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 25,
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (momo.momos.isNotEmpty)
                                Center(child: Text('Added Momos:')),
                              if (momo.momos.isEmpty)
                                Text('Momos Unavailable:'),
                              if (momo.momos.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: momo.momos.length,
                                    itemBuilder: (context, index) {
                                      final item = momo.momos[index];
                                      return ListTile(
                                        title: Text(item.number),
                                        subtitle: Text(item.network),
                                        trailing: IconButton(
                                          onPressed: () {
                                            momo.deleteMomo(index);
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: CustomColors.customColor,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                            ],
                          ),

                          const SizedBox(
                            height: 50,
                          ),

                          TextDivider(
                            text: 'Other Details',
                            width: 350,
                            height: 1,
                            textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade900,
                            ),
                            padding: EdgeInsets.only(left: 8, top: 8),
                          ),

                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: SwitchListTile(
                                value:isAmbassador,
                                activeTrackColor: CustomColors.customColor,
                                inactiveTrackColor: Colors.grey.shade300,
                                title: Text('IsAmbassdor'),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: SwitchListTile(
                                value:isLandTenureAgent,
                                activeTrackColor: CustomColors.customColor,
                                inactiveTrackColor: Colors.grey.shade300,
                                title: Text('IsLandTenureAgent'),
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
                            selectedValue:zone,
                            onChanged: (value) {
                              setState(() {
                               zone = value!;
                              });
                            },
                            hintText: 'Zone',
                          ),

                          const SizedBox(
                            height: 25,
                          ),
                          geoservice.isLoading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      CustomColors.customColor),
                                ) // Show progress indicator while loading
                              : MyButton(
                                  onTap: () async {
                                    if (_formKey.currentState!.validate() &&
                                       nameController.text.isNotEmpty &&
                                       contactController.text.isNotEmpty &&
                                       momosNumberController.text.isNotEmpty &&
                                       networkType.isNotEmpty) {
                                      _formKey.currentState!.save();

                                      // Perform geoservice.search() and other necessary operations
                                      await geoservice.search();

                                      // Ensure all necessary data is collected and assigned to user object
                                      final user = User(
                                        user_id: currentId,
                                        name: nameController.text,
                                        business_name:businessNameController
                                                .text.isNotEmpty
                                            ? businessNameController.text
                                            : 'N/A',	
                                        business_registration_number:
                                           businessRegistrationNumberController
                                                    .text.isNotEmpty
                                                ? businessRegistrationNumberController
                                                    .text
                                                : 'N/A',
                                        contact:contactController.text,
                                        id_number:
                                           idNumberController.text.isNotEmpty
                                                ? idNumberController.text
                                                : 'N/A',
                                        id_type:idType,
                                        momos: momo.momos,
                                        is_ambassador:isAmbassador,
                                        is_land_tenure_agent:isLandTenureAgent,
                                        zone:zone,
                                        location: '${geoservice.location}',
                                        region: '${geoservice.region}',
                                        longitude:
                                            '${geoservice.currentPosition?.longitude}',
                                        latitude:
                                            '${geoservice.currentPosition?.latitude}',
                                      );

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ConfirmDetailsPage(
                                            user: user, clearControllers: clearControllers,
                                          ),
                                        ),
                                      );
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text('Empty Fields'),
                                          content: Text(
                                              'Please fill in all required fields.'),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              child: Text('OK'),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                  text: 'Confirm Details',
                                ),

                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
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

