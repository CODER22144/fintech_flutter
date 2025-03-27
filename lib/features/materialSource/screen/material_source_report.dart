import 'package:fintech_new_web/features/materialSource/provider/material_source_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/widgets/comman_appbar.dart';

class MaterialSourceReport extends StatefulWidget {
  static String routeName = "MaterialSourceReport";

  const MaterialSourceReport({super.key});

  @override
  State<MaterialSourceReport> createState() =>
      _PurchaseOrderReportScreenState();
}

class _PurchaseOrderReportScreenState extends State<MaterialSourceReport> {
  @override
  void initState() {
    super.initState();
    MaterialSourceProvider provider =
    Provider.of<MaterialSourceProvider>(context, listen: false);
    provider.nestedTable();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MaterialSourceProvider>(builder: (context, provider, child) {
      return Material(
        child: SafeArea(
            child: Scaffold(
              appBar: PreferredSize(
                  preferredSize:
                  Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
                  child: const CommonAppbar(title: 'Material Source Report')),
              body: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal, child:provider.table),
                ),
              ),
            )),
      );
    });
  }
}
