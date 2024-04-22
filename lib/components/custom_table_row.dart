import 'package:agent_app/components/custom_color.dart';
import 'package:agent_app/model/momo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';
import '../services/geo_service.dart';

class CustomTableRow extends StatefulWidget {
  final User user;

  const CustomTableRow({super.key, required this.user});

  @override
  State<CustomTableRow> createState() => _CustomTableRowState();
}

class _CustomTableRowState extends State<CustomTableRow> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<Geoservice>().search();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Geoservice>(builder: (__, geo, _) {
      if (geo.isLoading) {
        return Center(
          child: CircularProgressIndicator(
             valueColor: AlwaysStoppedAnimation<Color>(CustomColors.customColor),
          ),
        );
      }
      return Column(
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
              horizontalInside: BorderSide(color: Colors.grey.shade300, width: 1.0),
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
              horizontalInside: BorderSide(color: Colors.grey.shade300, width: 1.0),
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
          SizedBox(height: 50), // Space between tables
          Table(
            textDirection: TextDirection.ltr,
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: TableBorder(
              bottom: BorderSide(
                color: Colors.grey.shade300,
                width: 1.0,
              ),
              horizontalInside: BorderSide(color: Colors.grey.shade300, width: 1.0),
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
             
              ...List.generate(widget.user.momos.length, (index) {
                Momo momo = widget.user.momos[index];
                return confirmationTableRow(title: momo.network, info: momo.number);
              }),
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
                info: '${geo.currentPosition?.longitude ?? 'N/A'}',
              ),
              confirmationTableRow(
                title: 'Latitude',
                info: '${geo.currentPosition?.latitude ?? 'N/A'}',
              ),
              confirmationTableRow(
                title: 'Address',
                info: '${geo.address ?? 'N/A'}',
              ),
              confirmationTableRow(
                title: 'location',
                info: '${geo.location ?? 'N/A'}',
              ),
              confirmationTableRow(
                title: 'Region',
                info: '${geo.region ?? 'N/A'}',
              ),
              confirmationTableRow(
                title: 'Municipality',
                info: '${geo.district ?? 'N/A'}',
              ),
              confirmationTableRow(
                title: 'Suburb',
                info: '${geo.town ?? 'N/A'}',
              ),
            ],
          ),
        ],
      );
    });
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