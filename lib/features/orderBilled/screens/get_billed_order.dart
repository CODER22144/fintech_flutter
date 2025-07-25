import 'package:fintech_new_web/features/materialIQS/screens/create_material_iqs.dart';
import 'package:fintech_new_web/features/obalance/provider/oblance_provider.dart';
import 'package:fintech_new_web/features/orderBilled/provider/order_billed_provider.dart';
import 'package:fintech_new_web/features/orderBilled/screens/edit_order_billed.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../../common/widgets/comman_appbar.dart';
import '../../utility/global_variables.dart';

class GetBilledOrder extends StatefulWidget {
  static String routeName = 'GetBilledOrder';
  const GetBilledOrder({super.key});

  @override
  State<GetBilledOrder> createState() => _GetBilledOrderState();
}

class _GetBilledOrderState extends State<GetBilledOrder> {

  @override
  void initState() {
    super.initState();
    OrderBilledProvider provider = Provider.of<OrderBilledProvider>(context, listen: false);
    provider.editController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderBilledProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: PreferredSize(
            preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
            child: const CommonAppbar(title: 'Edit Order Billed')),
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
                              text: "Order Id",
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
                          context.pushNamed(EditOrderBilled.routeName);
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
