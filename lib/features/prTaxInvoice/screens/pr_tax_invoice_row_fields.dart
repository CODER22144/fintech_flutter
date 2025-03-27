import 'dart:convert';

import 'package:fintech_new_web/features/utility/services/common_utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';

import '../../common/widgets/pop_ups.dart';
import '../../network/service/network_service.dart';

class PrTaxInvoiceRowFields extends StatefulWidget {
  final int index;
  final List<List<String>> tableRows;
  final List<SearchableDropdownMenuItem<String>> discountType;
  final Function deleteRow;
  const PrTaxInvoiceRowFields(
      {super.key,
        required this.index,
        required this.tableRows,
        required this.discountType,
        required this.deleteRow});

  @override
  State<PrTaxInvoiceRowFields> createState() => _PrTaxInvoiceRowFieldsState();
}

class _PrTaxInvoiceRowFieldsState extends State<PrTaxInvoiceRowFields> {
  bool checkRatePercentage = true;
  bool checkDiscAmount = true;

  double amount = 0;
  double discAmount = 0;
  double cessAmount = 0;
  double gstAmount = 0;
  double totalAmount = 0;

  TextEditingController discAmountController = TextEditingController(text: '0');
  TextEditingController discRateController = TextEditingController(text: '0');
  TextEditingController hsnController = TextEditingController();
  TextEditingController materialController = TextEditingController();
  TextEditingController rateController = TextEditingController();

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
                "SNo. : ${widget.index + 1}",
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.black),
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: widget.tableRows[widget.index][0],
            onChanged: (value) {
              setState(() {
                widget.tableRows[widget.index][0] = value;
              });
            },
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              label: RichText(
                text: const TextSpan(
                  text: "Narration",
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
          child: Focus(
            onFocusChange: (hasFocus) async {
              if(!hasFocus && materialController.text == "") {
                hsnController.text = "";
                setState(() {
                  widget.tableRows[widget.index][6] = "0";
                  widget.tableRows[widget.index][2] = hsnController.text;
                  widget.tableRows[widget.index][15] = "0";
                });
              }
              if(!hasFocus && materialController.text!= null && materialController.text != "") {
                setState(() {
                  widget.tableRows[widget.index][1] = materialController.text;
                });

                NetworkService networkService = NetworkService();
                http.StreamedResponse response = await networkService.get("/get-mat-details/${materialController.text}/");
                var matDetails = jsonDecode(await response.stream.bytesToString())[0];
                if(response.statusCode == 200){

                  hsnController.text = matDetails['hsnCode'] ?? "";
                  setState(() {
                    widget.tableRows[widget.index][6] = matDetails['prate'] ?? "0";
                    widget.tableRows[widget.index][2] = hsnController.text;
                    widget.tableRows[widget.index][15] = matDetails['gstTaxRate'] ?? "0";
                  });
                } else {
                  hsnController.text = "";
                  setState(() {
                    widget.tableRows[widget.index][6] = "0";
                    widget.tableRows[widget.index][2] = hsnController.text;
                    widget.tableRows[widget.index][15] = "0";
                  });
                  showAlertDialog(context, "Invalid Material no.", "Continue", false);
                }
              }
              calculateTotalAmount(widget.index);
            },
            child: TextFormField(
              controller: materialController,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
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
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Focus(
            onFocusChange: (hasFocus) async {
              if (!hasFocus) {
                setState(() {
                  widget.tableRows[widget.index][2] = hsnController.text;
                });
                NetworkService networkService = NetworkService();
                dynamic hsnDetails;
                if (hsnController.text != null && hsnController.text != "") {
                  http.StreamedResponse response = await networkService
                      .get("/get-hsn/${hsnController.text}/");
                  if (response.statusCode == 200) {
                    hsnDetails =
                        jsonDecode(await response.stream.bytesToString())[0]
                        ['gstTaxRate'] ??
                            "0";
                    setState(() {
                      widget.tableRows[widget.index][15] = hsnDetails;
                    });
                  } else {
                    setState(() {
                      widget.tableRows[widget.index][15] = "0";
                    });
                    showAlertDialog(context, "Invalid Hsn Code", "Okay", false);
                  }
                  calculateTotalAmount(widget.index);
                }
              }
            },
            child: TextFormField(
              validator: (String? val) {
                if (val == null || val.isEmpty) {
                  return 'This field is Mandatory';
                }
              },
              controller: hsnController,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                label: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "*",
                        style: TextStyle(color: Colors.red),
                      )
                    ],
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
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: widget.tableRows[widget.index][3],
            onChanged: (value) {
              setState(() {
                widget.tableRows[widget.index][3] = value;
              });
            },
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              label: RichText(
                text: const TextSpan(
                  text: "Bill No.",
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
            initialValue: widget.tableRows[widget.index][4],
            onChanged: (value) {
              setState(() {
                widget.tableRows[widget.index][4] = value;
              });
            },
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              label: RichText(
                text: const TextSpan(
                  text: "Bill Date",
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
            validator: (String? val) {
              if (val == null || val.isEmpty) {
                return 'This field is Mandatory';
              }
            },
            initialValue: widget.tableRows[widget.index][5],
            onChanged: (value) {
              setState(() {
                widget.tableRows[widget.index][5] = value;
              });
              calculateTotalAmount(widget.index);
            },
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              label: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "*",
                      style: TextStyle(color: Colors.red),
                    )
                  ],
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            validator: (String? val) {
              if (val == null || val.isEmpty) {
                return 'This field is Mandatory';
              }
            },
            controller: rateController,
            onChanged: (value) {
              setState(() {
                widget.tableRows[widget.index][6] = value;
                rateController.selection = TextSelection.fromPosition(
                    TextPosition(offset: rateController.text.length));
              });
              calculateTotalAmount(widget.index);
            },
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              label: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "*",
                      style: TextStyle(color: Colors.red),
                    )
                  ],
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
            controller:
            TextEditingController(text: widget.tableRows[widget.index][7]),
            validator: (String? val) {
              if (val == null || val.isEmpty) {
                return 'This field is Mandatory';
              }
            },
            onChanged: (value) {
              setState(() {
                widget.tableRows[widget.index][7] = value;
              });
            },
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              label: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "*",
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                  text: "Amount",
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
        Stack(
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: SearchableDropdown<String>(
                  controller: SearchableDropdownController<String>(
                      initialItem: const SearchableDropdownMenuItem(
                          value: "N",
                          label: "None",
                          child: Text("None"))),
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
                  items: widget.discountType,
                  onChanged: (value) {
                    setState(() {
                      widget.tableRows[widget.index][8] = value!;
                      if (value == "N") {
                        widget.tableRows[widget.index][9] = "0"; // disc Rate
                        widget.tableRows[widget.index][10] = "0"; // disc Amount
                        discAmountController.text = "0";
                        discRateController.text = "0";
                        discAmount = 0;
                        checkRatePercentage = true;
                        checkDiscAmount = true;
                      }
                      if (value == "F") {
                        widget.tableRows[widget.index][9] = "0"; // disc Rate
                        widget.tableRows[widget.index][10] = "0"; // disc Amount
                        discAmountController.text = "0";
                        discRateController.text = "0";
                        discAmount = 0;
                        checkRatePercentage = true;
                        checkDiscAmount = false;
                      }
                      if (value == "P") {
                        discAmountController.text = "0";
                        checkRatePercentage = false;
                        checkDiscAmount = false;
                      }
                    });
                    calculateTotalAmount(widget.index);
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
                      "Discount Type",
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            validator: (String? val) {
              if (val == null || val.isEmpty) {
                return 'This field is Mandatory';
              }
            },
            readOnly: checkRatePercentage,
            controller: discRateController,
            onChanged: (value) {
              setState(() {
                widget.tableRows[widget.index][9] = value;
                if (widget.tableRows[widget.index][8] == "P") {
                  discAmount =
                      parseEmptyStringToDouble(widget.tableRows[widget.index][5]) *
                          parseEmptyStringToDouble(widget.tableRows[widget.index][6]) *
                          parseEmptyStringToDouble(widget.tableRows[widget.index][9]) *
                          0.01;

                  widget.tableRows[widget.index][10] =
                      discAmount.toStringAsFixed(2);
                  discAmountController.text = discAmount.toStringAsFixed(2);

                  setState(() {
                    gstAmount =
                        ((parseEmptyStringToDouble(widget.tableRows[widget.index][5]) *
                            parseEmptyStringToDouble(
                                widget.tableRows[widget.index][6])) -
                            discAmount) *
                            parseEmptyStringToDouble(widget.tableRows[widget.index][15]) *
                            0.01;
                    widget.tableRows[widget.index][16] =
                        gstAmount.toStringAsFixed(2);
                  });

                  setState(() {
                    cessAmount =
                        ((parseEmptyStringToDouble(widget.tableRows[widget.index][5]) *
                            parseEmptyStringToDouble(
                                widget.tableRows[widget.index][6])) -
                            parseEmptyStringToDouble(discAmountController.text)) *
                            parseEmptyStringToDouble(widget.tableRows[widget.index][13]) *
                            0.01;
                    widget.tableRows[widget.index][14] =
                        cessAmount.toStringAsFixed(2);
                    totalAmount =
                        ((parseEmptyStringToDouble(widget.tableRows[widget.index][5]) *
                            parseEmptyStringToDouble(
                                widget.tableRows[widget.index][6])) -
                            discAmount) +
                            cessAmount +
                            gstAmount +
                            parseEmptyStringToDouble(widget.tableRows[widget.index][17]) +
                            parseEmptyStringToDouble(widget.tableRows[widget.index][11]) +
                            parseEmptyStringToDouble(widget.tableRows[widget.index][12]);
                    widget.tableRows[widget.index][18] =
                        totalAmount.toStringAsFixed(2);
                  });
                }
                discRateController.selection = TextSelection.fromPosition(
                    TextPosition(offset: discRateController.text.length));
              });
            },
            decoration: InputDecoration(
              label: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "*",
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                  text: "Discount Percentage",
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
            validator: (String? val) {
              if (val == null || val.isEmpty) {
                return 'This field is Mandatory';
              }
            },
            controller: discAmountController,
            readOnly: checkDiscAmount,
            onChanged: (value) {
              setState(() {
                if (widget.tableRows[widget.index][8] == "F") {
                  widget.tableRows[widget.index][10] = value;
                  widget.tableRows[widget.index][9] = "0";
                  discAmount = parseEmptyStringToDouble(value);
                  discAmountController.text = value;

                  setState(() {
                    gstAmount =
                        ((parseEmptyStringToDouble(widget.tableRows[widget.index][5]) *
                            parseEmptyStringToDouble(
                                widget.tableRows[widget.index][6])) -
                            discAmount) *
                            parseEmptyStringToDouble(widget.tableRows[widget.index][15]) *
                            0.01;
                    widget.tableRows[widget.index][16] =
                        gstAmount.toStringAsFixed(2);
                  });

                  setState(() {
                    cessAmount =
                        ((parseEmptyStringToDouble(widget.tableRows[widget.index][5]) *
                            parseEmptyStringToDouble(
                                widget.tableRows[widget.index][6])) -
                            parseEmptyStringToDouble(discAmountController.text)) *
                            parseEmptyStringToDouble(widget.tableRows[widget.index][13]) *
                            0.01;
                    widget.tableRows[widget.index][14] =
                        cessAmount.toStringAsFixed(2);
                    totalAmount =
                        ((parseEmptyStringToDouble(widget.tableRows[widget.index][5]) *
                            parseEmptyStringToDouble(
                                widget.tableRows[widget.index][6])) -
                            discAmount) +
                            cessAmount +
                            gstAmount +
                            parseEmptyStringToDouble(widget.tableRows[widget.index][17]) +
                            parseEmptyStringToDouble(widget.tableRows[widget.index][11]) +
                            parseEmptyStringToDouble(widget.tableRows[widget.index][12]);
                    widget.tableRows[widget.index][18] =
                        totalAmount.toStringAsFixed(2);
                  });
                }
                discAmountController.selection = TextSelection.fromPosition(
                    TextPosition(offset: discAmountController.text.length));
              });
            },
            decoration: InputDecoration(
              label: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "*",
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                  text: "Discount Amount",
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
        Visibility(
          visible: false,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: widget.tableRows[widget.index][11],
              onChanged: (value) {
                setState(() {
                  widget.tableRows[widget.index][11] = value;

                  setState(() {
                    gstAmount =
                        ((parseEmptyStringToDouble(widget.tableRows[widget.index][5]) *
                            parseEmptyStringToDouble(
                                widget.tableRows[widget.index][6])) -
                            discAmount) *
                            parseEmptyStringToDouble(widget.tableRows[widget.index][15]) *
                            0.01;
                    widget.tableRows[widget.index][16] =
                        gstAmount.toStringAsFixed(2);
                  });

                  setState(() {
                    cessAmount =
                        ((parseEmptyStringToDouble(widget.tableRows[widget.index][5]) *
                            parseEmptyStringToDouble(
                                widget.tableRows[widget.index][6])) -
                            parseEmptyStringToDouble(discAmountController.text)) *
                            parseEmptyStringToDouble(widget.tableRows[widget.index][13]) *
                            0.01;
                    widget.tableRows[widget.index][14] =
                        cessAmount.toStringAsFixed(2);
                    totalAmount =
                        ((parseEmptyStringToDouble(widget.tableRows[widget.index][5]) *
                            parseEmptyStringToDouble(
                                widget.tableRows[widget.index][6])) -
                            discAmount) +
                            cessAmount +
                            gstAmount +
                            parseEmptyStringToDouble(widget.tableRows[widget.index][17]) +
                            parseEmptyStringToDouble(widget.tableRows[widget.index][11]) +
                            parseEmptyStringToDouble(widget.tableRows[widget.index][12]);
                    widget.tableRows[widget.index][18] =
                        totalAmount.toStringAsFixed(2);
                  });
                });
              },
              decoration: InputDecoration(
                label: RichText(
                  text: const TextSpan(
                    text: "Basic Custom Duty (BCD)",
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
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            validator: (String? val) {
              if (val == null || val.isEmpty) {
                return 'This field is Mandatory';
              }
            },
            initialValue: widget.tableRows[widget.index][12],
            onChanged: (value) {
              setState(() {
                widget.tableRows[widget.index][12] = value;
                totalAmount =
                    ((parseEmptyStringToDouble(widget.tableRows[widget.index][5]) *
                        parseEmptyStringToDouble(
                            widget.tableRows[widget.index][6])) -
                        discAmount) +
                        cessAmount +
                        gstAmount +
                        parseEmptyStringToDouble(widget.tableRows[widget.index][17]) +
                        parseEmptyStringToDouble(widget.tableRows[widget.index][11]) +
                        parseEmptyStringToDouble(value);
                widget.tableRows[widget.index][18] =
                    totalAmount.toStringAsFixed(2);
              });
            },
            decoration: InputDecoration(
              label: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "*",
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                  text: "Round Off.",
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
            validator: (String? val) {
              if (val == null || val.isEmpty) {
                return 'This field is Mandatory';
              }
            },
            initialValue: widget.tableRows[widget.index][13],
            onChanged: (value) {
              setState(() {
                widget.tableRows[widget.index][13] = value;

                setState(() {
                  gstAmount =
                      ((parseEmptyStringToDouble(widget.tableRows[widget.index][5]) *
                          parseEmptyStringToDouble(
                              widget.tableRows[widget.index][6])) -
                          discAmount) *
                          parseEmptyStringToDouble(widget.tableRows[widget.index][15]) *
                          0.01;
                  widget.tableRows[widget.index][16] =
                      gstAmount.toStringAsFixed(2);
                });

                setState(() {
                  cessAmount =
                      ((parseEmptyStringToDouble(widget.tableRows[widget.index][5]) *
                          parseEmptyStringToDouble(
                              widget.tableRows[widget.index][6])) -
                          parseEmptyStringToDouble(discAmountController.text)) *
                          parseEmptyStringToDouble(value) *
                          0.01;
                  widget.tableRows[widget.index][14] =
                      cessAmount.toStringAsFixed(2);
                  totalAmount =
                      ((parseEmptyStringToDouble(widget.tableRows[widget.index][5]) *
                          parseEmptyStringToDouble(
                              widget.tableRows[widget.index][6])) -
                          discAmount) +
                          cessAmount +
                          gstAmount +
                          parseEmptyStringToDouble(widget.tableRows[widget.index][17]) +
                          parseEmptyStringToDouble(widget.tableRows[widget.index][11]) +
                          parseEmptyStringToDouble(widget.tableRows[widget.index][12]);
                  widget.tableRows[widget.index][18] =
                      totalAmount.toStringAsFixed(2);
                });
              });
            },
            decoration: InputDecoration(
              label: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "*",
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                  text: "Cess Rate",
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
            validator: (String? val) {
              if (val == null || val.isEmpty) {
                return 'This field is Mandatory';
              }
            },
            controller:
            TextEditingController(text: widget.tableRows[widget.index][14]),
            onChanged: (value) {
              setState(() {
                widget.tableRows[widget.index][14] = value;
              });
            },
            readOnly: true,
            decoration: InputDecoration(
              label: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "*",
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                  text: "Cess Amount",
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
            validator: (String? val) {
              if (val == null || val.isEmpty) {
                return 'This field is Mandatory';
              }
            },
            controller:
            TextEditingController(text: widget.tableRows[widget.index][15]),
            onChanged: (value) {
              setState(() {
                widget.tableRows[widget.index][15] = value;
              });
            },
            readOnly: true,
            decoration: InputDecoration(
              label: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "*",
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                  text: "Gst Tax Rate",
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
            validator: (String? val) {
              if (val == null || val.isEmpty) {
                return 'This field is Mandatory';
              }
            },
            controller:
            TextEditingController(text: widget.tableRows[widget.index][16]),
            readOnly: true,
            onChanged: (value) {
              setState(() {
                widget.tableRows[widget.index][16] = value;
              });
            },
            decoration: InputDecoration(
              label: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "*",
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                  text: "GST Amount",
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
        Visibility(
          visible: false,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (String? val) {
                if (val == null || val.isEmpty) {
                  return 'This field is Mandatory';
                }
              },
              initialValue: widget.tableRows[widget.index][17],
              onChanged: (value) {
                setState(() {
                  widget.tableRows[widget.index][17] = value;
                  totalAmount =
                      ((parseEmptyStringToDouble(widget.tableRows[widget.index][5]) *
                          parseEmptyStringToDouble(
                              widget.tableRows[widget.index][6])) -
                          discAmount) +
                          cessAmount +
                          gstAmount +
                          parseEmptyStringToDouble(widget.tableRows[widget.index][17]) +
                          parseEmptyStringToDouble(widget.tableRows[widget.index][11]) +
                          parseEmptyStringToDouble(widget.tableRows[widget.index][12]);
                  widget.tableRows[widget.index][18] =
                      totalAmount.toStringAsFixed(2);
                });
              },
              decoration: InputDecoration(
                label: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "*",
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                    text: "TCS Amount",
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
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            validator: (String? val) {
              if (val == null || val.isEmpty) {
                return 'This field is Mandatory';
              }
            },
            controller:
            TextEditingController(text: widget.tableRows[widget.index][18]),
            readOnly: true,
            onChanged: (value) {
              setState(() {
                widget.tableRows[widget.index][18] = value;
              });
            },
            decoration: InputDecoration(
              label: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "*",
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                  text: "Total Amount",
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
        )
      ],
    );
  }

  void calculateTotalAmount(int i) {
    setState(() {
      amount = parseEmptyStringToDouble(widget.tableRows[widget.index][5]) *
          parseEmptyStringToDouble(widget.tableRows[widget.index][6]);
      widget.tableRows[widget.index][7] = amount.toStringAsFixed(2);

      if (widget.tableRows[widget.index][8] == "P") {
        discAmount =
        (amount * parseEmptyStringToDouble(widget.tableRows[widget.index][9]) * 0.01);
        discAmountController.text = discAmount.toStringAsFixed(2);
      }
    });
    // GST TAX AMOUNT
    setState(() {
      gstAmount = ((parseEmptyStringToDouble(widget.tableRows[widget.index][5]) *
          parseEmptyStringToDouble(widget.tableRows[widget.index][6])) -
          discAmount) *
          parseEmptyStringToDouble(widget.tableRows[widget.index][15]) *
          0.01;
      widget.tableRows[widget.index][16] = gstAmount.toStringAsFixed(2);
    });

    // CESS AMOUNT AND TOTAL AMOUNT
    setState(() {
      cessAmount = ((parseEmptyStringToDouble(widget.tableRows[widget.index][5]) *
          parseEmptyStringToDouble(widget.tableRows[widget.index][6])) -
          parseEmptyStringToDouble(discAmountController.text)) *
          parseEmptyStringToDouble(widget.tableRows[widget.index][13]) *
          0.01;
      widget.tableRows[widget.index][14] = cessAmount.toStringAsFixed(2);
      totalAmount = ((parseEmptyStringToDouble(widget.tableRows[widget.index][5]) *
          parseEmptyStringToDouble(widget.tableRows[widget.index][6])) -
          discAmount) +
          cessAmount +
          gstAmount +
          parseEmptyStringToDouble(widget.tableRows[widget.index][17]) +
          parseEmptyStringToDouble(widget.tableRows[widget.index][11]) +
          parseEmptyStringToDouble(widget.tableRows[widget.index][12]);
      widget.tableRows[widget.index][18] = totalAmount.toStringAsFixed(2);
    });
  }
}
