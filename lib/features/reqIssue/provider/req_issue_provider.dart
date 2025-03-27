import 'dart:convert';

import 'package:fintech_new_web/features/utility/models/forms_UI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';

import '../../network/service/network_service.dart';
import '../../utility/services/generate_form_service.dart';
import '../screens/add_req_issue.dart';

class ReqIssueProvider with ChangeNotifier {
  static const String featureName = "ReqIssue";

  List<FormUI> formFieldDetails = [];
  List<Widget> widgetList = [];
  List<dynamic> reqPending = [];
  List<List<String>> rowFields = [];

  List<DataRow> rows = [];

  NetworkService networkService = NetworkService();
  GenerateFormService formService = GenerateFormService();

  void initWidget(String reqId) async {
    rowFields.clear();
    http.StreamedResponse response =
        await networkService.post("/get-req-mat-by-reqId/", {"reqId": reqId});
    if (response.statusCode == 200) {
      var respData = jsonDecode(await response.stream.bytesToString());
      for (var data in respData) {
        rowFields
            .add(['${data['reqId']}', '${data['matno']}', '${data['bqty']}']);
      }
    }
    notifyListeners();
  }

  Future<http.StreamedResponse> processFormInfo(
      List<List<String>> tableRows) async {
    List<Map<String, dynamic>> reqIssue = [];
    for (int i = 0; i < tableRows.length; i++) {
      reqIssue.add({
        "reqId": tableRows[i][0],
        "matno": tableRows[i][1],
        "qty": tableRows[i][2],
      });
    }
    http.StreamedResponse response =
        await networkService.post("/add-req-issue/", reqIssue);
    return response;
  }

  void getReqIssuePending(BuildContext context) async {
    reqPending.clear();
    Map<String, List<dynamic>> groupedData = {};
    http.StreamedResponse response =
        await networkService.get("/get-req-issue-pending/");
    if (response.statusCode == 200) {
      reqPending = jsonDecode(await response.stream.bytesToString());
      for (var data in reqPending) {
        if (groupedData['${data['reqId']}'] != null) {
          groupedData['${data['reqId']}']?.add(data);
        } else {
          groupedData['${data['reqId']}'] = [data];
        }
      }
    }
    groupedDataTable(groupedData, context);
  }

  void groupedDataTable(
      Map<String, List<dynamic>> groupedData, BuildContext context) {
    rows.clear();
    groupedData.forEach((key, value) {
      rows.add(DataRow(cells: [
        const DataCell(Text("Requirement ID", style: TextStyle(
          fontWeight: FontWeight.bold
        ))),
        DataCell(Text(key, style: const TextStyle(
            fontWeight: FontWeight.bold
        ))),
        const DataCell(Text("")),
        DataCell(ElevatedButton(
            onPressed: () {
              context.pushNamed(AddReqIssue.routeName,
                  queryParameters: {"reqId": key});
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1), // Square shape
              ),
              padding: EdgeInsets.zero,
              // Remove internal padding to make it square
              minimumSize:
                  const Size(150, 50), // Width and height for the button
            ),
            child: const Text(
              "Issue Material",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )))
      ]));
      for (var data in value) {
        rows.add(DataRow(cells: [
          DataCell(Text('${data['matno'] ?? "-"}')),
          DataCell(Text('${data['qty'] ?? "-"}')),
          DataCell(Text('${data['iqty'] ?? "-"}')),
          DataCell(Text('${data['bqty'] ?? "-"}')),
        ]));
      }
    });
    notifyListeners();
  }
}
