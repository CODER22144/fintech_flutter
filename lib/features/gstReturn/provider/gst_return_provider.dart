import 'dart:convert';

import 'package:fintech_new_web/features/utility/global_variables.dart';
import 'package:fintech_new_web/features/utility/models/forms_UI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../network/service/network_service.dart';
import '../../utility/services/generate_form_service.dart';

class GstReturnProvider with ChangeNotifier {
  String featureName = "b2b";

  List<FormUI> formFieldDetails = [];
  List<Widget> widgetList = [];

  List<dynamic> b2bReport = [];
  List<dynamic> b2cReport = [];
  List<dynamic> b2ClReport = [];
  List<dynamic> gstHsnSummary = [];
  List<dynamic> crdrNote = [];
  List<dynamic> docType = [];

  NetworkService networkService = NetworkService();
  GenerateFormService formService = GenerateFormService();

  void initReport() async {
    GlobalVariables.requestBody[featureName] = {};
    formFieldDetails.clear();
    widgetList.clear();
    String jsonData =
        '[{"id":"fromDate","name":"From Date","isMandatory":true,"inputType":"datetime"},{"id":"toDate","name":"To Date","isMandatory":true,"inputType":"datetime"}]';

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
    await formService.generateDynamicForm(formFieldDetails, featureName, disableDefault: true);
    widgetList.addAll(widgets);
    notifyListeners();
  }

  void getB2bReport() async {
    b2bReport.clear();
    http.StreamedResponse response = await networkService.post(
        "/get-b2b/", GlobalVariables.requestBody[featureName]);
    if (response.statusCode == 200) {
      b2bReport = jsonDecode(await response.stream.bytesToString());
    }
    notifyListeners();
  }

  void getB2cReport() async {
    b2cReport.clear();
    http.StreamedResponse response = await networkService.post(
        "/get-b2c/", GlobalVariables.requestBody[featureName]);
    if (response.statusCode == 200) {
      b2cReport = jsonDecode(await response.stream.bytesToString());
    }
    notifyListeners();
  }

  void getB2ClReport() async {
    b2ClReport.clear();
    http.StreamedResponse response = await networkService.post(
        "/get-b2Cl/", GlobalVariables.requestBody[featureName]);
    if (response.statusCode == 200) {
      b2ClReport = jsonDecode(await response.stream.bytesToString());
    }
    notifyListeners();
  }

  void getGstHsnReport() async {
    gstHsnSummary.clear();
    http.StreamedResponse response = await networkService.post(
        "/get-gst-hsn/", GlobalVariables.requestBody[featureName]);
    if (response.statusCode == 200) {
      gstHsnSummary = jsonDecode(await response.stream.bytesToString());
    }
    notifyListeners();
  }

  void getCrDrNote() async {
    crdrNote.clear();
    http.StreamedResponse response = await networkService.post(
        "/get-crdr-note/", GlobalVariables.requestBody[featureName]);
    if (response.statusCode == 200) {
      crdrNote = jsonDecode(await response.stream.bytesToString());
    }
    notifyListeners();
  }

  void getDocType() async {
    docType.clear();
    http.StreamedResponse response = await networkService.post(
        "/get-doc-type/", GlobalVariables.requestBody[featureName]);
    if (response.statusCode == 200) {
      docType = jsonDecode(await response.stream.bytesToString());
    }
    notifyListeners();
  }

}