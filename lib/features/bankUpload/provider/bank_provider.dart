import 'dart:convert';

import 'package:fintech_new_web/features/utility/global_variables.dart';
import 'package:fintech_new_web/features/utility/models/forms_UI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../network/service/network_service.dart';
import '../../utility/services/common_utility.dart';
import '../../utility/services/generate_form_service.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';

class BankProvider with ChangeNotifier {
  static const String reportFeature = "BankStatements";

  List<FormUI> formFieldDetails = [];
  List<Widget> reportWidgetList = [];

  List<dynamic> bankStatement = [];

  List<DataRow> rows = [];

  NetworkService networkService = NetworkService();
  GenerateFormService formService = GenerateFormService();

  void initReport() async {
    GlobalVariables.requestBody[reportFeature] = {};
    formFieldDetails.clear();
    reportWidgetList.clear();
    String jsonData =
        '[{"id":"bpCode","name":"Business Partner Code","isMandatory":false,"inputType":"dropdown","dropdownMenuItem":"/get-business-partner/"},{"id":"type","name":"Trans. Type","isMandatory":false,"inputType":"text","maxCharacter":1},{"id":"fdate","name":"From Date","isMandatory":true,"inputType":"datetime"},{"id":"tdate","name":"To Date","isMandatory":true,"inputType":"datetime"}]';

    for (var element in jsonDecode(jsonData)) {
      formFieldDetails.add(FormUI(
          id: element['id'],
          name: element['name'],
          isMandatory: element['isMandatory'],
          inputType: element['inputType'],
          dropdownMenuItem: element['dropdownMenuItem'] ?? "",
          maxCharacter: element['maxCharacter'] ?? 255));
    }

    List<Widget> widgets =
    await formService.generateDynamicForm(formFieldDetails, reportFeature);
    reportWidgetList.addAll(widgets);
    notifyListeners();
  }

  void getBankStatements() async {
    bankStatement.clear();
    http.StreamedResponse response = await networkService.post(
        "/bank-statements/", GlobalVariables.requestBody[reportFeature]);
    if (response.statusCode == 200) {
      bankStatement = jsonDecode(await response.stream.bytesToString());
    }
    getRows();
  }

  void getRows() {
    List<double> totals = [0, 0];
    rows.clear();

    for (var data in bankStatement) {
      totals[0] = totals[0] + parseEmptyStringToDouble('${data['withdrawal']}');
      totals[1] = totals[1] + parseEmptyStringToDouble('${data['deposit']}');


      rows.add(DataRow(cells: [
        DataCell(Text('${data['transId'] ?? "-"}')),
        DataCell(Text('${data['dtransDate'] ?? "-"}')),
        DataCell(Text('${data['transDescription'] ?? "-"}')),
        DataCell(Text('${data['refNumber'] ?? "-"}')),
        DataCell(Text('${data['valueDate'] ?? "-"}')),
        DataCell(Align(alignment: Alignment.centerRight, child: Text(parseDoubleUpto2Decimal('${data['withdrawal']}')))),
        DataCell(Align(alignment: Alignment.centerRight, child: Text(parseDoubleUpto2Decimal('${data['deposit']}')))),
        DataCell(Text('${data['bankCode'] ?? "-"}')),
        DataCell(Text('${data['lcode'] ?? "-"}')),
        DataCell(Text('${data['postMethod'] ?? "-"}')),
        DataCell(Text('${data['naration'] ?? "-"}')),
      ]));
    }

    rows.add(DataRow(cells: [
      const DataCell(SizedBox()),
      const DataCell(SizedBox()),
      const DataCell(
          Text('TOTAL', style: TextStyle(fontWeight: FontWeight.bold))),
      const DataCell(SizedBox()),
      const DataCell(SizedBox()),
      DataCell(Align(
          alignment: Alignment.centerRight,
          child: Text(parseDoubleUpto2Decimal('${totals[0]}'), style: const TextStyle(fontWeight: FontWeight.bold)))),
      DataCell(Align(
          alignment: Alignment.centerRight,
          child: Text(parseDoubleUpto2Decimal('${totals[1]}'), style: const TextStyle(fontWeight: FontWeight.bold)))),
      const DataCell(SizedBox()),
      const DataCell(SizedBox()),
      const DataCell(SizedBox()),
      const DataCell(SizedBox()),
    ]));

    notifyListeners();
  }

}
