import 'package:fintech_new_web/features/inward/provider/inward_provider.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/widgets/comman_appbar.dart';
import '../../utility/global_variables.dart';

class InwardReport extends StatefulWidget {
  static String routeName = "InwardReport";

  const InwardReport({super.key});

  @override
  State<InwardReport> createState() => _InwardReportState();
}

class _InwardReportState extends State<InwardReport> {
  @override
  void initState() {
    super.initState();
    InwardProvider provider =
    Provider.of<InwardProvider>(context, listen: false);
    provider.getInwardBillReportTable(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InwardProvider>(builder: (context, provider, child) {
      return Material(
        child: SafeArea(
            child: Scaffold(
              appBar: PreferredSize(
                  preferredSize:
                  Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
                  child: const CommonAppbar(title: 'Inward Bill Report')),
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: provider.table,
                  ),
                ),
              ),
            )),
      );
    });
  }
}
