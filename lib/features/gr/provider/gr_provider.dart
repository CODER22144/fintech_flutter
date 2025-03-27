import 'dart:convert';

import 'package:fintech_new_web/features/common/widgets/custom_dropdown_field.dart';
import 'package:fintech_new_web/features/common/widgets/pop_ups.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fintech_new_web/features/utility/global_variables.dart';
import 'package:fintech_new_web/features/utility/models/forms_UI.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';

import '../../network/service/network_service.dart';
import '../../utility/services/generate_form_service.dart';

class GrProvider with ChangeNotifier {
  static const String featureName = "gr";
  static const String reportFeature = "grReport";

  List<FormUI> formFieldDetails = [];
  List<Widget> widgetList = [];
  List<Widget> rateDiffWidgetList = [];

  List<dynamic> grPending = [];
  List<dynamic> grShortagePending = [];
  List<dynamic> grRejectionPending = [];
  List<dynamic> grRateApprovalPending = [];

  DataTable table =
      DataTable(columns: const [DataColumn(label: Text(""))], rows: const []);

  NetworkService networkService = NetworkService();
  GenerateFormService formService = GenerateFormService();
  List<SearchableDropdownMenuItem<String>> dropdownItem = [];
  List<dynamic> grRateDiffPending = [];

  void initWidget(dynamic data) async {
    GlobalVariables.requestBody[featureName] = {};
    formFieldDetails.clear();
    widgetList.clear();
    var defaultData = jsonDecode(data);
    String jsonData =
        '[{"id": "grDate","name": "GR Date","isMandatory": true,"inputType": "datetime"},{"id": "brid","name": "Bill Receipt ID","isMandatory": true,"inputType": "number", "readOnly" : true, "default" : "${defaultData['brId']}"},{"id": "billNo","name": "Bill No.","isMandatory": true,"inputType": "text","maxCharacter": 30, "default" : "${defaultData['billNo']}"},{"id": "billDate","name": "Bill Date","isMandatory": true,"inputType": "datetime", "default" : "${defaultData['billDate']}" },{"id": "it","name": "Item Type","isMandatory": true,"inputType": "dropdown","dropdownMenuItem": "/get-item-type/", "default" : "I"}]';

    for (var element in jsonDecode(jsonData)) {
      TextEditingController textController = TextEditingController();
      formFieldDetails.add(FormUI(
          id: element['id'],
          name: element['name'],
          isMandatory: element['isMandatory'],
          inputType: element['inputType'],
          dropdownMenuItem: element['dropdownMenuItem'] ?? "",
          maxCharacter: element['maxCharacter'] ?? 255,
          readOnly: element['readOnly'] ?? false,
          controller: textController,
          defaultValue: element['default'],
          suffix: element['id'] == 'brid'
              ? viewBr(jsonDecode(data)['docImage'] ?? "")
              : null));
    }

    List<Widget> widgets =
        await formService.generateDynamicForm(formFieldDetails, featureName);
    widgetList.addAll(widgets);

    initCustomObject();
  }

  void initReport() async {
    GlobalVariables.requestBody[reportFeature] = {};
    formFieldDetails.clear();
    widgetList.clear();
    String jsonData =
        '[{"id":"grno","name":"GR No.","isMandatory":false,"inputType":"text"},{"id":"fromDate","name":"From Date","isMandatory":false,"inputType":"datetime"},{"id":"toDate","name":"To Date","isMandatory":false,"inputType":"datetime"}]';

    for (var element in jsonDecode(jsonData)) {
      formFieldDetails.add(FormUI(
          id: element['id'],
          name: element['name'],
          isMandatory: element['isMandatory'],
          inputType: element['inputType'],
          dropdownMenuItem: element['dropdownMenuItem'] ?? "",
          maxCharacter: element['maxCharacter'] ?? 255));
    }

    List<Widget> widgets = await formService.generateDynamicForm(
        formFieldDetails, reportFeature,
        disableDefault: true);
    widgetList.addAll(widgets);
    notifyListeners();
  }

  void initRateApprovalForm(String rateDetails) async {
    var data = jsonDecode(rateDetails);
    GlobalVariables.requestBody["grRateDifferenceApproval"] = {};
    formFieldDetails.clear();
    rateDiffWidgetList.clear();
    String jsonData =
        '[{"id":"grdId","name":"ID","isMandatory":true,"inputType":"number", "default" : "${data['grdId']}"},{"id":"apRate","name":"Rate","isMandatory":true,"inputType":"number", "default" : "${data['poRate']}"}]';

    for (var element in jsonDecode(jsonData)) {
      TextEditingController textController = TextEditingController();
      formFieldDetails.add(FormUI(
          id: element['id'],
          name: element['name'],
          isMandatory: element['isMandatory'],
          inputType: element['inputType'],
          dropdownMenuItem: element['dropdownMenuItem'] ?? "",
          maxCharacter: element['maxCharacter'] ?? 255,
          controller: textController,
          defaultValue: element['default']));
    }

    List<Widget> widgets = await formService.generateDynamicForm(
        formFieldDetails, "grRateDifferenceApproval");
    rateDiffWidgetList.addAll(widgets);
    notifyListeners();
  }

  void initCustomObject() async {
    List<SearchableDropdownMenuItem<String>> bp =
        await formService.getDropdownMenuItem("/get-business-partner/");
    widgetList.add(CustomDropdownField(
        field: FormUI(
            id: "bpCode",
            name: "Business Partner Code",
            isMandatory: true,
            inputType: "dropdown"),
        dropdownMenuItems: bp,
        feature: featureName,
        customFunction: getValidPurchaseOrderDropdown));
    notifyListeners();
  }

  void getPendingGr() async {
    http.StreamedResponse response =
        await networkService.get("/get-pending-gr/");
    if (response.statusCode == 200) {
      grPending = jsonDecode(await response.stream.bytesToString());
      notifyListeners();
    }
  }

  void getValidPurchaseOrderDropdown() async {
    dropdownItem.clear();
    http.StreamedResponse response = await networkService.get(
        "/valid-purchase-order/${GlobalVariables.requestBody[featureName]['bpCode']}/");
    if (response.statusCode == 200) {
      var data = jsonDecode(await response.stream.bytesToString());
      for (var element in data) {
        dropdownItem.add(SearchableDropdownMenuItem(
            value:
                "${element["poId"]}|${element["matno"]}|${element["hsnCode"]}|${element["poRate"]}",
            child: Text("${element["matno"]}  ${element["poId"]}"),
            label:
                "${element["poId"]} | ${element["matno"]}|${element["hsnCode"]}"));
      }
    }
    notifyListeners();
  }

  Future<http.StreamedResponse> processFormInfo(
      List<List<String>> tableRows) async {
    List<Map<String, dynamic>> orderDetails = [];
    for (int i = 0; i < tableRows.length; i++) {
      orderDetails.add({
        "matno": tableRows[i][0],
        "poId": tableRows[i][1],
        "grQty": tableRows[i][2],
        "grRate": tableRows[i][3],
        "hsnCode": tableRows[i][4]
      });
    }
    GlobalVariables.requestBody[featureName]['GrDetails'] = orderDetails;
    http.StreamedResponse response = await networkService.post(
        "/create-gr/", GlobalVariables.requestBody[featureName]);
    return response;
  }

  Future<http.StreamedResponse> addGrRateApproval() async {
    http.StreamedResponse response = await networkService.post(
        "/add-gr-rate-approval/",
        GlobalVariables.requestBody["grRateDifferenceApproval"]);
    return response;
  }

  void getGrRateDifferencePending() async {
    grRateDiffPending.clear();
    http.StreamedResponse response =
        await networkService.get("/get-rate-difference/");
    if (response.statusCode == 200) {
      var data = jsonDecode(await response.stream.bytesToString());
      grRateDiffPending = data;
    }
    notifyListeners();
  }

  Future<dynamic> getGrReport() async {
    http.StreamedResponse response = await networkService.post(
        "/gr-report/", GlobalVariables.requestBody[reportFeature]);
    if (response.statusCode == 200) {
      return jsonDecode(await response.stream.bytesToString());
    }
    notifyListeners();
  }

  void getGrRateApprovalPending() async {
    grRateApprovalPending.clear();
    http.StreamedResponse response =
    await networkService.get("/get-gr-rate-approval-pending/");
    if (response.statusCode == 200) {
      var data = jsonDecode(await response.stream.bytesToString());
      grRateApprovalPending = data;
    }
    notifyListeners();
  }

  void getGrShortagePending() async {
    grShortagePending.clear();
    http.StreamedResponse response =
    await networkService.get("/get-gr-shortage-pending/");
    if (response.statusCode == 200) {
      var data = jsonDecode(await response.stream.bytesToString());
      grShortagePending = data;
    }
    notifyListeners();
  }

  void getGrRejectionPending() async {
    grRejectionPending.clear();
    http.StreamedResponse response =
    await networkService.get("/get-gr-rejection-pending/");
    if (response.statusCode == 200) {
      var data = jsonDecode(await response.stream.bytesToString());
      grRejectionPending = data;
    }
    notifyListeners();
  }

  void nestedTable(BuildContext context) async {
    var report = await getGrReport();
    List<DataRow> rows = [];
    int counter = 0;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userData = prefs.getString("userData");
    Map<String, dynamic> user = {};
    if (userData != null) {
      user = jsonDecode(userData);
    }

    DataRow emptyRowNamed = const DataRow(cells: [
      DataCell(Text("")),
      DataCell(Text("")),
      DataCell(Text("")),
      DataCell(Text("")),
      DataCell(Text("")),
      DataCell(Text("")),
      DataCell(Text("")),
      DataCell(Text("")),
      DataCell(Text("")),
      DataCell(Text("")),
    ]);

    DataRow headerRow = const DataRow(cells: [
      DataCell(
          Text("Material No.", style: TextStyle(fontWeight: FontWeight.bold))),
      DataCell(
          Text("Description", style: TextStyle(fontWeight: FontWeight.bold))),
      DataCell(Text("HSN Code", style: TextStyle(fontWeight: FontWeight.bold))),
      DataCell(Align(
          alignment: Alignment.centerRight,
          child:
              Text("Quantity", style: TextStyle(fontWeight: FontWeight.bold)))),
      DataCell(Text("Unit", style: TextStyle(fontWeight: FontWeight.bold))),
      DataCell(Align(
          alignment: Alignment.centerRight,
          child: Text("Rate", style: TextStyle(fontWeight: FontWeight.bold)))),
      DataCell(Align(
          alignment: Alignment.centerRight,
          child:
              Text("Amount", style: TextStyle(fontWeight: FontWeight.bold)))),
      DataCell(Align(
          alignment: Alignment.centerRight,
          child: Text("Gst Tax Rate",
              style: TextStyle(fontWeight: FontWeight.bold)))),
      DataCell(Align(
          alignment: Alignment.centerRight,
          child: Text("Gst Amount",
              style: TextStyle(fontWeight: FontWeight.bold)))),
      DataCell(Align(
          alignment: Alignment.centerRight,
          child: Text("Total Amount",
              style: TextStyle(fontWeight: FontWeight.bold)))),
    ]);

    DataRow columnHeader = const DataRow(cells: [
      DataCell(Text("GR No.", style: TextStyle(fontWeight: FontWeight.bold))),
      DataCell(Text("GR Date", style: TextStyle(fontWeight: FontWeight.bold))),
      DataCell(Text("Business Partner",
          style: TextStyle(fontWeight: FontWeight.bold))),
      DataCell(Text("Address", style: TextStyle(fontWeight: FontWeight.bold))),
      DataCell(
          Text("Contact No.", style: TextStyle(fontWeight: FontWeight.bold))),
      DataCell(Text("Email", style: TextStyle(fontWeight: FontWeight.bold))),
      DataCell(Text("Bill Receipt ID",
          style: TextStyle(fontWeight: FontWeight.bold))),
      DataCell(Text("", style: TextStyle(fontWeight: FontWeight.bold))),
      DataCell(Text("", style: TextStyle(fontWeight: FontWeight.bold))),
      DataCell(Text("", style: TextStyle(fontWeight: FontWeight.bold))),
    ]);

    for (var data in report) {
      rows.add(DataRow(cells: [
        DataCell(InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              var cid = prefs.getString("currentLoginCid");
              final Uri uri = Uri.parse(
                  "${NetworkService.baseUrl}/srv/${data['grno']}/$cid/");
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
              } else {
                throw 'Could not launch';
              }
            },
            child: Text('${data['grno'] ?? "-"}',
                style: const TextStyle(
                    color: Colors.blueAccent, fontWeight: FontWeight.w500)))),
        DataCell(Text('${data['dDate'] ?? "-"}')),
        DataCell(Text('${data['bpName'] ?? "-"}')),
        DataCell(Text(
            '${data['bpAdd'] ?? "-"} ${data['bpAdd1'] ?? ""}\n${data['bpCity'] ?? "-"} - ${data['stateName'] ?? "-"}, ${data['bpZipCode'] ?? "-"}')),
        DataCell(Text('${data['bpPhone'] ?? "-"}')),
        DataCell(Text('${data['bpEmail'] ?? "-"}')),
        DataCell(Text('${data['brid'] ?? "-"}')),
        const DataCell(Text('')),
        DataCell(ElevatedButton(
            onPressed: () async {
              bool confirm = await showConfirmationDialogue(
                  context,
                  "This action will delete this GR. Are you sure ?",
                  "CONFIRM",
                  "CANCEL");
              if (confirm) {
                bool result = await deleteGr(data["grno"]);
                if (result) {
                  Navigator.of(context).pop(true);
                } else {
                  AlertDialog(
                    title: const Text('Error'),
                    content: const Text('Cannot Delete select Bill Receipt'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('ok'),
                        onPressed: () {
                          Navigator.of(context).pop(true); // Return true
                        },
                      ),
                    ],
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5), // Square shape
              ),
              padding: EdgeInsets
                  .zero, // Remove internal padding to make it square
              minimumSize:
                  const Size(80, 50), // Width and height for the button
            ),
            child: const Text(
              "Delete GR",
              style: TextStyle(color: Colors.white),
            ))),
        const DataCell(Text('')),
      ]));
      rows.add(headerRow);
      for (var poData in data['grd']) {
        rows.add(DataRow(cells: [
          DataCell(Text('${poData['matno'] ?? "-"}')),
          DataCell(Text('${poData['matDescription'] ?? "-"}')),
          DataCell(Text('${poData['hsnCode'] ?? "-"}')),
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text('${poData['grQty'] ?? "-"}'))),
          DataCell(Text('${poData['puUnit'] ?? "-"}')),
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text('${poData['grRate'] ?? "-"}'))),
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text('${poData['grAmount'] ?? "-"}'))),
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text('${poData['gstTaxRate'] ?? "-"}'))),
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text('${poData['gstAmount'] ?? "-"}'))),
          DataCell(Align(
              alignment: Alignment.centerRight,
              child: Text('${poData['tAmount'] ?? "-"}'))),
        ]));
      }
      rows.add(DataRow(cells: [
        const DataCell(Text('')),
        const DataCell(
            Text('Total', style: TextStyle(fontWeight: FontWeight.bold))),
        const DataCell(Text('', style: TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Align(
            alignment: Alignment.centerRight,
            child: Text('${data['sumgrQty'] ?? "-"}',
                style: const TextStyle(fontWeight: FontWeight.bold)))),
        const DataCell(Text('')),
        const DataCell(Text('')),
        DataCell(Align(
            alignment: Alignment.centerRight,
            child: Text('${data['sumgrAmount'] ?? "-"}',
                style: const TextStyle(fontWeight: FontWeight.bold)))),
        const DataCell(Text('')),
        DataCell(Align(
            alignment: Alignment.centerRight,
            child: Text('${data['sumgstAmount'] ?? "-"}',
                style: const TextStyle(fontWeight: FontWeight.bold)))),
        DataCell(Align(
            alignment: Alignment.centerRight,
            child: Text('${data['sumtAmount'] ?? "-"}',
                style: const TextStyle(fontWeight: FontWeight.bold)))),
      ]));
      counter = counter + 1;
      if (counter != report.length) {
        rows.add(emptyRowNamed);
        rows.add(columnHeader);
      }
    }

    table = DataTable(columns: const [
      DataColumn(
          label: Text("GR No.", style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(
          label:
              Text("GR Date", style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(
          label: Text("Business Partner",
              style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(
          label:
              Text("Address", style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(
          label: Text("Contact No.",
              style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(
          label: Text("Email", style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(
          label: Text("Bill Receipt ID",
              style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(
          label: Text("", style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(
          label: Text("", style: TextStyle(fontWeight: FontWeight.bold))),
      DataColumn(
          label: Text("", style: TextStyle(fontWeight: FontWeight.bold))),
    ], rows: rows);

    notifyListeners();
  }

  Future<bool> deleteGr(data) async {
    http.StreamedResponse response =
        await networkService.post("/delete-gr/", {"grno": data});
    if (response.statusCode == 204) {
      return true;
    }
    return false;
  }

  Widget viewBr(String url) {
    return ElevatedButton(
        onPressed: () async {
          final Uri uri = Uri.parse("${NetworkService.baseUrl}${url ?? ""}");
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
          } else {
            throw 'Could not launch $url';
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: HexColor("#0038a8"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3), // Square shape
          ),
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        ),
        child: const Text(
          "View Br",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ));
  }
}
