import 'dart:convert';

import 'package:fintech_new_web/features/utility/global_variables.dart';
import 'package:fintech_new_web/features/utility/models/forms_UI.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../network/service/network_service.dart';
import '../../utility/services/generate_form_service.dart';

class WarehouseProvider with ChangeNotifier {
  static const String featureName = "warehouse";

  List<FormUI> formFieldDetails = [];
  List<Widget> widgetList = [];

  NetworkService networkService = NetworkService();
  GenerateFormService formService = GenerateFormService();

  void initWidget() async {
    GlobalVariables.requestBody[featureName] = {};
    formFieldDetails.clear();
    widgetList.clear();
    String jsonData =
        '[{"id": "whcode","name": "Warehouse Code","isMandatory": true,"inputType": "text","maxCharacter": 5},{"id": "whName","name": "Wharehouse Name","isMandatory": true,"inputType": "text","maxCharacter": 50},{"id": "whAdd","name": "Address","isMandatory": true,"inputType": "text","maxCharacter": 100},{"id": "whAdd1","name": "Address 1","isMandatory": true,"inputType": "text","maxCharacter": 100},{"id": "whCity","name": "City","isMandatory": true,"inputType": "text","maxCharacter": 50},{"id": "whState","name": "State","isMandatory": true,"inputType": "dropdown","dropdownMenuItem": "/get-states/"},{"id": "whZipCode","name": "Zipcode","isMandatory": true,"inputType": "text","maxCharacter": 6},{"id": "whCountry","name": "Country","isMandatory": true,"inputType": "dropdown","dropdownMenuItem": "/get-countries/"},{"id": "whContactPerson","name": "Contact Person","isMandatory": true,"inputType": "text","maxCharacter": 50},{"id": "whPhone","name": "Phone No.","isMandatory": true,"inputType": "number","maxCharacter": 10}]';

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
        await formService.generateDynamicForm(formFieldDetails, featureName);
    widgetList.addAll(widgets);
    notifyListeners();
  }

  Future<http.StreamedResponse> processFormInfo() async {
    http.StreamedResponse response = await networkService
        .post("/add-warehouse/", [GlobalVariables.requestBody[featureName]]);
    return response;
  }
}
