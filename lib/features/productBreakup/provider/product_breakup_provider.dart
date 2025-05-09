import 'dart:convert';

import 'package:fintech_new_web/features/utility/global_variables.dart';
import 'package:fintech_new_web/features/utility/models/forms_UI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../camera/service/camera_service.dart';
import '../../network/service/network_service.dart';
import '../../utility/services/generate_form_service.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';

class ProductBreakupProvider with ChangeNotifier {
  static const String featureName = "productBreakup";
  static const String reportFeature = "productBreakupReport";

  List<FormUI> formFieldDetails = [];
  List<Widget> widgetList = [];
  List<Widget> reportWidgetList = [];
  List<SearchableDropdownMenuItem<String>> workProcess = [];
  List<SearchableDropdownMenuItem<String>> rmType = [];
  List<SearchableDropdownMenuItem<String>> resources = [];
  List<SearchableDropdownMenuItem<String>> units = [];

  List<dynamic> breakupReport = [];
  TextEditingController materialController = TextEditingController();
  dynamic productBreakupMap = {};
  List<dynamic> productBreakupDetailsList = [];
  List<dynamic> productBreakupProcessingList = [];

  NetworkService networkService = NetworkService();
  GenerateFormService formService = GenerateFormService();

  void setMaterial(String value) {
    materialController.text = value;
    notifyListeners();
  }

  void reset() {
    materialController.text = "";
    materialController.clear();
    notifyListeners();
  }

  void initWidget() async {
    GlobalVariables.requestBody[featureName] = {};
    formFieldDetails.clear();
    widgetList.clear();

    http.StreamedResponse response =
        await networkService.get("/get-pbu-matno/${materialController.text}/");
    List<dynamic> respData = [];
    var productBreakup = {};

    if (response.statusCode == 200) {
      respData = jsonDecode(await response.stream.bytesToString());
      productBreakup = respData.isNotEmpty ? respData[0] : {};
    }

    String jsonData =
        '[{"id":"matno","name":"Material No.","isMandatory":false,"inputType":"text","readOnly":true,"default":"${materialController.text ?? ''}"},{"id":"sDescription","name":"Short Description","isMandatory":true,"inputType":"text"},{"id":"lDescription","name":"Long Description","isMandatory":false,"inputType":"text"},{"id":"listRate","name":"List Rate","isMandatory":true,"inputType":"number"},{"id":"mrp","name":"MRP","isMandatory":true,"inputType":"number"},{"id":"oemRate","name":"OEM Rate","isMandatory":true,"inputType":"number"},{"id":"stdPack","name":"Standard Pack","isMandatory":true,"inputType":"number"},{"id":"mstPack","name":"Master Pack","isMandatory":true,"inputType":"number"},{"id":"jamboPack","name":"Jambo Pack","isMandatory":true,"inputType":"number"},{"id":"revisionNo","name":"Revision No.","isMandatory":false,"inputType":"text"},{"id":"grossWeight","name":"Gross Weight","isMandatory":true,"inputType":"number"},{"id":"netWeight","name":"Net Weight","isMandatory":true,"inputType":"number"},{"id":"csId","name":"Cost Status","isMandatory":true,"inputType":"dropdown","dropdownMenuItem":"/get-cost-status/"},{"id":"remarks","name":"Remarks","isMandatory":false,"inputType":"text"}]';

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

  Future<http.StreamedResponse> processFormInfo() async {
    GlobalVariables.requestBody[featureName]['matno'] = materialController.text;
    http.StreamedResponse response = await networkService.post(
        "/add-pbu/", GlobalVariables.requestBody[featureName]);
    return response;
  }

  void getProductBreakupByMatno() async {
    productBreakupMap.clear();
    http.StreamedResponse response = await networkService
        .get("/get-pbu-matno/${materialController.text}/");

    if (response.statusCode == 200) {
      var data = jsonDecode(await response.stream.bytesToString());
      productBreakupMap = data[0];
    }
    notifyListeners();
  }

  void getProductBreakupDetailsByMatno() async {
    productBreakupDetailsList.clear();
    http.StreamedResponse response = await networkService
        .get("/get-pbu-details-matno/${materialController.text}/");

    if (response.statusCode == 200) {
      var data = jsonDecode(await response.stream.bytesToString());
      productBreakupDetailsList = data;
    }
    notifyListeners();
  }

  void getProductBreakupProcessingByMatno() async {
    productBreakupProcessingList.clear();
    http.StreamedResponse response = await networkService
        .get("/get-pbu-processing-matno/${materialController.text}/");

    if (response.statusCode == 200) {
      var data = jsonDecode(await response.stream.bytesToString());
      productBreakupProcessingList = data;
    }
    notifyListeners();
  }

  Future<http.StreamedResponse> deleteProductBreakup(String matno) async {
    http.StreamedResponse response = await networkService
        .post("/delete-pbu/$matno/", {});
    return response;
  }

  Future<http.StreamedResponse> deleteProductBreakupDetails(
      String padId) async {
    http.StreamedResponse response = await networkService
        .post("/delete-pbu-details/$padId/", {});
    return response;
  }

  Future<http.StreamedResponse> deleteProductBreakupProcessing(
      String papId) async {
    http.StreamedResponse response = await networkService
        .post("/delete-pbu-processing/$papId/", {});
    return response;
  }

  Future<http.StreamedResponse> addProductBreakupProcessing(
      List<List<String>> detailsTab, bool manual) async {
    List<Map<String, dynamic>> partProcessing = [];
    for (int i = 0; i < detailsTab.length; i++) {
      partProcessing.add({
        "wpId" : detailsTab[i][0],
        "orderBy": detailsTab[i][1],
        "rId": detailsTab[i][2],
        "rQty": detailsTab[i][3],
        "dayProduction": detailsTab[i][4],
        "matno" : materialController.text
      });
    }
    if(!manual) {
      partProcessing = GlobalVariables.requestBody['ProductBreakupProcessing'];
    }
    http.StreamedResponse response =
        await networkService.post("/add-pbu-processing/", partProcessing);
    return response;
  }

  Future<http.StreamedResponse> addProductBreakupDetails(
      List<List<String>> tableRows, bool manual) async {
    List<Map<String, dynamic>> data = [];
    for (int i = 0; i < tableRows.length; i++) {
      data.add({
        "matno" : materialController.text,
        "partNo": tableRows[i][0],
        "qty": tableRows[i][1],
        "pLength": tableRows[i][2] == "" ? null : tableRows[i][2],
        "unit": tableRows[i][3] == "" ? null : tableRows[i][3],
        "tno": tableRows[i][4] == "" ? null : tableRows[i][4],
        "rmType": tableRows[i][5]
      });
    }
    if(!manual) {
      data = GlobalVariables.requestBody['ProductBreakupDetails'];
    }
    http.StreamedResponse response =
    await networkService.post("/add-pbu-details/", data);
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
    breakupReport.clear();
    http.StreamedResponse response =
    await networkService.post(
        "/pbu-report/", GlobalVariables.requestBody[reportFeature]);
    if (response.statusCode == 200) {
      String respData = jsonDecode(await response.stream.bytesToString());
      breakupReport = jsonDecode(respData);
    }
    notifyListeners();
  }
}
