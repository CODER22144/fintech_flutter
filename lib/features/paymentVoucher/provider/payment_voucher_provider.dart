import 'dart:convert';

import 'package:fintech_new_web/features/common/widgets/custom_text_field.dart';
import 'package:fintech_new_web/features/utility/global_variables.dart';
import 'package:fintech_new_web/features/utility/models/forms_UI.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';

import '../../common/widgets/custom_dropdown_field.dart';
import '../../network/service/network_service.dart';
import '../../utility/services/common_utility.dart';
import '../../utility/services/generate_form_service.dart';

class PaymentVoucherProvider with ChangeNotifier {
  static const String featureName = "paymentVoucher";


  List<FormUI> formFieldDetails = [];
  List<Widget> widgetList = [];
  List<SearchableDropdownMenuItem<String>> supplyType = [];

  TextEditingController hsnController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController gstRateController = TextEditingController();
  TextEditingController gstAmountController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();

  SearchableDropdownController<String> supplyController = SearchableDropdownController<String>();

  NetworkService networkService = NetworkService();
  GenerateFormService formService = GenerateFormService();
  String jsonData =
      '[{"id":"pvno","name":"Payment Voucher No.","isMandatory":true,"inputType":"number"},{"id":"tDate","name":"Transaction Date","isMandatory":true,"inputType":"datetime"},{"id":"naration","name":"Naration","isMandatory":true,"inputType":"text","maxCharacter":100},{"id":"lcode","name":"Party Code","isMandatory":true,"inputType":"dropdown","dropdownMenuItem":"/get-ledger-codes/"}]';

  void initWidget() async {
    supplyController.clear();
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
          eventTrigger: element['id'] == 'lcode' ? autoFillDetailsByPartyCode : null));
    }

    List<Widget> widgets =
    await formService.generateDynamicForm(formFieldDetails, featureName);
    widgetList.addAll(widgets);
    initCustomObject();
  }

  void initCustomObject() async {
    supplyType = await formService.getDropdownMenuItem("/get-supply-type/");
    widgetList.addAll([
      CustomDropdownField(
          field: FormUI(
              id: "slId",
              name: "Supply Type",
              isMandatory: true,
              inputType: "dropdown",
              controller: supplyController),
          dropdownMenuItems: supplyType,
          feature: featureName),
      Focus(
        onFocusChange: (hasFocus) {
          if(!hasFocus) {
            getGstTaxRate();
          }
        },
        child: CustomTextField(
            field: FormUI(
                id: "hsnCode",
                name: "HSN Code",
                isMandatory: true,
                inputType: "text",
                maxCharacter: 10,
                controller: hsnController),
            feature: featureName,
            inputType: TextInputType.number),
      ),
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
          customMethod: setCalculatedAmounts),
      CustomTextField(
          field: FormUI(
              id: "rgst",
              name: "Gst Tax Rate",
              isMandatory: true,
              inputType: "number",
              controller: gstRateController,
              defaultValue: 0,
              readOnly: true),
          feature: featureName,
          inputType: TextInputType.number),
      CustomTextField(
          field: FormUI(
              id: "gstAmount",
              name: "Gst Amount",
              isMandatory: true,
              inputType: "number",
              controller: gstAmountController,
              defaultValue: 0,
              readOnly: true),
          feature: featureName,
          inputType: TextInputType.number),
      CustomTextField(
          field: FormUI(
              id: "tAmount",
              name: "Total Amount",
              isMandatory: true,
              inputType: "number",
              controller: totalAmountController,
              defaultValue: 0,
              readOnly: true),
          feature: featureName,
          inputType: TextInputType.number),
    ]);
    notifyListeners();

  }

  Future<http.StreamedResponse> processFormInfo() async {
    http.StreamedResponse response = await networkService.post(
        "/create-payment-voucher/", [GlobalVariables.requestBody[featureName]]);
    return response;
  }

  void setCalculatedAmounts() {
    gstAmountController.text = calculateGstAmount().toString();
    totalAmountController.text = calculateTotalAmount().toString();
    GlobalVariables.requestBody[featureName]['gstAmount'] = gstAmountController.text;
    notifyListeners();
  }

  double calculateTotalAmount() {
    double totalAmount = double.parse(amountController.text) + calculateGstAmount();
    return totalAmount;
  }

  double calculateGstAmount() {
    double gstAmount = double.parse(amountController.text) *
        double.parse(
            "${GlobalVariables.requestBody[featureName]['rgst'] ?? "0"}") *
        0.01;
    return double.parse(gstAmount.toStringAsFixed(2));
  }

  void getGstTaxRate() async {
    NetworkService networkService = NetworkService();
    if(hsnController.text == "") {
      gstRateController.text = "0";
      totalAmountController.text = "0";
      GlobalVariables.requestBody[featureName]['rgst'] = gstRateController.text;
      notifyListeners();
    }
    if (hsnController.text != null && hsnController.text != "") {
      http.StreamedResponse response =
      await networkService.get("/get-hsn/${hsnController.text}/");
      if (response.statusCode == 200) {
        var hsnDetails = jsonDecode(await response.stream.bytesToString());
        gstRateController.text = hsnDetails[0]['gstTaxRate'] ?? "0";
        GlobalVariables.requestBody[featureName]['rgst'] = gstRateController.text;
        notifyListeners();
      } else {
        gstRateController.text = "0";
        GlobalVariables.requestBody[featureName]['rgst'] = gstRateController.text;
      }
    }
    setCalculatedAmounts();
  }

  void autoFillDetailsByPartyCode() async {
    var partyCode = GlobalVariables.requestBody[featureName]['lcode'];
    if(partyCode != null && partyCode != "") {
      http.StreamedResponse response = await networkService.get("/get-ledger-code-supply/$partyCode/");
      if(response.statusCode == 200) {
        var details = jsonDecode(await response.stream.bytesToString())[0];
        var supplyItem = findDropdownMenuItem(supplyType, details['slId']);
        supplyController.selectedItem.value = supplyItem;
        GlobalVariables.requestBody[featureName]['slId'] = details['slId'];
      }
    }
    notifyListeners();
  }

}
