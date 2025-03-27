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

class PartSubAssemblyProvider with ChangeNotifier {
  static const String featureName = "partSubAssembly";

  List<FormUI> formFieldDetails = [];
  List<Widget> widgetList = [];
  List<SearchableDropdownMenuItem<String>> workProcess = [];
  List<SearchableDropdownMenuItem<String>> rmType = [];
  List<SearchableDropdownMenuItem<String>> resources = [];
  List<SearchableDropdownMenuItem<String>> units = [];

  TextEditingController materialController = TextEditingController();
  dynamic partSubAssemblyMap = {};
  List<dynamic> partSubAssemblyDetailsList = [];
  List<dynamic> partSubAssemblyProcessingList = [];

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
        await networkService.get("/get-psa-matno/${materialController.text}/");
    List<dynamic> respData = [];
    var partSubAssembly = {};

    if (response.statusCode == 200) {
      respData = jsonDecode(await response.stream.bytesToString());
      partSubAssembly = respData.isNotEmpty ? respData[0] : {};
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
        "/add-psa/", GlobalVariables.requestBody[featureName]);
    return response;
  }

  void getPartSubAssemblyByMatno() async {
    partSubAssemblyMap.clear();
    http.StreamedResponse response =
        await networkService.get("/get-psa-matno/${materialController.text}/");

    if (response.statusCode == 200) {
      var data = jsonDecode(await response.stream.bytesToString());
      partSubAssemblyMap = data[0];
    }
    notifyListeners();
  }

  void getPartSubAssemblyDetailsByMatno() async {
    partSubAssemblyDetailsList.clear();
    http.StreamedResponse response = await networkService
        .get("/get-psa-details-matno/${materialController.text}/");

    if (response.statusCode == 200) {
      var data = jsonDecode(await response.stream.bytesToString());
      partSubAssemblyDetailsList = data;
    }
    notifyListeners();
  }

  void getPartSubAssemblyProcessingByMatno() async {
    partSubAssemblyProcessingList.clear();
    http.StreamedResponse response = await networkService
        .get("/get-psa-processing-matno/${materialController.text}/");

    if (response.statusCode == 200) {
      var data = jsonDecode(await response.stream.bytesToString());
      partSubAssemblyProcessingList = data;
    }
    notifyListeners();
  }

  Future<http.StreamedResponse> deletePartSubAssembly(String matno) async {
    http.StreamedResponse response =
        await networkService.post("/delete-psa/$matno/", {});
    return response;
  }

  Future<http.StreamedResponse> deletePartSubAssemblyDetails(
      String padId) async {
    http.StreamedResponse response =
        await networkService.post("/delete-psa-details/$padId/", {});
    return response;
  }

  Future<http.StreamedResponse> deletePartSubAssemblyProcessing(
      String papId) async {
    http.StreamedResponse response =
        await networkService.post("/delete-psa-processing/$papId/", {});
    return response;
  }

  Future<http.StreamedResponse> addPartSubAssemblyProcessing(
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
      partProcessing = GlobalVariables.requestBody['PartSubAssemblyProcessing'];
    }
    http.StreamedResponse response =
        await networkService.post("/add-psa-processing/", partProcessing);
    return response;
  }

  Future<http.StreamedResponse> addPartSubAssemblyDetails(
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
      data = GlobalVariables.requestBody['PartSubAssemblyDetails'];
    }
    http.StreamedResponse response =
        await networkService.post("/add-psa-details/", data);
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
}
