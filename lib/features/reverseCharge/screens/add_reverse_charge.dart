// ignore_for_file: use_build_context_synchronously
import 'dart:convert';

import 'package:fintech_new_web/features/businessPartner/provider/business_partner_provider.dart';
import 'package:fintech_new_web/features/common/widgets/pop_ups.dart';
import 'package:fintech_new_web/features/home.dart';
import 'package:fintech_new_web/features/reqPacking/provider/req_packing_provider.dart';
import 'package:fintech_new_web/features/reqProduction/provider/req_production_provider.dart';
import 'package:fintech_new_web/features/resources/provider/resource_provider.dart';
import 'package:fintech_new_web/features/resources/screens/get_resources.dart';
import 'package:fintech_new_web/features/reverseCharge/provider/reverse_charge_provider.dart';
import 'package:fintech_new_web/features/utility/global_variables.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../camera/widgets/camera_widget.dart';
import '../../common/widgets/comman_appbar.dart';

class AddReverseCharge extends StatefulWidget {
  static String routeName = "/AddReverseCharge";
  const AddReverseCharge({super.key});

  @override
  State<AddReverseCharge> createState() => _AddReverseChargeState();
}

class _AddReverseChargeState extends State<AddReverseCharge> {
  late ReverseChargeProvider provider;

  @override
  void initState() {
    super.initState();
    provider =
        Provider.of<ReverseChargeProvider>(context, listen: false);
    provider.initWidget();
  }

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return Consumer<ReverseChargeProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: PreferredSize(
                preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
                child: const CommonAppbar(title: 'Add Reverse Charge')),
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.white54)),
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, right: 20, left: 20),
                  width: kIsWeb
                      ? GlobalVariables.deviceWidth / 2.0
                      : GlobalVariables.deviceWidth,
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
                                  bool confirmation =
                                  await showConfirmationDialogue(
                                      context,
                                      "Do you want to submit the records?",
                                      "SUBMIT",
                                      "CANCEL");
                                  if (confirmation) {
                                    http.StreamedResponse result = await provider.processFormInfo();
                                    var message = jsonDecode(
                                        await result.stream.bytesToString());
                                    if (result.statusCode == 200) {
                                      context.pushReplacementNamed(AddReverseCharge.routeName);
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
