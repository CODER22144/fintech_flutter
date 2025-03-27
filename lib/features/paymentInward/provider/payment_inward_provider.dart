import 'dart:convert';

import 'package:fintech_new_web/features/utility/global_variables.dart';
import 'package:fintech_new_web/features/utility/models/forms_UI.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../common/widgets/custom_dropdown_field.dart';
import '../../common/widgets/custom_text_field.dart';
import '../../network/service/network_service.dart';
import '../../utility/services/common_utility.dart';
import '../../utility/services/generate_form_service.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';

class PaymentInwardProvider with ChangeNotifier {
  static const String featureName = "PaymentInward";
  static const String clearFeature = "CrNoteClear";

  List<FormUI> formFieldDetails = [];
  List<Widget> widgetList = [];
  List<SearchableDropdownMenuItem<String>> partyCodes = [];

  List<dynamic> unadjPaymentInward = [];

  NetworkService networkService = NetworkService();
  GenerateFormService formService = GenerateFormService();

  List<SearchableDropdownMenuItem<String>> voucherType = [];
  SearchableDropdownController<String> voucherTypeController =
      SearchableDropdownController<String>();
  TextEditingController bamountController = TextEditingController();

  String jsonData =
      '[{"id":"mop","name":"Mode Of Payment","isMandatory":true,"inputType":"dropdown","dropdownMenuItem":"/get-mop/"},{"id":"lcode","name":"Party Code","isMandatory":true,"inputType":"dropdown","dropdownMenuItem":"/get-ledger-codes/"},{"id":"crdrCode","name":"CR/DR Code","isMandatory":true,"inputType":"dropdown","dropdownMenuItem":"/get-ledger-codes/"},{"id":"amount","name":"Amount","isMandatory":true,"inputType":"number"},{"id":"naration","name":"Naration","isMandatory":true,"inputType":"text"}]';

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
          controller: controller,
          maxCharacter: element['maxCharacter'] ?? 255));
    }

    List<Widget> widgets =
        await formService.generateDynamicForm(formFieldDetails, featureName);
    widgetList.addAll(widgets);
    notifyListeners();
  }

  Future<http.StreamedResponse> processFormInfo() async {
    http.StreamedResponse response = await networkService.post(
        "/add-payment-inward/", [GlobalVariables.requestBody[featureName]]);
    return response;
  }

  Future<http.StreamedResponse> addCrNoteClear() async {
    http.StreamedResponse response = await networkService
        .post("/add-crnote-clear/", [GlobalVariables.requestBody[clearFeature]]);
    return response;
  }

  void getUnadjustedPaymentInward() async {
    unadjPaymentInward.clear();
    http.StreamedResponse response =
        await networkService.get("/get-unadjusted-payment-inward/");
    if (response.statusCode == 200) {
      unadjPaymentInward = jsonDecode(await response.stream.bytesToString());
    }
    notifyListeners();
  }

  void initClearWidget(String details) async {
    voucherTypeController.clear();
    bamountController.clear();
    var data = jsonDecode(details);
    String jsonData =
        '[{"id":"payId","name":"Doc No.","isMandatory":true,"inputType":"number", "default" : "${data['docno']}"},{"id":"amount","name":"Amount","isMandatory":true,"inputType":"number", "default" : "${data['bamount']}"},{"id":"clnaration","name":"Naration","isMandatory":false,"inputType":"text","maxCharacter":100}]';

    GlobalVariables.requestBody[clearFeature] = {};
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
        await formService.generateDynamicForm(formFieldDetails, clearFeature);
    widgetList.addAll(widgets);
    initCustomWidget(data['lcode']);
  }

  void initCustomWidget(String lcode) async {
    voucherType = await formService.getDropdownMenuItem("/get-pay-pending-type/");
    var transIdItems = await formService
        .getDropdownMenuItem("/get-payment-pending-lcode/$lcode/");
    widgetList.addAll([
      CustomDropdownField(
          field: FormUI(
              id: "transId",
              name: "Transaction ID",
              isMandatory: true,
              inputType: "dropdown"),
          customFunction: getVoucherTypeBylcode,
          dropdownMenuItems: transIdItems,
          feature: clearFeature),
      CustomDropdownField(
          field: FormUI(
              id: "vtype",
              name: "Voucher Type",
              isMandatory: true,
              inputType: "dropdown",
              controller: voucherTypeController,
              readOnly: true),
          dropdownMenuItems: voucherType,
          feature: clearFeature),
      CustomTextField(
          field: FormUI(
              id: "bamount",
              name: "Balance Amount",
              isMandatory: false,
              inputType: "number",
              controller: bamountController,
              readOnly: true),
          feature: clearFeature,
          inputType: TextInputType.number)
    ]);
    notifyListeners();
  }

  void getVoucherTypeBylcode() async {
    String transId = GlobalVariables.requestBody[clearFeature]['transId'];
    var split = transId.split("|");
    if (transId != null && transId != "") {
      http.StreamedResponse response =
          await networkService.post("/get-payment-pending-transId/", {"transId" : split[1], "vType" : split[0]});
      if (response.statusCode == 200) {
        var details = jsonDecode(await response.stream.bytesToString())[0];
        var vType = findDropdownMenuItem(voucherType, details['vtype']);
        voucherTypeController.selectedItem.value = vType;
        bamountController.text = details['bamount'];
        GlobalVariables.requestBody[clearFeature]['vtype'] = details['vtype'];
        GlobalVariables.requestBody[clearFeature]['transId'] = details['transId'];
      }
    }
    notifyListeners();
  }
}
