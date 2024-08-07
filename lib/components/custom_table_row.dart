import 'package:agent_app/components/custom_color.dart';
import 'package:agent_app/components/my_drop_down_button.dart';
import 'package:agent_app/model/momo.dart';
import 'package:agent_app/pages/vendors_page.dart';
import 'package:agent_app/services/momo_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';

class CustomTableRow extends StatefulWidget {
  final User user;

  const CustomTableRow({super.key, required this.user});

  @override
  State<CustomTableRow> createState() => _CustomTableRowState();
}

class _CustomTableRowState extends State<CustomTableRow> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<MomoCustom,FormController>(builder: (__, momo,formController, _) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Table(
            textDirection: TextDirection.ltr,
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: TableBorder(
              bottom: BorderSide(
                color: Colors.grey.shade300,
                width: 1.0,
              ),
              horizontalInside:
                  BorderSide(color: Colors.grey.shade300, width: 1.0),
            ),
            children: [
              TableRow(children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Confirm Details",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  verticalAlignment: TableCellVerticalAlignment.middle,
                ),
                SizedBox(), // Spacer for the second cell in the header row
              ]),
              confirmationTableRow(
                title: 'Name',
                info: '${widget.user.name}',
              ),
              confirmationTableRow(
                title: 'Id Type',
                info: '${widget.user.id_type}',
              ),
              confirmationTableRow(
                title: 'Id Number',
                info: '${widget.user.id_number}',
              ),
            ],
          ),
          SizedBox(height: 50), // Space between tables
          Table(
            textDirection: TextDirection.ltr,
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: TableBorder(
              bottom: BorderSide(
                color: Colors.grey.shade300,
                width: 1.0,
              ),
              horizontalInside:
                  BorderSide(color: Colors.grey.shade300, width: 1.0),
            ),
            children: [
              TableRow(children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Business Details",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  verticalAlignment: TableCellVerticalAlignment.middle,
                ),
                SizedBox(), // Spacer for the second cell in the header row
              ]),
              confirmationTableRow(
                title: 'Business Name',
                info: '${widget.user.business_name}',
              ),
              confirmationTableRow(
                title: 'Business Registration Number',
                info: '${widget.user.business_registration_number}',
              ),
              confirmationTableRow(
                title: 'Phone Number',
                info: '${widget.user.contact}',
              ),
            ],
          ),
          SizedBox(height: 50),

          Table(
            textDirection: TextDirection.ltr,
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: TableBorder(
              bottom: BorderSide(
                color: Colors.grey.shade300,
                width: 1.0,
              ),
              horizontalInside:
                  BorderSide(color: Colors.grey.shade300, width: 1.0),
            ),
            children: [
              TableRow(children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Momos Details",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  verticalAlignment: TableCellVerticalAlignment.middle,
                ),
                SizedBox(), // Spacer for the second cell in the header row
              ]),
              ...List.generate(momo.momos.length, (index) {
                final item = momo.momos[index];
                return confirmationTableRow(
                    title: item.network, info: item.number);
              }),
            ],
          ),

          const SizedBox(
            height: 50,
          ),

          // Space between tables
          Table(
            textDirection: TextDirection.ltr,
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: TableBorder(
              bottom: BorderSide(
                color: Colors.grey.shade300,
                width: 1.0,
              ),
              horizontalInside:
                  BorderSide(color: Colors.grey.shade300, width: 1.0),
            ),
            children: [
              TableRow(children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Other Details",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  verticalAlignment: TableCellVerticalAlignment.middle,
                ),
                SizedBox(), // Spacer for the second cell in the header row
              ]),
              confirmationTableRow(
                title: 'isAmbassador',
                info: '${widget.user.is_ambassador}',
              ),
              confirmationTableRow(
                title: 'isLandTenureAgent',
                info: '${widget.user.is_land_tenure_agent}',
              ),
              confirmationTableRow(
                title: 'Longitude',
                info: '${widget.user.longitude}',
              ),
              confirmationTableRow(
                title: 'Latitude',
                info: '${widget.user.latitude}',
              ),
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("Zone"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 12, left: 5, right: 20),
                  child: MyDropDownButton(
                            items: [
                              'Greater Accra',
                              'Eastern ',
                              'Middle Belt',
                              'Nothern',
                              'Western',
                            ],
                            selectedValue:formController.zone ,
                            onChanged: (value) {
                              setState(() {
                               formController.zone = value!;
                              });
                            },
                            hintText: 'Zone',
                          ),
                ),
              ]),
              confirmationTableRow(
                title: 'Location',
                info: '${widget.user.location}',
              ),
              confirmationTableRow(
                title: 'Region',
                info: '${widget.user.region}',
              ),
            ],
          ),
        ],
      ),
    
    );
  }
}

TableRow confirmationTableRow({required String title, required String info}) {
  return TableRow(
    children: [
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          info,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    ],
  );
}
