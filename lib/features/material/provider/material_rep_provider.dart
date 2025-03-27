import 'dart:convert';

import 'package:fintech_new_web/features/utility/global_variables.dart';
import 'package:fintech_new_web/features/utility/models/forms_UI.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../network/service/network_service.dart';
import '../../utility/services/generate_form_service.dart';

class MaterialRepProvider with ChangeNotifier {
  static const String featureName = "materialRep";

  List<FormUI> formFieldDetails = [];
  List<Widget> widgetList = [];
  List<dynamic> materialRepResponse = [];

  NetworkService networkService = NetworkService();
  GenerateFormService formService = GenerateFormService();

  void initWidget() async {
    GlobalVariables.requestBody[featureName] = {};
    formFieldDetails.clear();
    widgetList.clear();
    String jsonData =
        '[{"id": "materialType","name": "Material Type","isMandatory": true,"inputType": "dropdown","dropdownMenuItem": "/get-material-type/"},{"id": "materialGroup","name": "Material Group","isMandatory": false,"inputType": "dropdown","dropdownMenuItem": "/get-material-group/"},{"id": "gstTaxRate","name": "GST Tax Rate","isMandatory": false,"inputType": "number"},{"id": "hsnCode","name": "HSN","isMandatory": false,"inputType": "text","maxCharacter": 10},{"id": "mst","name": "Material Status","isMandatory": false,"inputType": "dropdown","dropdownMenuItem": "/get-material-status/"},{"id": "fmatno","name": "From Material No.","isMandatory": false,"inputType": "text","maxCharacter": 15},{"id": "tmatno","name": "To Material No.","isMandatory": false,"inputType": "text","maxCharacter": 15},{"id": "fdoentry","name": "From Emtry Date","isMandatory": false,"inputType": "datetime"},{"id": "tdoentry","name": "To Entry Date","isMandatory": false,"inputType": "datetime"}]';

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
    http.StreamedResponse response = await networkService.post(
        "/get-material-rep/", GlobalVariables.requestBody[featureName]);
    return response;
  }

  void setResponse(dynamic response) {
    materialRepResponse = response;
    notifyListeners();
  }
}
