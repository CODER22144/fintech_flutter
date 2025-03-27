import 'dart:convert';

import 'package:fintech_new_web/features/common/widgets/custom_dropdown_field.dart';
import 'package:fintech_new_web/features/common/widgets/custom_text_field.dart';
import 'package:fintech_new_web/features/utility/global_variables.dart';
import 'package:fintech_new_web/features/utility/models/forms_UI.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';

import '../../network/service/network_service.dart';
import '../../utility/services/common_utility.dart';
import '../../utility/services/generate_form_service.dart';

class PaymentClearProvider with ChangeNotifier {
  static const String featureName = "paymentClear";

  List<FormUI> formFieldDetails = [];
  List<Widget> widgetList = [];
  List<dynamic> paymentAdvancePending = [];
  List<dynamic> paymentUnadjustedPending = [];

  NetworkService networkService = NetworkService();
  GenerateFormService formService = GenerateFormService();

  List<SearchableDropdownMenuItem<String>> voucherType = [];
  SearchableDropdownController<String> voucherTypeController =
      SearchableDropdownController<String>();
  TextEditingController bamountController = TextEditingController();

  void initWidget(String details) async {
    voucherTypeController.clear();
    bamountController.clear();
    var data = jsonDecode(details);
    String jsonData =
        '[{"id":"payId","name":"Pay ID","isMandatory":true,"inputType":"number", "default" : "${data['payId']}"},{"id":"payType","name":"Pay Type","isMandatory":true,"inputType":"dropdown","dropdownMenuItem":"/get-pay-type/", "default" : "O"},{"id":"amount","name":"Amount","isMandatory":true,"inputType":"number", "default" : "${data['unadjusted']}"},{"id":"clnaration","name":"Naration","isMandatory":false,"inputType":"text","maxCharacter":100}]';

    GlobalVariables.requestBody[featureName] = {};
    formFieldDetails.clear();
    widgetList.clear();

    for (var element in jsonDecode(jsonData)) {
      TextEditingController controller = TextEditingController();
      if((data['vtype'] == 'D' || data['vtype'] == 'T') && element['id'] == 'payType') {
        continue;
      }
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
    initCustomWidget(data['lcode']);
  }

  void initCustomWidget(String lcode) async {
    voucherType = await formService.getDropdownMenuItem("/get-voucher-type/");
    var transIdItems = await formService
        .getDropdownMenuItem("/get-bill-pending-by-lcode/$lcode/");
    widgetList.addAll([
      CustomDropdownField(
          field: FormUI(
              id: "transId",
              name: "Transaction ID",
              isMandatory: true,
              inputType: "dropdown"),
          customFunction: getVoucherTypeBylcode,
          dropdownMenuItems: transIdItems,
          feature: featureName),
      CustomDropdownField(
          field: FormUI(
              id: "vtype",
              name: "Voucher Type",
              isMandatory: true,
              inputType: "dropdown",
              controller: voucherTypeController,
              readOnly: true),
          dropdownMenuItems: voucherType,
          feature: featureName),
      CustomTextField(
          field: FormUI(
              id: "bamount",
              name: "Balance Amount",
              isMandatory: false,
              inputType: "number",
              controller: bamountController,
              readOnly: true),
          feature: featureName,
          inputType: TextInputType.number)
    ]);
    notifyListeners();
  }

  Future<http.StreamedResponse> processFormInfo() async {
    http.StreamedResponse response = await networkService.post(
        "/add-payment-clear/", [GlobalVariables.requestBody[featureName]]);
    return response;
  }

  Future<http.StreamedResponse> submitFormInfoTypeD() async {
    http.StreamedResponse response = await networkService.post(
        "/add-dbnote-clear/", [GlobalVariables.requestBody[featureName]]);
    return response;
  }

  Future<http.StreamedResponse> submitFormInfoTypeT() async {
    http.StreamedResponse response = await networkService.post(
        "/add-prtax-invoice-clear/", [GlobalVariables.requestBody[featureName]]);
    return response;
  }

  void getPaymentAdvancePendingReport() async {
    http.StreamedResponse response =
        await networkService.get("/get-payment-advance-pending/");
    if (response.statusCode == 200) {
      paymentAdvancePending = jsonDecode(await response.stream.bytesToString());
    }
    notifyListeners();
  }

  void getVoucherTypeBylcode() async {
    var transId = GlobalVariables.requestBody[featureName]['transId'];
    if (transId != null && transId != "") {
      http.StreamedResponse response =
          await networkService.get("/get-bill-pending-by-transId/$transId/");
      if (response.statusCode == 200) {
        var details = jsonDecode(await response.stream.bytesToString())[0];
        var vType = findDropdownMenuItem(voucherType, details['vtype']);
        voucherTypeController.selectedItem.value = vType;
        bamountController.text = details['bamount'];
        GlobalVariables.requestBody[featureName]['vtype'] = details['vtype'];
      }
    }
    notifyListeners();
  }

  void getUnadjustedPaymentPending() async {
    paymentUnadjustedPending.clear();
    http.StreamedResponse response =
    await networkService.get("/get-unadjusted-payment-pending/");
    if (response.statusCode == 200) {
      paymentUnadjustedPending = jsonDecode(await response.stream.bytesToString());
    }
    notifyListeners();
  }
}
