import 'dart:convert';

import 'package:fintech_new_web/features/utility/global_variables.dart';
import 'package:fintech_new_web/features/utility/models/forms_UI.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../network/service/network_service.dart';
import '../../utility/services/generate_form_service.dart';

class OrderBilledProvider with ChangeNotifier {
  static const String featureName = "OrderBilled";

  List<FormUI> formFieldDetails = [];
  List<Widget> widgetList = [];
  List<dynamic> pendingReport = [];

  NetworkService networkService = NetworkService();
  GenerateFormService formService = GenerateFormService();

  void initWidget(String orderId) async {
    GlobalVariables.requestBody[featureName] = {};
    formFieldDetails.clear();
    widgetList.clear();

    String jsonData =
        '[{"id":"orderid","name":"Order Id","isMandatory":true,"inputType":"number","readOnly":true, "default" : "$orderId"},{"id":"ewbno","name":"Eway Bill No.","isMandatory":false,"inputType":"text","maxCharacter":15}]';

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

  Future<http.StreamedResponse> processFormInfo() async {
    http.StreamedResponse response = await networkService
        .post("/add-order-billed/", GlobalVariables.requestBody[featureName]);
    return response;
  }

  void getOrderPending() async {
    pendingReport.clear();
    http.StreamedResponse response =
    await networkService.get("/get-order-billed-pending/");
    if (response.statusCode == 200) {
      var data = jsonDecode(await response.stream.bytesToString());
      pendingReport = data;
    }
    notifyListeners();
  }

  Future<http.StreamedResponse> postOrderBill(String orderId) async {
    http.StreamedResponse response = await networkService.post("/post-order-bill/", {"orderId" : orderId});
    return response;
  }
}
