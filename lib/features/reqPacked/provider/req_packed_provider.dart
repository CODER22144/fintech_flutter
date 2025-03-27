import 'dart:convert';

import 'package:fintech_new_web/features/utility/global_variables.dart';
import 'package:fintech_new_web/features/utility/models/forms_UI.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../network/service/network_service.dart';
import '../../utility/services/generate_form_service.dart';

class ReqPackedProvider with ChangeNotifier {
  static const String featureName = "ReqPacked";

  List<FormUI> formFieldDetails = [];
  List<Widget> widgetList = [];
  List<dynamic> reqPending = [];

  NetworkService networkService = NetworkService();
  GenerateFormService formService = GenerateFormService();

  void initWidget(String details) async {
    GlobalVariables.requestBody[featureName] = {};
    formFieldDetails.clear();
    widgetList.clear();

    var data = jsonDecode(details);

    String jsonData =
        '[{"id":"packId","name":"Id","isMandatory":true,"inputType":"text", "default" : "${data['packId']}"},{"id":"matno","name":"Material no.","isMandatory":true,"inputType":"text","maxCharacter":15, "default":"${data['matno']}"},{"id":"pkdqty","name":"Packed Quantity","isMandatory":true,"inputType":"number", "default" : "${data['blqty']}"}]';

    for (var element in jsonDecode(jsonData)) {
      TextEditingController controller = TextEditingController();
      formFieldDetails.add(FormUI(
          id: element['id'],
          name: element['name'],
          isMandatory: element['isMandatory'],
          inputType: element['inputType'],
          dropdownMenuItem: element['dropdownMenuItem'] ?? "",
          controller: controller,
          defaultValue: element['default'],
          maxCharacter: element['maxCharacter'] ?? 255));
    }

    List<Widget> widgets =
    await formService.generateDynamicForm(formFieldDetails, featureName);
    widgetList.addAll(widgets);
    notifyListeners();
  }

  Future<http.StreamedResponse> processFormInfo() async {
    http.StreamedResponse response = await networkService.post(
        "/add-req-packed/", GlobalVariables.requestBody[featureName]);
    return response;
  }

  void getReqPackedPending() async {
    reqPending.clear();
    http.StreamedResponse response = await networkService.get(
        "/get-req-packed-pending/");
    if (response.statusCode == 200) {
      reqPending = jsonDecode(await response.stream.bytesToString());
    }
    notifyListeners();
  }
}
