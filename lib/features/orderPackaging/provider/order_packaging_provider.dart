import 'dart:convert';

import 'package:fintech_new_web/features/common/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../network/service/network_service.dart';
import '../../utility/global_variables.dart';
import '../../utility/models/forms_UI.dart';
import '../../utility/services/generate_form_service.dart';

class OrderPackagingProvider with ChangeNotifier {
  static const String featureName = "orderPackaging";

  List<FormUI> formFieldDetails = [];
  List<Widget> widgetList = [];
  List<dynamic> orderPackagingPending = [];
  List<dynamic> orderPackagingPosted = [];
  List<dynamic> orderBalance = [];

  TextEditingController materialController = TextEditingController();
  TextEditingController qtyController = TextEditingController();

  NetworkService networkService = NetworkService();
  GenerateFormService formService = GenerateFormService();
  String jsonData =
      '[{"id":"orderId","name":"Order Id","isMandatory":true,"inputType":"number", "readOnly":true}]';

  void getOrderPackagingPending() async {
    orderPackagingPending.clear();
    http.StreamedResponse response =
        await networkService.get("/get-order-packing-pending/");
    if (response.statusCode == 200) {
      var data = jsonDecode(await response.stream.bytesToString());
      orderPackagingPending = data;
    }
    notifyListeners();
  }

  void initWidget(String orderId) async {
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
          defaultValue:
              element['id'] == "orderId" ? orderId : element['default'],
          controller: controller,
          readOnly: element['readOnly'] ?? false));
    }

    List<Widget> widgets =
        await formService.generateDynamicForm(formFieldDetails, featureName);
    widgetList.addAll(widgets);

    initOrderPackedInfo(orderId);
  }

  void packedOrderInfo(String orderId) async {
    http.StreamedResponse response =
        await networkService.get("/add-order-packed-info/$orderId/");
    orderPackagingPosted.clear();
    if (response.statusCode == 200) {
      var data = jsonDecode(await response.stream.bytesToString());
    orderPackagingPosted = data;
  }
    notifyListeners();
  }

  void initOrderPackedInfo(String orderId) async {
    packedOrderInfo(orderId);

    widgetList.addAll([
      CustomTextField(
          field: FormUI(
              id: "icode",
              name: "Material No.",
              isMandatory: true,
              inputType: "text",
              controller: materialController),
          feature: featureName,
          inputType: TextInputType.text,
          customMethod: inputQuantity),
      CustomTextField(
          field: FormUI(
              id: "qty",
              name: "Quantity",
              isMandatory: true,
              inputType: "text",
              controller: qtyController),
          feature: featureName,
          inputType: TextInputType.text)
    ]);
    notifyListeners();
  }

  void inputQuantity() {
    qtyController.text = materialController.text.length >= 3
        ? materialController.text.substring(materialController.text.length - 3)
        : materialController.text;
    GlobalVariables.requestBody[featureName]['qty'] = qtyController.text;
    GlobalVariables.requestBody[featureName]['icode'] = materialController.text
        .substring(0, materialController.text.length - 3);
    notifyListeners();
  }

  Future<http.StreamedResponse> processFormInfo() async {
    http.StreamedResponse response = await networkService.post(
        "/add-order-packaging/", GlobalVariables.requestBody[featureName]);
    setOrderPackagingPosted(response);
    return response;
  }

  void setOrderPackagingPosted(http.StreamedResponse response) async {
    orderPackagingPosted.clear();
    if (response.statusCode == 200) {
      var data = jsonDecode(await response.stream.bytesToString());
      orderPackagingPosted = data;
    }
    notifyListeners();
  }

  void getOrderBalance(String orderId) async {
    orderBalance.clear();
    http.StreamedResponse response =
        await networkService.get("/get-order-balance/$orderId/");
    if (response.statusCode == 200) {
      orderBalance = jsonDecode(await response.stream.bytesToString());
    }
    notifyListeners();
  }

  Future<http.StreamedResponse> deleteOrderPackaging(String opId) async {
    http.StreamedResponse response =
        await networkService.post("/delete-order-packaging/$opId/", {});
    return response;
  }
}
