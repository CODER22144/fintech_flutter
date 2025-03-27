// ignore_for_file: use_build_context_synchronously
import 'dart:convert';

import 'package:fintech_new_web/features/common/widgets/pop_ups.dart';
import 'package:fintech_new_web/features/costResource/provider/cost_resource_provider.dart';
import 'package:fintech_new_web/features/costResource/screens/get_cost_resource.dart';
import 'package:fintech_new_web/features/utility/global_variables.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../common/widgets/comman_appbar.dart';

class AddCostResource extends StatefulWidget {
  static String routeName = "/AddCostResource";
  final String? editing;

  const AddCostResource({super.key, this.editing});

  @override
  State<AddCostResource> createState() => _AddWorkProcessState();
}

class _AddWorkProcessState extends State<AddCostResource> {
  late CostResourceProvider provider;
  @override
  void initState() {
    super.initState();
    provider =
        Provider.of<CostResourceProvider>(context, listen: false);
    if (widget.editing == "true") {
      provider.reset();
      provider.initEditWidget();
    } else {
      provider.initWidget();
    }
  }

  @override
  void dispose() {
    super.dispose();
    if(widget.editing == 'true') {
      provider.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return Consumer<CostResourceProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: PreferredSize(
            preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
            child: CommonAppbar(title: widget.editing == 'true' ? 'Update Resource' : "Add Resource")),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              width: kIsWeb
                  ? GlobalVariables.deviceWidth / 2.0
                  : GlobalVariables.deviceWidth,
              padding: const EdgeInsets.all(10),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: ListView.builder(
                        itemCount: provider.widgetList.length,
                        physics: const ClampingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return provider.widgetList[index];
                        },
                      ),
                    ),
                    Visibility(
                      visible: provider.widgetList.isNotEmpty,
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: HexColor("#0B6EFE"),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(5)))),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              http.StreamedResponse result =
                              widget.editing == "true"
                                  ? await provider.processUpdateFormInfo()
                                  : await provider.processFormInfo();
                              var message = jsonDecode(
                                  await result.stream.bytesToString());
                              if (result.statusCode == 200) {
                                if (widget.editing == "true") {
                                  context.pop();
                                  context.pushReplacementNamed(GetCostResource.routeName);
                                } else {
                                  context.pushReplacementNamed(AddCostResource.routeName);
                                }
                              } else if (result.statusCode == 400) {
                                await showAlertDialog(
                                    context,
                                    message['message'].toString(),
                                    "Continue",
                                    false);
                              } else if (result.statusCode == 500) {
                                await showAlertDialog(context,
                                    message['message'], "Continue", false);
                              } else {
                                await showAlertDialog(context,
                                    message['message'], "Continue", false);
                              }
                            }
                          },
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

}
