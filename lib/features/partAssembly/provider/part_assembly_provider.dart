import 'dart:convert';

import 'package:fintech_new_web/features/utility/global_variables.dart';
import 'package:fintech_new_web/features/utility/models/forms_UI.dart';
import 'package:fintech_new_web/features/utility/services/common_utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../camera/service/camera_service.dart';
import '../../network/service/network_service.dart';
import '../../utility/services/generate_form_service.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';

class PartAssemblyProvider with ChangeNotifier {
  static const String featureName = "partAssembly";
  static const String reportFeature = "partAssemblyReport";

  List<FormUI> formFieldDetails = [];
  List<Widget> widgetList = [];
  List<Widget> reportWidgetList = [];
  List<SearchableDropdownMenuItem<String>> workProcess = [];
  List<SearchableDropdownMenuItem<String>> rmType = [];
  List<SearchableDropdownMenuItem<String>> resources = [];
  List<SearchableDropdownMenuItem<String>> units = [];

  List<dynamic> partAssemblyReport = [];
  List<dynamic> wip = [];

  TextEditingController materialController = TextEditingController();
  dynamic wireSizeDesc = {};
  dynamic partAssemblyMap = {};
  List<dynamic> partAssemblyDetailsList = [];
  List<dynamic> partAssemblyProcessingList = [];

  NetworkService networkService = NetworkService();
  GenerateFormService formService = GenerateFormService();

  List<DataRow> rows = [];

  void reset() {
    materialController.text = "";
    materialController.clear();
    notifyListeners();
  }

  void setMaterial(String value) {
    materialController.text = value;
    notifyListeners();
  }

  void initWidget() async {
    GlobalVariables.requestBody[featureName] = {};
    formFieldDetails.clear();
    widgetList.clear();

    http.StreamedResponse response =
        await networkService.get("/get-pa-matno/${materialController.text}/");
    List<dynamic> respData = [];
    var partAssembly = {};

    if (response.statusCode == 200) {
      respData = jsonDecode(await response.stream.bytesToString());
      partAssembly = respData.isNotEmpty ? respData[0] : {};
    }

    String jsonData =
        '[{"id":"matno","name":"Material No.","isMandatory":false,"inputType":"text","readOnly":true, "default" : "${materialController.text ?? ''}"},{"id":"revisionNo","name":"Revision No.","isMandatory":false,"inputType":"text"} ,{"id":"csId","name":"Cost Status","isMandatory":true,"inputType":"dropdown","dropdownMenuItem":"/get-cost-status/"}]';

    for (var element in jsonDecode(jsonData)) {
      TextEditingController controller = TextEditingController();
      formFieldDetails.add(FormUI(
          id: element['id'],
          name: element['name'],
          isMandatory: element['isMandatory'],
          inputType: element['inputType'],
          dropdownMenuItem: element['dropdownMenuItem'] ?? "",
          maxCharacter: element['maxCharacter'] ?? 255,
          defaultValue: element['default'],
          controller: controller,
          readOnly: element['readOnly'] ?? false));
    }

    List<Widget> widgets =
        await formService.generateDynamicForm(formFieldDetails, featureName);
    widgetList.addAll(widgets);
    getWorkProcess();
    getRmType();
    getAllResources();
    getUnits();
    notifyListeners();
  }

  void setDrawing(String blob, String name) async {
    String blobUrl = "";
    Camera camera = Camera();
    blobUrl = await camera.getBlobUrl(blob, name);
    if (blobUrl.isNotEmpty) {
      GlobalVariables.requestBody[featureName]["drawing"] = blobUrl;
    }
    notifyListeners();
  }

  void setPic(String blob, String name) async {
    String blobUrl = "";
    Camera camera = Camera();
    blobUrl = await camera.getBlobUrl(blob, name);
    if (blobUrl.isNotEmpty) {
      GlobalVariables.requestBody[featureName]["pic"] = blobUrl;
    }
    notifyListeners();
  }

  void setAsDrawing(String blob, String name) async {
    String blobUrl = "";
    Camera camera = Camera();
    blobUrl = await camera.getBlobUrl(blob, name);
    if (blobUrl.isNotEmpty) {
      GlobalVariables.requestBody[featureName]["asdrawing"] = blobUrl;
    }
    notifyListeners();
  }

  Future<http.StreamedResponse> processFormInfo() async {
    GlobalVariables.requestBody[featureName]['matno'] = materialController.text;
    http.StreamedResponse response = await networkService.post(
        "/add-pa/", GlobalVariables.requestBody[featureName]);
    return response;
  }

  void getPartAssemblyByMatno() async {
    partAssemblyMap.clear();
    http.StreamedResponse response =
        await networkService.get("/get-pa-matno/${materialController.text}/");

    if (response.statusCode == 200) {
      var data = jsonDecode(await response.stream.bytesToString());
      partAssemblyMap = data[0];
    }
    notifyListeners();
  }

  void getPartAssemblyDetailsByMatno() async {
    partAssemblyDetailsList.clear();
    http.StreamedResponse response = await networkService
        .get("/get-pa-details-matno/${materialController.text}/");

    if (response.statusCode == 200) {
      var data = jsonDecode(await response.stream.bytesToString());
      partAssemblyDetailsList = data;
    }
    notifyListeners();
  }

  void getPartAssemblyProcessingByMatno() async {
    partAssemblyProcessingList.clear();
    http.StreamedResponse response = await networkService
        .get("/get-pa-processing-matno/${materialController.text}/");

    if (response.statusCode == 200) {
      var data = jsonDecode(await response.stream.bytesToString());
      partAssemblyProcessingList = data;
    }
    notifyListeners();
  }

  Future<http.StreamedResponse> deletePartAssembly(String matno) async {
    http.StreamedResponse response =
        await networkService.post("/delete-pa/$matno/", {});
    return response;
  }

  Future<http.StreamedResponse> deletePartAssemblyDetails(String padId) async {
    http.StreamedResponse response =
        await networkService.post("/delete-pa-details/$padId/", {});
    return response;
  }

  Future<http.StreamedResponse> deletePartAssemblyProcessing(
      String papId) async {
    http.StreamedResponse response =
        await networkService.post("/delete-pa-processing/$papId/", {});
    return response;
  }

  Future<http.StreamedResponse> addPartAssemblyProcessing(
      List<List<String>> detailsTab, bool manual) async {
    List<Map<String, dynamic>> partProcessing = [];
    for (int i = 0; i < detailsTab.length; i++) {
      partProcessing.add({
        "wpId": detailsTab[i][0],
        "orderBy": detailsTab[i][1],
        "rId": detailsTab[i][2],
        "rQty": detailsTab[i][3],
        "dayProduction": detailsTab[i][4],
        "matno": materialController.text
      });
    }
    if (!manual) {
      partProcessing = GlobalVariables.requestBody['PartAssemblyProcessing'];
    }
    http.StreamedResponse response =
        await networkService.post("/add-pa-processing/", partProcessing);
    return response;
  }

  Future<http.StreamedResponse> addPartAssemblyDetails(
      List<List<String>> tableRows, bool manual) async {
    List<Map<String, dynamic>> data = [];
    for (int i = 0; i < tableRows.length; i++) {
      data.add({
        "matno": materialController.text,
        "partno": tableRows[i][0],
        "qty": tableRows[i][1],
        "pLength": tableRows[i][2] == "" ? null : tableRows[i][2],
        "unit": tableRows[i][3] == "" ? null : tableRows[i][3],
        "tno": tableRows[i][4] == "" ? null : tableRows[i][4],
        "rmType": tableRows[i][5]
      });
    }
    if (!manual) {
      data = GlobalVariables.requestBody['PartAssemblyDetails'];
    }
    http.StreamedResponse response =
        await networkService.post("/add-pa-details/", data);
    return response;
  }

  void getWorkProcess() async {
    workProcess = await formService.getDropdownMenuItem("/get-work-process/");
    notifyListeners();
  }

  void getRmType() async {
    rmType = await formService.getDropdownMenuItem("/get-rm-type/");
    notifyListeners();
  }

  void getAllResources() async {
    resources = await formService.getDropdownMenuItem("/get-all-resources/");
    notifyListeners();
  }

  void getUnits() async {
    units = await formService.getDropdownMenuItem("/get-material-unit/");
    notifyListeners();
  }

  void initReport() async {
    String jsonData =
        '[{"id":"matno","name":"Material No.","isMandatory":true,"inputType":"text","maxCharacter":15}]';
    GlobalVariables.requestBody[reportFeature] = {};
    formFieldDetails.clear();
    reportWidgetList.clear();

    for (var element in jsonDecode(jsonData)) {
      TextEditingController controller = TextEditingController();
      formFieldDetails.add(FormUI(
          id: element['id'],
          name: element['name'],
          isMandatory: element['isMandatory'],
          controller: controller,
          inputType: element['inputType'],
          dropdownMenuItem: element['dropdownMenuItem'] ?? "",
          maxCharacter: element['maxCharacter'] ?? 255));
    }
    List<Widget> widgets =
        await formService.generateDynamicForm(formFieldDetails, reportFeature);
    reportWidgetList.addAll(widgets);
    notifyListeners();
  }

  void getProductBreakupReport() async {
    partAssemblyReport.clear();
    http.StreamedResponse response = await networkService.post(
        "/part-assembly-report/", GlobalVariables.requestBody[reportFeature]);
    if (response.statusCode == 200) {
      String respData = jsonDecode(await response.stream.bytesToString());
      partAssemblyReport = jsonDecode(respData);
    }
    notifyListeners();
  }

  void getWorkInProgress() async {
    wip.clear();
    rows.clear();
    List<double> sums = [0];
    http.StreamedResponse response = await networkService.get("/get-wip/");
    if (response.statusCode == 200) {
      wip = jsonDecode(await response.stream.bytesToString());

      for (var data in wip) {
        sums[0] += parseEmptyStringToDouble('${data['AMOUNT']}');

        rows.add(DataRow(cells: [
          DataCell(Text('${data['matno']}')),
          DataCell(Align(alignment: Alignment.centerRight, child: Text(parseDoubleUpto2Decimal(parseDoubleUpto2Decimal(data['PP']))))),
          DataCell(Align(alignment: Alignment.centerRight, child: Text(parseDoubleUpto2Decimal(parseDoubleUpto2Decimal(data['HOLD']))))),
          DataCell(Align(alignment: Alignment.centerRight, child: Text(parseDoubleUpto2Decimal(parseDoubleUpto2Decimal(data['PACK']))))),
          DataCell(Align(alignment: Alignment.centerRight, child: Text(parseDoubleUpto2Decimal(parseDoubleUpto2Decimal(data['TQTY']))))),
          DataCell(Align(alignment: Alignment.centerRight, child: Text(parseDoubleUpto2Decimal(parseDoubleUpto2Decimal(data['AMOUNT']))))),
        ]));
      }
      rows.add(DataRow(cells: [
        const DataCell(SizedBox()),
        const DataCell(SizedBox()),
        const DataCell(Text('Total', style: TextStyle(fontWeight: FontWeight.bold))),
        const DataCell(SizedBox()),
        const DataCell(SizedBox()),
        DataCell(Align(
            alignment: Alignment.centerRight,
            child: Text(parseDoubleUpto2Decimal(sums[0].toStringAsFixed(2)), style: const TextStyle(fontWeight: FontWeight.bold)))),
      ]));

    }
    notifyListeners();
  }
}
