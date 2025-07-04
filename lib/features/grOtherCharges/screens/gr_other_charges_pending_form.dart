// ignore_for_file: use_build_context_synchronously
import 'package:fintech_new_web/features/common/widgets/pop_ups.dart';
import 'package:fintech_new_web/features/gr/screen/gr_report_screen.dart';
import 'package:fintech_new_web/features/grOtherCharges/provider/gr_other_charges_provider.dart';
import 'package:fintech_new_web/features/purchaseOrder/provider/purchase_order_provider.dart';
import 'package:fintech_new_web/features/purchaseOrder/screen/purchase_order_report_screen.dart';
import 'package:fintech_new_web/features/utility/global_variables.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../common/widgets/comman_appbar.dart';
import 'gr_other_charges_pending.dart';

class GrOtherChargesPendingForm extends StatefulWidget {
  static String routeName = "GrOtherChargesPendingForm";
  const GrOtherChargesPendingForm({super.key});

  @override
  State<GrOtherChargesPendingForm> createState() => _GrOtherChargesPendingFormState();
}

class _GrOtherChargesPendingFormState extends State<GrOtherChargesPendingForm> {
  @override
  void initState() {
    super.initState();
    GrOtherChargesProvider provider =
    Provider.of<GrOtherChargesProvider>(context, listen: false);
    provider.initPendingWidget();
  }

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return Consumer<GrOtherChargesProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: PreferredSize(
                preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
                child: const CommonAppbar(title: 'GR Other Charges Pending')),
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
                                  context.pushNamed(GrOtherChargesPending.routeName);
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
