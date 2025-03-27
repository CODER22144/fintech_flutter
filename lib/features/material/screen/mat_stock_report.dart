import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/widgets/comman_appbar.dart';
import '../provider/material_provider.dart';

class MatStockReport extends StatefulWidget {
  static const String routeName = "MatStockReport";

  const MatStockReport({super.key});

  @override
  State<MatStockReport> createState() => _MatStockReportState();
}

class _MatStockReportState extends State<MatStockReport> {
  @override
  void initState() {
    super.initState();
    MaterialProvider provider =
    Provider.of<MaterialProvider>(context, listen: false);
    provider.getMaterialStockReport();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MaterialProvider>(builder: (context, provider, child) {
      return Material(
        child: SafeArea(
            child: Scaffold(
              appBar: PreferredSize(
                  preferredSize:
                  Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
                  child: const CommonAppbar(title: 'Material Stock Report')),
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Visibility(
                      visible: provider.materialStockReport.isNotEmpty,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text("Material No.")),
                          DataColumn(label: Text("Opening")),
                          DataColumn(label: Text("Received")),
                          DataColumn(label: Text("Released")),
                          DataColumn(label: Text("Qty In Stock")),
                        ],
                        rows: provider.rows,
                      ),
                    ),
                  ),
                ),
              ),
            )),
      );
    });
  }
}
