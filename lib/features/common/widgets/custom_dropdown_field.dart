import 'package:flutter/material.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';

import '../../utility/global_variables.dart';
import '../../utility/models/forms_UI.dart';

class CustomDropdownField extends StatefulWidget {
  final FormUI field;
  final List<SearchableDropdownMenuItem<String>> dropdownMenuItems;
  final String feature;
  final Function? customFunction;
  const CustomDropdownField(
      {super.key,
      required this.field,
      required this.dropdownMenuItems,
      required this.feature,
      this.customFunction});

  @override
  State<CustomDropdownField> createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  bool visible = false;
  late SearchableDropdownController<String> controller;

  @override
  void initState() {
    super.initState();
    GlobalVariables.requestBody[widget.feature][widget.field.id] =
        (widget.field.defaultValue == "null" || widget.field.defaultValue == '')
            ? null
            : widget.field.defaultValue;
    var defaultItem = SearchableDropdownMenuItem(
        value: "${widget.field.defaultValue ?? ''}",
        label: "${widget.field.defaultValue ?? ''}",
        child: Text("${widget.field.defaultValue ?? ''}"));
    var searchItem = widget.dropdownMenuItems.firstWhere(
        (item) => item.value == widget.field.defaultValue.toString(),
        orElse: () => defaultItem);
    controller = SearchableDropdownController<String>(initialItem: searchItem);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            key: const Key('outletMappingDropdownKey'),
            color: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: SearchableDropdown<String>(
              trailingIcon: const SizedBox(),
              isEnabled: !widget.field.readOnly,
              controller: (widget.field.controller is SearchableDropdownController) ? widget.field.controller : controller,
              backgroundDecoration: (child) => Container(
                height: 48,
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black, width: 0.5),
                ),
                child: child,
              ),
              items: widget.dropdownMenuItems,
              onChanged: (String? value) {
                GlobalVariables.requestBody[widget.feature][widget.field.id] =
                    value;

                setState(() {
                  visible = true;
                });

                if (widget.customFunction != null) {
                  widget.customFunction!();
                }
              },
              hasTrailingClearIcon: false,
            )),
        Positioned(
          left: 10,
          top: 3,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Wrap(
              children: [
                Text(
                  widget.field.name,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                widget.field.isMandatory == true
                    ? const Text(
                        "*",
                        style: TextStyle(color: Colors.red),
                      )
                    : const Text(""),
              ],
            ),
          ),
        ),
        Visibility(
          visible: visible,
          child: Positioned(
              left: GlobalVariables.deviceWidth / 2.21,
              top: 10,
              child: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  // Clear the text field and trigger onChanged
                  setState(() {
                    controller.selectedItem.value = null;
                    GlobalVariables.requestBody[widget.feature]
                        [widget.field.id] = null;
                    visible = false;
                  });
                },
              )),
        )
      ],
    );
  }
}
