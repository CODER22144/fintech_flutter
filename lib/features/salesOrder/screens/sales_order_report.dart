import 'package:fintech_new_web/features/salesOrder/provider/sales_order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/widgets/comman_appbar.dart';
import '../../network/service/network_service.dart';

class SalesOrderReport extends StatefulWidget {
  static String routeName = "salesOrderReport";

  const SalesOrderReport({super.key});

  @override
  State<SalesOrderReport> createState() => _SalesOrderReportState();
}

class _SalesOrderReportState extends State<SalesOrderReport> {

  @override
  void initState() {
    super.initState();
    SalesOrderProvider provider =
    Provider.of<SalesOrderProvider>(context, listen: false);
    provider.getSalesOrderReport();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<SalesOrderProvider>(builder: (context, provider, child) {
      return Material(
        child: SafeArea(
            child: Scaffold(
              appBar: PreferredSize(
                  preferredSize:
                  Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
                  child: const CommonAppbar(title: 'Sales Order Report')),
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text("Order Id")),
                        DataColumn(label: Text("Order Date")),
                        DataColumn(label: Text("Business Partner")),
                        DataColumn(label: Text("Partner Address")),
                        DataColumn(label: Text("Amount")),
                        DataColumn(label: Text("GST Amount")),
                        DataColumn(label: Text("Total Amount")),
                      ],
                      rows: provider.orderReport.map((data) {
                        return DataRow(cells: [
                          DataCell(InkWell(onTap: () async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            var cid = prefs.getString("currentLoginCid");
                            final Uri uri = Uri.parse("${NetworkService.baseUrl}/get-sales-order-pdf/${data['orderId']}/$cid/");
                            if (await canLaunchUrl(uri)) {
                            await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
                            } else {
                            throw 'Could not launch';
                            }
                          },child: Text('${data['orderId'] ?? "-"}', style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.w500)))),
                          DataCell(Text('${data['orderDate'] ?? "-"}')),
                          DataCell(Text('${data['custName'] ?? "-"}')),
                          DataCell(Text('${data['custCity'] ?? "-"}, ${data['custStateName'] ?? "-"}')),
                          DataCell(Text('${data['sumamount'] ?? "0"}')),
                          DataCell(Text('${data['sumgstamount'] ?? "0"}')),
                          DataCell(Text('${data['sumtamount'] ?? "0"}')),
                        ]);
                      }).toList(),
                    ),
                  ),
                ),
              ),
            )),
      );
    });
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to proceed?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false); // Return false
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop(true); // Return true
              },
            ),
          ],
        );
      },
    ) ??
        false; // Return false if dialog is dismissed by other means
  }
}
