import 'dart:convert';

import 'package:fintech_new_web/features/common/widgets/custom_dropdown_field.dart';
import 'package:fintech_new_web/features/common/widgets/custom_text_field.dart';
import 'package:fintech_new_web/features/utility/global_variables.dart';
import 'package:fintech_new_web/features/utility/models/forms_UI.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../camera/service/camera_service.dart';
import '../../network/service/network_service.dart';
import '../../utility/services/generate_form_service.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';

class FinancialCrnoteProvider with ChangeNotifier {
  static const String featureName = "financialCrnoteProvider";

  List<FormUI> formFieldDetails = [];
  List<Widget> widgetList = [];
  TextEditingController totalAmountController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController rtod = TextEditingController();
  TextEditingController rtodController = TextEditingController();

  NetworkService networkService = NetworkService();
  GenerateFormService formService = GenerateFormService();
  String jsonData =
      '[{"id":"fcnsno","name":"Serial no.","isMandatory":true,"inputType":"number"},{"id":"tDate","name":"Transaction Date","isMandatory":true,"inputType":"datetime"},{"id":"fcnType","name":"Credit Note Type","isMandatory":true,"inputType":"dropdown","dropdownMenuItem":"/get-crn-type/"},{"id":"lcode","name":"Party Code","isMandatory":true,"inputType":"dropdown","dropdownMenuItem":"/get-ledger-codes/"},{"id":"dbCode","name":"Debit Code","isMandatory":true,"inputType":"dropdown","dropdownMenuItem":"/get-ledger-codes/"},{"id":"naration","name":"Naration","isMandatory":true,"inputType":"text","maxCharacter":100}]';

  void initWidget() async {
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
          controller: controller));
    }

    List<Widget> widgets =
        await formService.generateDynamicForm(formFieldDetails, featureName);
    widgetList.addAll(widgets);
    initCustomObject();
  }

  void initCustomObject() async {
    List<SearchableDropdownMenuItem<String>> rateTod = await getTodRate();
    widgetList.addAll([
      CustomTextField(
          field: FormUI(
              id: "amount",
              name: "Amount",
              isMandatory: true,
              inputType: "number",
              controller: amountController,
              defaultValue: 0),
          feature: featureName,
          inputType: TextInputType.number,
          customMethod: calculateTotalAmount),
      CustomDropdownField(
        field: FormUI(
            id: "rtod",
            name: "Tod Rate",
            isMandatory: true,
            inputType: "number",
            controller: rtodController,
            defaultValue: 0.00),
        feature: featureName,
        customFunction: calculateTotalAmount,
        dropdownMenuItems: rateTod,
      ),
      CustomTextField(
          field: FormUI(
              id: "tamount",
              name: "Total Amount",
              isMandatory: true,
              inputType: "number",
              controller: totalAmountController,
              defaultValue: 0,
              readOnly: true),
          feature: featureName,
          inputType: TextInputType.number)
    ]);
    notifyListeners();
  }

  void calculateTotalAmount() {
    totalAmountController.text = (double.parse(
                "${GlobalVariables.requestBody[featureName]["amount"] ?? "0"}") *
            double.parse(
                "${GlobalVariables.requestBody[featureName]["rtod"] ?? "0"}") *
            0.01)
        .toStringAsFixed(2);
    notifyListeners();
  }

  Future<List<SearchableDropdownMenuItem<String>>> getTodRate() async {
    List<SearchableDropdownMenuItem<String>> discountType = [];
    http.StreamedResponse response =
        await networkService.get("/get-tod-rate/");
    if (response.statusCode == 200) {
      var data = jsonDecode(await response.stream.bytesToString());
      for (var element in data) {
        discountType.add(SearchableDropdownMenuItem(
            value: "${element["rtod"]}",
            child: Text("${element["rtod"]}"),
            label: "${element["rtod"]}"));
      }
    }
    return discountType;
  }

  Future<http.StreamedResponse> processFormInfo() async {
    http.StreamedResponse response = await networkService.post(
        "/create-financial-crnote/", [GlobalVariables.requestBody[featureName]]);
    return response;
  }
}
