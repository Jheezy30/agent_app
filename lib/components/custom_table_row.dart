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
    // TODO: implement initState
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
          child: CircularProgressIndicator(),
        );
      }
      return Table(
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
            title: 'Business Name',
            info: '${widget.user.businessName}',
          ),
          confirmationTableRow(
            title: 'Business Registration Number',
            info: '${widget.user.businessRegistration}',
          ),
          confirmationTableRow(
            title: 'Phone Number',
            info: '${widget.user.phone}',
          ),
          confirmationTableRow(
            title: 'Id Number',
            info: '${widget.user.idNumber}',
          ),
          confirmationTableRow(
            title: 'Id Type',
            info: '${widget.user.idType}',
          ),
          confirmationTableRow(
            title: 'Network Type',
            info: '${widget.user.selectedValue}',
          ),
          confirmationTableRow(
            title: 'Wallet Number',
            info: '${widget.user.wallet}',
          ),
          confirmationTableRow(
            title: 'Zone',
            info: '${widget.user.selected}',
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
