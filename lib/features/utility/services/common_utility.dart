import 'package:flutter/cupertino.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';

double parseEmptyStringToDouble(String value) {
  if (value != null && value != "") {
    return double.tryParse(value) ?? 0;
  }
  return 0;
}

String parseDoubleUpto2Decimal(String value) {
  if (value != null && value != "") {
    return (double.tryParse(value) ?? 0).toStringAsFixed(2);
  }
  return '0';
}

bool checkForEmptyOrNullString(String? value) {
  if (value != null && value != "" && value != "null") {
    return true;
  }
  return false;
}

SearchableDropdownMenuItem<String> findDropdownMenuItem(
    List<SearchableDropdownMenuItem<String>> dropdown, String searchText) {
  var data = dropdown.firstWhere((item) => item.value == searchText,
      orElse: () => const SearchableDropdownMenuItem(
          value: "", label: "", child: Text("")));
  return data;
}
