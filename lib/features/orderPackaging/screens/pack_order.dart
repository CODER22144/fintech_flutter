// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:fintech_new_web/features/orderPackaging/provider/order_packaging_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../common/widgets/comman_appbar.dart';
import '../../common/widgets/pop_ups.dart';
import '../../utility/global_variables.dart';

class PackOrder extends StatefulWidget {
  static String routeName = "packOrder";
  final String orderId;
  const PackOrder({super.key, required this.orderId});

  @override
  State<PackOrder> createState() => _PackOrderState();
}

class _PackOrderState extends State<PackOrder> {
  @override
  void initState() {
    super.initState();
    OrderPackagingProvider provider =
        Provider.of<OrderPackagingProvider>(context, listen: false);
    provider.initWidget(widget.orderId);
    provider.getOrderBalance(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return Consumer<OrderPackagingProvider>(
        builder: (context, provider, child) {
      return Scaffold(
        appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
            child: CommonAppbar(title: 'Pack Order : ${widget.orderId}')),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: GlobalVariables.deviceWidth / 3,
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Visibility(
                        visible: provider.widgetList.isNotEmpty,
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: HexColor("#0B6EFE"),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5)))),
                            onPressed: () {
                              _showTablePopup(context, provider.orderBalance);
                            },
                            child: const Text(
                              'Order Balance',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Visibility(
                        visible: provider.widgetList.isNotEmpty,
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: HexColor("#0B6EFE"),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5)))),
                            onPressed: () {
                              _showPackedOrderTable(context, provider);
                            },
                            child: const Text(
                              'Packed Order',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: ListView.builder(
                          itemCount: provider.widgetList.length,
                          physics: const ClampingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return provider.widgetList[index];
                          },
                        ),
                      ),
                      Visibility(
                        visible: provider.widgetList.isNotEmpty,
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: HexColor("#0B6EFE"),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5)))),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                bool confirmation =
                                    await showConfirmationDialogue(
                                        context,
                                        "Do you want to submit the records?",
                                        "SUBMIT",
                                        "CANCEL");
                                if (confirmation) {
                                  http.StreamedResponse result =
                                      await provider.processFormInfo();
                                  if (result.statusCode == 200) {
                                    context.pop();
                                    context.pushNamed(PackOrder.routeName,
                                        queryParameters: {
                                          "orderId": widget.orderId
                                        });
                                  } else if (result.statusCode == 400) {
                                    var message = jsonDecode(
                                        await result.stream.bytesToString());
                                    await showAlertDialog(
                                        context,
                                        message['message'].toString(),
                                        "Continue",
                                        false);
                                  } else if (result.statusCode == 500) {
                                    var message = jsonDecode(
                                        await result.stream.bytesToString());
                                    await showAlertDialog(
                                        context,
                                        message['message'],
                                        "Continue",
                                        false);
                                  } else {
                                    var message = jsonDecode(
                                        await result.stream.bytesToString());
                                    await showAlertDialog(
                                        context,
                                        message['message'],
                                        "Continue",
                                        false);
                                  }
                                }
                              }
                            },
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  void _showPackedOrderTable(BuildContext context, OrderPackagingProvider provider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Order Balance',
              style: TextStyle(fontWeight: FontWeight.w500)),
          content: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DataTable(
                    columns: const [
                      DataColumn(label: Text("Material No.")),
                      DataColumn(label: Text("Quantity")),
                      DataColumn(label: Text("Delete")),
                    ],
                    rows: provider.orderPackagingPosted.map((data) {
                      return DataRow(cells: [
                        DataCell(Text('${data['icode'] ?? "-"}')),
                        DataCell(Text('${data['qty'] ?? "-"}')),
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5),
                          child: IconButton(
                            icon: const Icon(Icons.delete,
                                color: Colors.red),
                            onPressed: () async {
                              bool confirmation =
                              await showConfirmationDialogue(
                                  context,
                                  "Do you want to delete the records?",
                                  "SUBMIT",
                                  "CANCEL");
                              if (confirmation) {
                                http.StreamedResponse result =
                                await provider
                                    .deleteOrderPackaging(
                                    '${data['opid'] ?? "-"}');
                                if (result.statusCode == 204) {
                                  provider.packedOrderInfo(
                                      widget.orderId);
                                  provider.getOrderBalance(widget.orderId);
                                  context.pop();
                                } else if (result.statusCode ==
                                    400) {
                                  var message = jsonDecode(
                                      await result.stream
                                          .bytesToString());
                                  await showAlertDialog(
                                      context,
                                      message['message'].toString(),
                                      "Continue",
                                      false);
                                } else if (result.statusCode ==
                                    500) {
                                  var message = jsonDecode(
                                      await result.stream
                                          .bytesToString());
                                  await showAlertDialog(
                                      context,
                                      message['message'],
                                      "Continue",
                                      false);
                                } else {
                                  var message = jsonDecode(
                                      await result.stream
                                          .bytesToString());
                                  await showAlertDialog(
                                      context,
                                      message['message'],
                                      "Continue",
                                      false);
                                }
                              }
                            },
                          ),
                        )),
                      ]);
                    }).toList(),
                  )
                ],
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    // Navigator.pop(context, false);
                    Navigator.of(context, rootNavigator: true).pop(false);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 5),
                    width: GlobalVariables.deviceWidth * 0.15,
                    height: GlobalVariables.deviceHeight * 0.05,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: HexColor("#e0e0e0"),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2,
                          offset: Offset(
                            2,
                            3,
                          ),
                        )
                      ],
                    ),
                    child: const Text("CLOSE",
                        style: TextStyle(fontSize: 11, color: Colors.black)),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  void _showTablePopup(BuildContext context, List<dynamic> orderBalance) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Order Balance',
              style: TextStyle(fontWeight: FontWeight.w500)),
          content: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DataTable(
                    columns: const [
                      DataColumn(label: Text('Item Code')),
                      DataColumn(label: Text('Ordered Quantity')),
                      DataColumn(label: Text('Packed Quantity')),
                      DataColumn(label: Text('Balance Quantity'))
                    ],
                    rows: orderBalance.map((data) {
                      return DataRow(cells: [
                        DataCell(Text('${data['icode'] ?? "-"}')),
                        DataCell(Text('${data['qty'] ?? "-"}')),
                        DataCell(Text('${data['pqty'] ?? "-"}')),
                        DataCell(Text('${data['bqty'] ?? "-"}')),
                      ]);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    // Navigator.pop(context, false);
                    Navigator.of(context, rootNavigator: true).pop(false);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 5),
                    width: GlobalVariables.deviceWidth * 0.15,
                    height: GlobalVariables.deviceHeight * 0.05,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: HexColor("#e0e0e0"),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2,
                          offset: Offset(
                            2,
                            3,
                          ),
                        )
                      ],
                    ),
                    child: const Text("CLOSE",
                        style: TextStyle(fontSize: 11, color: Colors.black)),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
