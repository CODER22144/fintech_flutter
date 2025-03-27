import 'dart:convert';

import 'package:fintech_new_web/features/gr/provider/gr_provider.dart';
import 'package:fintech_new_web/features/network/service/network_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../common/widgets/comman_appbar.dart';
import '../../common/widgets/pop_ups.dart';

class GrShortagePending extends StatefulWidget {
  static String routeName = "grShortagePending";

  const GrShortagePending({super.key});

  @override
  State<GrShortagePending> createState() => _GrShortagePendingState();
}

class _GrShortagePendingState extends State<GrShortagePending> {
  @override
  void initState() {
    GrProvider provider =
    Provider.of<GrProvider>(context, listen: false);
    provider.getGrShortagePending();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GrProvider>(builder: (context, provider, child) {
      return Material(
        child: SafeArea(
            child: Scaffold(
              appBar: PreferredSize(
                  preferredSize:
                  Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
                  child: const CommonAppbar(title: 'GR Shortage Pending')),
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: provider.grShortagePending.isNotEmpty ? DataTable(
                    columns: const [
                      DataColumn(label: Text("GR No.")),
                      DataColumn(label: Text("GR Date")),
                      DataColumn(label: Text("Business Partner Name")),
                      DataColumn(label: Text("City")),
                      DataColumn(label: Text("State")),
                      DataColumn(label: Text("Material No.")),
                      DataColumn(label: Text("GR Qty")),
                      DataColumn(label: Text("Received Qty")),
                      DataColumn(label: Text("Short Qty")),
                      DataColumn(label: Text("")),
                    ],
                    rows: provider.grShortagePending.map((data) {
                      return DataRow(cells: [
                        DataCell(Text('${data['grno'] ?? "-"}')),
                        DataCell(Text('${data['grDate'] ?? "-"}')),
                        DataCell(Text('${data['bpName'] ?? "-"}')),
                        DataCell(Text('${data['bpCity'] ?? "-"}')),
                        DataCell(Text('${data['stateName'] ?? "-"}')),
                        DataCell(Text('${data['matno'] ?? "-"}')),
                        DataCell(Text('${data['grQty'] ?? "-"}')),
                        DataCell(Text('${data['recqty'] ?? "-"}')),
                        DataCell(Text('${data['soQty'] ?? "-"}')),
                        DataCell(ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(5)))),
                          onPressed: () async {
                            bool confirmation =
                            await showConfirmationDialogue(
                                context,
                                "Do you want to create Debit Note Against GR: ${data['grno'] ?? "-"}?",
                                "SUBMIT",
                                "CANCEL");
                            if(confirmation) {
                              NetworkService networkService = NetworkService();
                              http.StreamedResponse response = await networkService.post("/debit-note-shortage/", {"grno" : '${data['grno'] ?? "-"}'});
                              if(response.statusCode == 200) {
                                provider.getGrShortagePending();
                              } else {
                                var message = jsonDecode(
                                    await response.stream.bytesToString());
                                await showAlertDialog(context,
                                    message['message'], "Continue", false);
                              }
                            }
                          },
                          child: const Text(
                            'Post Debit Note',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.white),
                          ),
                        )),
                      ]);
                    }).toList(),
                  ) : const SizedBox(),
                ),
              ),
            )),
      );
    });
  }
}
