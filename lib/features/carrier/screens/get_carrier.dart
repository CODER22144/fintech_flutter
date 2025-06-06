import 'package:fintech_new_web/features/billReceipt/screen/create_bill_receipt.dart';
import 'package:fintech_new_web/features/bpShipping/provider/bp_shipping_provider.dart';
import 'package:fintech_new_web/features/bpShipping/screens/bp_shipping.dart';
import 'package:fintech_new_web/features/businessPartner/screen/business_partner.dart';
import 'package:fintech_new_web/features/carrier/provider/carrier_provider.dart';
import 'package:fintech_new_web/features/carrier/screens/carrier.dart';
import 'package:fintech_new_web/features/resources/provider/resource_provider.dart';
import 'package:fintech_new_web/features/resources/screens/resources.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../../common/widgets/comman_appbar.dart';
import '../../utility/global_variables.dart';

class GetCarrier extends StatefulWidget {
  static String routeName = 'edit-carrier';
  const GetCarrier({super.key});

  @override
  State<GetCarrier> createState() => _GetCarrierState();
}

class _GetCarrierState extends State<GetCarrier> {

  @override
  void initState() {
    super.initState();
    CarrierProvider provider =
        Provider.of<CarrierProvider>(context, listen: false);
    provider.editController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CarrierProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: PreferredSize(
                preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
                child: const CommonAppbar(title: 'Get Carrier')),
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  width: kIsWeb
                      ? GlobalVariables.deviceWidth / 2.0
                      : GlobalVariables.deviceWidth,
                  padding: const EdgeInsets.all(10),
                  child: Form(
                    // key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: TextFormField(
                            style:
                            const TextStyle(color: Colors.black, fontSize: 14),
                            readOnly: false,
                            controller: provider.editController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.grey, width: 2),
                              ),
                              label: RichText(
                                text: const TextSpan(
                                  text: "Carrier ID",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  children: [
                                    TextSpan(
                                        text: "*",
                                        style: TextStyle(color: Colors.red))
                                  ],
                                ),
                              ),
                            ),
                            validator: (String? val) {
                              if ((val == null || val.isEmpty)) {
                                return 'This field is Mandatory';
                              }
                            },
                            maxLines: 1,
                            onChanged: (value) {
                              // GlobalVariables.requestBody[widget.feature][widget.field.id] = value;
                            },
                            inputFormatters: <TextInputFormatter>[
                              // FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9#\$&*!₹%.@_ ]')),
                              LengthLimitingTextInputFormatter(10)
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: HexColor("#0B6EFE"),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5)))),
                            onPressed: () async {
                              context.pushNamed(Carrier.routeName,
                                  queryParameters: {"editing": 'true'});
                            },
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
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
