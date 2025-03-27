import 'dart:convert';

import 'package:fintech_new_web/features/utility/global_variables.dart';
import 'package:fintech_new_web/features/utility/models/forms_UI.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';

import '../../network/service/network_service.dart';
import '../../utility/services/generate_form_service.dart';

class PaymentProvider with ChangeNotifier {
  static const String featureName = "payment";
  static const String reportFeature = "paymentReport";

  List<FormUI> formFieldDetails = [];
  List<Widget> widgetList = [];
  List<Widget> reportWidgetList = [];
  TextEditingController editController = TextEditingController();
  List<SearchableDropdownMenuItem<String>> partyCodes = [];
  List<dynamic> billPending = [];

  NetworkService networkService = NetworkService();
  GenerateFormService formService = GenerateFormService();

  void reset() {
    editController.clear();
    editController.text = "";
    GlobalVariables.requestBody[featureName] = {};
    formFieldDetails.clear();
    widgetList.clear();
    notifyListeners();
  }

  void getPartyCodes() async {
    partyCodes = await formService.getDropdownMenuItem("/get-ledger-codes/");
    notifyListeners();
  }

  void initWidget(String partyCode) async {
    var data = jsonDecode(partyCode);
    String jsonData =
        '[{"id":"mop","name":"Mode of Payment","isMandatory":true,"inputType":"dropdown","dropdownMenuItem":"/get-mop/", "default" : "B"},{"id":"lcode","name":"Party Code","isMandatory":true,"inputType":"dropdown","dropdownMenuItem":"/get-ledger-codes/", "default" : "${data['lcode']}", "readOnly" : true},{"id":"crdrCode","name":"CR/DR Code","isMandatory":true,"inputType":"dropdown","dropdownMenuItem":"/get-ledger-codes/", "default" : "${data['crdrCode']}","readOnly":true},{"id":"naration","name":"Naration","isMandatory":false,"inputType":"text","maxCharacter":100, "default" : "${data['paynaration']}"},{"id":"transId","name":"Transaction ID","isMandatory":true,"inputType":"dropdown","dropdownMenuItem":"/get-bill-pending-by-lcode/${data['lcode']}/","default":"${data['transId']}","readOnly":true},{"id":"vtype","name":"Voucher Type","isMandatory":true,"inputType":"dropdown","dropdownMenuItem":"/get-voucher-type/","maxCharacter":100,"default":"${data['vtype']}","readOnly":true},{"id":"amount","name":"Amount","isMandatory":true,"inputType":"number","default":"${data['bamount']}"}]';

    GlobalVariables.requestBody[featureName] = {};
    formFieldDetails.clear();
    widgetList.clear();

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
    notifyListeners();
  }

  void initEditWidget() async {
    String jsonData =
        '[{"id":"tdate","name":"Transaction Date","isMandatory":true,"inputType":"datetime"},{"id":"payType","name":"Pay Type","isMandatory":true,"inputType":"dropdown","dropdownMenuItem":"/get-pay-type/"},{"id":"mop","name":"Mode of Payment","isMandatory":true,"inputType":"dropdown","dropdownMenuItem":"/get-mop/"},{"id":"lcode","name":"Party Code","isMandatory":true,"inputType":"dropdown","dropdownMenuItem":"/get-ledger-codes/"},{"id":"crdrCode","name":"CR/DR Code","isMandatory":true,"inputType":"dropdown","dropdownMenuItem":"/get-ledger-codes/"},{"id":"amount","name":"Amount","isMandatory":true,"inputType":"number"},{"id":"naration","name":"Naration","isMandatory":false,"inputType":"text","maxCharacter":100},{"id":"adjusted","name":"Adjusted","isMandatory":true,"inputType":"number"},{"id":"unadjusted","name":"UnAdjusted","isMandatory":true,"inputType":"number"}]';

    Map<String, dynamic> editMapData = await getByIdPaymentInfo();
    GlobalVariables.requestBody[featureName] = editMapData;
    formFieldDetails.clear();
    widgetList.clear();

    for (var element in jsonDecode(jsonData)) {
      TextEditingController editController = TextEditingController();
      formFieldDetails.add(FormUI(
          id: element['id'],
          name: element['name'],
          isMandatory: false,
          inputType: element['inputType'],
          dropdownMenuItem: element['dropdownMenuItem'] ?? "",
          maxCharacter: element['maxCharacter'] ?? 255,
          controller: editController,
          defaultValue: editMapData[element['id']]));
    }

    List<Widget> widgets =
        await formService.generateDynamicForm(formFieldDetails, featureName);
    widgetList.addAll(widgets);
    notifyListeners();
  }

  Future<http.StreamedResponse> processFormInfo() async {
    http.StreamedResponse response = await networkService
        .post("/add-payment/", [GlobalVariables.requestBody[featureName]]);
    return response;
  }

  Future<http.StreamedResponse> processUpdateFormInfo() async {
    http.StreamedResponse response = await networkService.post(
        "/update-payment/", GlobalVariables.requestBody[featureName]);
    return response;
  }

  Future<Map<String, dynamic>> getByIdPaymentInfo() async {
    http.StreamedResponse response =
        await networkService.get("/get-payment/${editController.text}/");
    if (response.statusCode == 200) {
      return jsonDecode(await response.stream.bytesToString())[0];
    }
    return {};
  }

  void initReport() async {
    GlobalVariables.requestBody[reportFeature] = {};
    formFieldDetails.clear();
    reportWidgetList.clear();
    String jsonData =
        '[{"id":"lcode","name":"Party Code","isMandatory":false,"inputType":"dropdown","dropdownMenuItem":"/get-ledger-codes/"},{"id":"fdate","name":"From Date","isMandatory":true,"inputType":"datetime"},{"id":"tdate","name":"To Date","isMandatory":true,"inputType":"datetime"}]';

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

  void getBillPendingReport() async {
    http.StreamedResponse response = await networkService.post(
        "/get-payment-bill-pending/",
        GlobalVariables.requestBody[reportFeature]);
    if (response.statusCode == 200) {
      billPending = jsonDecode(await response.stream.bytesToString());
    }
    notifyListeners();
  }

  Future<dynamic> getInwardClear(String transId, String vType) async {
    http.StreamedResponse response = await networkService
        .post("/get-inward-clear/", {"transId": transId, "vType": vType});
    if (response.statusCode == 200) {
      return jsonDecode(await response.stream.bytesToString());
    }
  }
}
