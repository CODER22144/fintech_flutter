import 'dart:convert';

import 'package:fintech_new_web/features/network/service/network_service.dart';
import 'package:fintech_new_web/features/purchaseOrder/provider/purchase_order_provider.dart';
import 'package:fintech_new_web/features/utility/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';

class PurchaseOrderRowFields extends StatefulWidget {
  final int index;
  final List<List<String>> tableRows;
  final Function deleteRow;
  final List<SearchableDropdownMenuItem<String>> priority;
  final List<SearchableDropdownMenuItem<String>> poType;
  const PurchaseOrderRowFields(
      {super.key,
      required this.index,
      required this.tableRows,
      required this.deleteRow, required this.priority, required this.poType});

  @override
  State<PurchaseOrderRowFields> createState() => _PurchaseOrderRowFieldsState();
}

class _PurchaseOrderRowFieldsState extends State<PurchaseOrderRowFields> {
  TextEditingController dateController = TextEditingController();
  TextEditingController hsnController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context, int index) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        dateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
        widget.tableRows[index][2] =
            DateFormat('MM-dd-yyyy').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 10),
              child: Text(
                "Item : ${widget.index + 1}",
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 10),
              child: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  widget.deleteRow(widget.index);
                },
              ),
            )
          ],
        ),
        Focus(
          onFocusChange: (hasFocus) async {
            if (!hasFocus) {
              NetworkService networkService = NetworkService();

              http.StreamedResponse response = await networkService.post(
                  "/get-material-source-details/", {"matno" : widget.tableRows[widget.index][0], "bpCode" : GlobalVariables.requestBody[PurchaseOrderProvider.featureName]['bpCode']});
              if (response.statusCode == 200) {
                var data = jsonDecode(await response.stream.bytesToString())[0];
                setState(() {
                  rateController.text = data['bpRate'];
                  hsnController.text = data['hsnCode'];
                });
              }
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: widget.tableRows[widget.index][0],
              onChanged: (value) async {
                setState(() {
                  widget.tableRows[widget.index][0] = value;
                });
              },
              decoration: InputDecoration(
                label: RichText(
                  text: const TextSpan(
                    text: "Material No.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 0),
                ),
              ),
              validator: (String? val) {
                if (val == null || val.isEmpty) {
                  return 'Material No. is Mandatory';
                }
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            validator: (String? val) {
              if (val == null || val.isEmpty) {
                return 'Quantity is Mandatory';
              }
            },
            initialValue: widget.tableRows[widget.index][1],
            onChanged: (value) {
              setState(() {
                widget.tableRows[widget.index][1] = value;
              });
            },
            decoration: InputDecoration(
              label: RichText(
                text: const TextSpan(
                  text: "Quantity",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 0),
              ),
            ),
          ),
        ),

        // DISPLAY ONLY FIELD

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            readOnly: true,
            controller: rateController,
            decoration: InputDecoration(
              label: RichText(
                text: const TextSpan(
                  text: "Rate",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 0),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            readOnly: true,
            controller: hsnController,
            decoration: InputDecoration(
              label: RichText(
                text: const TextSpan(
                  text: "HSN Code",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 0),
              ),
            ),
          ),
        ),

        // END DISPLAY

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: dateController,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: "Select Date...",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
              ),
              label: RichText(
                text: const TextSpan(
                  text: "Delivery Date",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                  children: [
                    TextSpan(text: "*", style: TextStyle(color: Colors.red))
                  ],
                ),
              ),
            ),
            readOnly: true,
            onTap: () => _selectDate(context, widget.index),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Delivery date field is Mandatory';
              }
            },
          ),
        ),
        Stack(
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: SearchableDropdown<String>(
                  isEnabled: true,
                  backgroundDecoration: (child) => Container(
                    height: 40,
                    margin: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black, width: 0.5),
                    ),
                    child: child,
                  ),
                  items: widget.poType,
                  onChanged: (value) {
                    setState(() {
                      widget.tableRows[widget.index][4] = value!;
                    });
                  },
                  hasTrailingClearIcon: false,
                )),
            Positioned(
              left: 15,
              top: 1,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: const Wrap(
                  children: [
                    Text(
                      "PO Type",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Stack(
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: SearchableDropdown<String>(
                  isEnabled: true,
                  backgroundDecoration: (child) => Container(
                    height: 40,
                    margin: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black, width: 0.5),
                    ),
                    child: child,
                  ),
                  items: widget.priority,
                  onChanged: (value) {
                    setState(() {
                      widget.tableRows[widget.index][3] = value!;
                    });
                  },
                  hasTrailingClearIcon: false,
                )),
            Positioned(
              left: 15,
              top: 1,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: const Wrap(
                  children: [
                    Text(
                      "Priority",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
