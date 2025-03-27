import 'package:fintech_new_web/features/JVoucher/screens/add_journal_voucher.dart';
import 'package:fintech_new_web/features/JVoucher/screens/journal_voucher_report_form.dart';
import 'package:fintech_new_web/features/additionalOrder/screen/additional_order.dart';
import 'package:fintech_new_web/features/additionalOrder/screen/additional_purchase_order_report_form.dart';
import 'package:fintech_new_web/features/attendence/screen/get_attendance_report.dart';
import 'package:fintech_new_web/features/auth/provider/auth_provider.dart';
import 'package:fintech_new_web/features/auth/screen/login.dart';
import 'package:fintech_new_web/features/bankUpload/screens/bank_report_form.dart';
import 'package:fintech_new_web/features/bankUpload/screens/bank_upload.dart';
import 'package:fintech_new_web/features/billPayable/screen/add_bill_payable.dart';
import 'package:fintech_new_web/features/billReceipt/screen/br_filter_form.dart';
import 'package:fintech_new_web/features/billReceipt/screen/create_bill_receipt.dart';
import 'package:fintech_new_web/features/billReceivable/screens/add_bill_receivable.dart';
import 'package:fintech_new_web/features/bpShipping/screens/bp_shipping.dart';
import 'package:fintech_new_web/features/bpShipping/screens/get_bp_shipping.dart';
import 'package:fintech_new_web/features/bpShipping/screens/shipping_report_form.dart';
import 'package:fintech_new_web/features/businessPartner/screen/bp_report_form.dart';
import 'package:fintech_new_web/features/businessPartner/screen/business_partner_tabs.dart';
import 'package:fintech_new_web/features/carrier/screens/carrier.dart';
import 'package:fintech_new_web/features/carrier/screens/carrier_report.dart';
import 'package:fintech_new_web/features/carrier/screens/get_carrier.dart';
import 'package:fintech_new_web/features/common/widgets/pop_ups.dart';
import 'package:fintech_new_web/features/company/screens/add_company_form.dart';
import 'package:fintech_new_web/features/costResource/screens/add_cost_resource.dart';
import 'package:fintech_new_web/features/costResource/screens/cost_resource_report.dart';
import 'package:fintech_new_web/features/costResource/screens/get_cost_resource.dart';
import 'package:fintech_new_web/features/crNote/screens/cr_note_details.dart';
import 'package:fintech_new_web/features/crNote/screens/cr_note_report_form.dart';
import 'package:fintech_new_web/features/dbNote/screens/db_note_details.dart';
import 'package:fintech_new_web/features/debitNoteAgainstCreditNote/screens/add_db_note_against_cr_note.dart';
import 'package:fintech_new_web/features/debitNoteDispatch/screens/add_debit_note_dispatch.dart';
import 'package:fintech_new_web/features/dlChallan/screens/add_dl_challan.dart';
import 'package:fintech_new_web/features/dlChallan/screens/dl_challan_report_form.dart';
import 'package:fintech_new_web/features/evOrder/screen/ev_order.dart';
import 'package:fintech_new_web/features/financialCreditNote/screens/create_financial_crnote.dart';
import 'package:fintech_new_web/features/gr/screen/gr_rate_approval_pending.dart';
import 'package:fintech_new_web/features/gr/screen/gr_rejection_pending.dart';
import 'package:fintech_new_web/features/gr/screen/gr_report_form.dart';
import 'package:fintech_new_web/features/gr/screen/gr_shortage_pending.dart';
import 'package:fintech_new_web/features/grIqsRep/screens/gr_iqs_pending.dart';
import 'package:fintech_new_web/features/grOtherCharges/screens/add_gr_charges.dart';
import 'package:fintech_new_web/features/grQtyClear/screens/gr_qty_clear_pending.dart';
import 'package:fintech_new_web/features/hsn/screens/add_hsn.dart';
import 'package:fintech_new_web/features/hsn/screens/get_hsn.dart';
import 'package:fintech_new_web/features/hsn/screens/hsn_report.dart';
import 'package:fintech_new_web/features/invenReq/screens/add_req_details.dart';
import 'package:fintech_new_web/features/inward/screens/inward_report_form.dart';
import 'package:fintech_new_web/features/inwardVoucher/screens/create_inward_voucher.dart';
import 'package:fintech_new_web/features/jobWorkOut/screens/add_job_work_out.dart';
import 'package:fintech_new_web/features/jobWorkOut/screens/add_job_work_out_details.dart';
import 'package:fintech_new_web/features/jobWorkOut/screens/job_workout_report_form.dart';
import 'package:fintech_new_web/features/jobWorkOutChallanClear/screens/add_job_work_out_challan_clear.dart';
import 'package:fintech_new_web/features/ledgerCodes/screen/get_ledger_codes.dart';
import 'package:fintech_new_web/features/ledgerCodes/screen/ledger_code_report_form.dart';
import 'package:fintech_new_web/features/manufacturing/screens/add_manufacturing.dart';
import 'package:fintech_new_web/features/manufacturing/screens/manufacturing_report_form.dart';
import 'package:fintech_new_web/features/material/screen/get_material.dart';
import 'package:fintech_new_web/features/material/screen/mat_stock_report.dart';
import 'package:fintech_new_web/features/material/screen/mat_stock_report_form.dart';
import 'package:fintech_new_web/features/material/screen/material_group_report.dart';
import 'package:fintech_new_web/features/material/screen/material_report_form.dart';
import 'package:fintech_new_web/features/material/screen/material_type_report.dart';
import 'package:fintech_new_web/features/material/screen/material_unit_report.dart';
import 'package:fintech_new_web/features/materialIQS/screens/create_material_iqs.dart';
import 'package:fintech_new_web/features/materialIncomingStandard/screens/add_material_incoming_standard.dart';
import 'package:fintech_new_web/features/materialIncomingStandard/screens/material_incoming_standard_report.dart';
import 'package:fintech_new_web/features/materialReturn/screens/add_material_return.dart';
import 'package:fintech_new_web/features/materialSource/screen/get_material_source.dart';
import 'package:fintech_new_web/features/materialSource/screen/material_source_report_form.dart';
import 'package:fintech_new_web/features/network/service/network_service.dart';
import 'package:fintech_new_web/features/obalance/screens/create-obalance.dart';
import 'package:fintech_new_web/features/orderApproval/screens/hold_denied_order_report.dart';
import 'package:fintech_new_web/features/orderCancel/screens/add_order_cancel.dart';
import 'package:fintech_new_web/features/orderGoodsDispatch/screens/get_order_goods_dispatch_pending.dart';
import 'package:fintech_new_web/features/orderPackaging/screens/order_packaging_pending.dart';
import 'package:fintech_new_web/features/orderTransport/screens/get_order_transport_pending.dart';
import 'package:fintech_new_web/features/partAssembly/screens/part_assembly_by_matno.dart';
import 'package:fintech_new_web/features/paymentClear/screens/payment_advance_pending.dart';
import 'package:fintech_new_web/features/paymentClear/screens/unadjusted_payment_pending.dart';
import 'package:fintech_new_web/features/paymentInward/screens/add_payment_inward.dart';
import 'package:fintech_new_web/features/paymentInward/screens/unadjusted_payment_inward.dart';
import 'package:fintech_new_web/features/paymentVoucher/screens/create_payment_voucher.dart';
import 'package:fintech_new_web/features/payment/screens/bill_pending_report_form.dart';
import 'package:fintech_new_web/features/prTaxInvoice/screens/pr_tax_invoice_details.dart';
import 'package:fintech_new_web/features/prTaxInvoice/screens/pr_tax_invoice_report_form.dart';
import 'package:fintech_new_web/features/productBreakupTechDetails/screens/add_product_breakup_tech_details.dart';
import 'package:fintech_new_web/features/productFinalStandard/screens/add_product_final_standard.dart';
import 'package:fintech_new_web/features/productionPlan/screens/add_production_plan.dart';
import 'package:fintech_new_web/features/productionPlan/screens/delete_production_plan.dart';
import 'package:fintech_new_web/features/productionPlanA/screen/add_production_planA.dart';
import 'package:fintech_new_web/features/receiptVoucher/screens/create_receipt_voucher.dart';
import 'package:fintech_new_web/features/reqIssue/screens/req_issue_pending.dart';
import 'package:fintech_new_web/features/reqPacked/screens/req_packed_pending.dart';
import 'package:fintech_new_web/features/reqPacking/screens/req_packing_pending.dart';
import 'package:fintech_new_web/features/reqProduction/screens/req_production_pending.dart';
import 'package:fintech_new_web/features/resources/screens/resource_report.dart';
import 'package:fintech_new_web/features/resources/screens/resources.dart';
import 'package:fintech_new_web/features/saleTransfer/screens/payment_pending_report_form.dart';
import 'package:fintech_new_web/features/saleTransfer/screens/sale_payment_pending_report_form.dart';
import 'package:fintech_new_web/features/salesDebitNote/screens/sale_debit_note_report_form.dart';
import 'package:fintech_new_web/features/salesOrder/screens/export_eway_bill_sale.dart';
import 'package:fintech_new_web/features/salesOrder/screens/order_report.dart';
import 'package:fintech_new_web/features/salesOrder/screens/sales_order.dart';
import 'package:fintech_new_web/features/salesOrder/screens/sales_order_report_form.dart';
import 'package:fintech_new_web/features/salesOrder/screens/sales_report_form.dart';
import 'package:fintech_new_web/features/taClaim/screens/add_ta_claim.dart';
import 'package:fintech_new_web/features/taClaim/screens/get_claim_report.dart';
import 'package:fintech_new_web/features/utility/global_variables.dart';
import 'package:fintech_new_web/features/visitInfo/screens/add_visit_info.dart';
import 'package:fintech_new_web/features/visitInfo/screens/get_visit_info_report.dart';
import 'package:fintech_new_web/features/warehouse/screen/warehouse.dart';
import 'package:fintech_new_web/features/wireSize/screens/wire_size_by_matno.dart';
import 'package:fintech_new_web/features/workProcess/screens/add_work_process.dart';
import 'package:fintech_new_web/features/workProcess/screens/get_work_process.dart';
import 'package:fintech_new_web/features/workProcess/screens/work_process_report.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../../attendence/attendence.dart';
import '../../businessPartner/screen/get-business-partner.dart';
import '../../dbNote/screens/db_note_report_form.dart';
import '../../gr/screen/gr_rate_difference_pending.dart';
import '../../gr/screen/pending_gr_report.dart';
import '../../hsn/screens/ac_groups_report.dart';
import '../../invenReq/screens/add_req.dart';
import '../../ledgerCodes/screen/ledger_codes.dart';
import '../../lineRejection/screens/add_line_rejection.dart';
import '../../material/screen/material_screen.dart';
import '../../materialSource/screen/material_source.dart';
import '../../orderApRequest/screens/get_pending_ap_request.dart';
import '../../orderApproval/screens/get_order_approval_pending.dart';
import '../../orderBilled/screens/get_order_billed_pending.dart';
import '../../partSubAssembly/screens/part_sub_assembly_by_matno.dart';
import '../../prTaxInvoiceDispatch/screens/add_pr_tax_invoice_dispatch.dart';
import '../../productBreakup/screens/product_breakup_by_matno.dart';
import '../../purchaseOrder/screen/purchase_order.dart';
import '../../purchaseOrder/screen/purchase_order_report_form.dart';
import '../../purchaseTransfer/screens/purchase_bill_pending_report_form.dart';
import '../../resources/screens/get_resources.dart';
import '../../salesDebitNote/screens/sales_debit_note_details.dart';

class SidebarNavigationMenu extends StatefulWidget {
  const SidebarNavigationMenu({super.key});

  @override
  State<SidebarNavigationMenu> createState() => _SidebarNavigationMenuState();
}

class _SidebarNavigationMenuState extends State<SidebarNavigationMenu> {
  @override
  void initState() {
    AuthProvider provider = Provider.of<AuthProvider>(context, listen: false);
    provider.initUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, child) {
      return Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                  "${provider.userInfo['first_name'] ?? ""} ${provider.userInfo['last_name'] ?? ""} | ${provider.userInfo['company_name'] ?? ""}"),
              accountEmail: Text("${provider.userInfo['email'] ?? ""}"),
              currentAccountPicture: SizedBox(
                child: provider.userInfo['logo'] != ""
                    ? Image.network(
                        'http://mapp.rcinz.com${provider.userInfo['logo']}')
                    : CircleAvatar(
                        child: ClipOval(
                          child: Image.asset("assets/avatar.jpeg",
                              width: 200, height: 200),
                        ),
                      ),
              ),
              decoration: const BoxDecoration(color: Colors.lightBlueAccent),
            ),

            // PURCHASE
            ExpansionTile(
              leading: const Icon(Icons.bookmark_border_outlined),
              title: const Text("Purchase"),
              children: [
                ListTile(
                  title: const Text("Purchase Order"),
                  onTap: () {
                    context.pushNamed(PurchaseOrderScreen.routeName);
                  },
                ),
                ExpansionTile(
                    leading: const Icon(Icons.add_shopping_cart_outlined),
                    title: const Text("Additional Purchase Order"),
                    children: [
                      ListTile(
                        title: const Text("Create Order"),
                        onTap: () {
                          context.pushNamed(AdditionalOrder.routeName);
                        },
                      ),
                      ListTile(
                        title: const Text("Report"),
                        onTap: () {
                          context.pushNamed(AdditionalPurchaseOrderReportForm.routeName);
                        },
                      ),
                    ]),
                ListTile(
                  leading: const Icon(Icons.add_shopping_cart_outlined),
                  title: const Text("Extend Validity"),
                  onTap: () {
                    context.pushNamed(EvOrder.routeName);
                  },
                ),
                ListTile(
                  title: const Text("Purchase Order Report"),
                  onTap: () {
                    context.pushNamed(PurchaseOrderReportForm.routeName);
                  },
                ),
                ExpansionTile(
                  leading: const Icon(Icons.bookmark_border_outlined),
                  title: const Text("GR"),
                  children: [
                    ListTile(
                      title: const Text("Pending"),
                      onTap: () {
                        context.pushNamed(PendingGrReport.routeName);
                      },
                    ),
                    ListTile(
                      title: const Text("Report"),
                      onTap: () {
                        context.pushNamed(GrReportForm.routeName);
                      },
                    ),
                    ListTile(
                      title: const Text("Other Charges"),
                      onTap: () {
                        context.pushNamed(AddGrCharges.routeName);
                      },
                    ),
                    ListTile(
                      title: const Text("Quantity Pending"),
                      onTap: () {
                        context.pushNamed(GrQtyClearPending.routeName);
                      },
                    ),
                    ListTile(
                      title: const Text("GR Iqs Pending"),
                      onTap: () {
                        context.pushNamed(GrIqsPending.routeName);
                      },
                    ),
                    ListTile(
                      title: const Text("Rate Approval Pending"),
                      onTap: () {
                        context.pushNamed(GrRateApprovalPending.routeName);
                      },
                    ),
                    ListTile(
                      title: const Text("Rate Difference Pending"),
                      onTap: () {
                        context.pushNamed(GrRateDifferencePending.routeName);
                      },
                    ),
                    ListTile(
                      title: const Text("Shortage Pending"),
                      onTap: () {
                        context.pushNamed(GrShortagePending.routeName);
                      },
                    ),
                    ListTile(
                      title: const Text("Rejection Pending"),
                      onTap: () {
                        context.pushNamed(GrRejectionPending.routeName);
                      },
                    ),
                  ],
                ),
                ExpansionTile(
                  leading: const Icon(Icons.file_open_outlined),
                  title: const Text("Production Plan"),
                  children: [
                    ListTile(
                      title: const Text("Add"),
                      onTap: () {
                        context.pushNamed(AddProductionPlan.routeName);
                      },
                    ),
                    ListTile(
                      title: const Text("Delete"),
                      onTap: () {
                        context.pushNamed(DeleteProductionPlan.routeName);
                      },
                    ),
                  ],
                ),
                ExpansionTile(
                  leading: const Icon(Icons.file_open_outlined),
                  title: const Text("Additional Plan"),
                  children: [
                    ListTile(
                      title: const Text("Add"),
                      onTap: () {
                        context.pushNamed(AddProductionPlanA.routeName);
                      },
                    ),
                    // ListTile(
                    //   title: const Text("Delete"),
                    //   onTap: () {
                    //     context.pushNamed(DeleteProductionPlan.routeName);
                    //   },
                    // ),
                  ],
                ),
                ListTile(
                  leading: const Icon(Icons.file_open_outlined),
                  title: const Text("Line Rejection"),
                  onTap: () {
                    context.pushNamed(AddLineRejection.routeName);
                  },
                ),
                ExpansionTile(
                  title: const Text('JobWork Challan'),
                  children: [
                    ListTile(
                      title: const Text("Add Jobwork Manual"),
                      onTap: () {
                        context.pushNamed(AddJobWorkOutDetails.routeName);
                      },
                    ),
                    ListTile(
                      title: const Text("Add Jobwork Auto"),
                      onTap: () {
                        context.pushNamed(AddJobWorkOut.routeName);
                      },
                    ),
                    ListTile(
                      title: const Text("Report"),
                      onTap: () {
                        context.pushNamed(JobWorkoutReportForm.routeName);
                      },
                    ),
                  ],
                ),
                ExpansionTile(
                  leading: const Icon(Icons.file_open_outlined),
                  title: const Text("DL Challan"),
                  children: [
                    ListTile(
                      title: const Text("Create"),
                      onTap: () {
                        context.pushNamed(AddDlChallan.routeName);
                      },
                    ),
                    ListTile(
                      title: const Text("Report"),
                      onTap: () {
                        context.pushNamed(DlChallanReportForm.routeName);
                      },
                    )
                  ],
                ),
                ListTile(
                  leading: const Icon(Icons.file_open_outlined),
                  title: const Text("Material Return"),
                  onTap: () {
                    context.pushNamed(AddMaterialReturn.routeName);
                  },
                ),
              ],
            ),

            ExpansionTile(title: const Text("Master"), children: [
              ExpansionTile(
                leading: const Icon(Icons.person_add_alt_outlined),
                title: const Text("Business Partner"),
                children: [
                  ListTile(
                    title: const Text("Add"),
                    onTap: () {
                      context.pushNamed(BusinessPartnerTabs.routeName);
                    },
                  ),
                  ListTile(
                    title: const Text("Edit"),
                    onTap: () {
                      context.pushNamed(GetBusinessPartner.routeName);
                    },
                  ),
                  ListTile(
                    title: const Text("BP Discount Structure"),
                    onTap: () {
                      context.pushNamed(BpReportForm.routeName);
                    },
                  ),
                ],
              ),
              ListTile(
                title: const Text("Warehouse"),
                onTap: () {
                  context.pushNamed(Warehouse.routeName);
                },
              ),
              ExpansionTile(
                  leading: const Icon(Icons.file_present_outlined),
                  title: const Text("Ledger Codes"),
                  children: [
                    ListTile(
                      title: const Text("Create"),
                      onTap: () {
                        context.pushNamed(LedgerCodes.routeName);
                      },
                    ),
                    ListTile(
                      title: const Text("Edit"),
                      onTap: () {
                        context.pushNamed(GetLedgerCodes.routeName);
                      },
                    ),
                    ListTile(
                      title: const Text("Report"),
                      onTap: () {
                        context.pushNamed(LedgerCodeReportForm.routeName);
                      },
                    ),
                    ListTile(
                      title: const Text("Acc. Group Report"),
                      onTap: () {
                        context.pushNamed(AcGroupsReport.routeName);
                      },
                    )
                  ]),
              ExpansionTile(
                  title: const Text("HSN"),
                  leading: const Icon(Icons.currency_exchange_outlined),
                  children: [
                    ListTile(
                      title: const Text("Create"),
                      onTap: () {
                        context.pushNamed(AddHsn.routeName);
                      },
                    ),
                    ListTile(
                      title: const Text("Update"),
                      onTap: () {
                        context.pushNamed(GetHsn.routeName);
                      },
                    ),
                    ListTile(
                      title: const Text("Report"),
                      onTap: () {
                        context.pushNamed(HsnReport.routeName);
                      },
                    )
                  ]),
              ExpansionTile(
                leading: const Icon(Icons.shopping_bag_outlined),
                title: const Text("Material"),
                children: [
                  ListTile(
                    title: const Text("Add Material"),
                    onTap: () {
                      context.pushNamed(MaterialScreen.routeName);
                    },
                  ),
                  ListTile(
                    title: const Text("Edit Material"),
                    onTap: () {
                      context.pushNamed(GetMaterial.routeName);
                    },
                  ),
                  ListTile(
                    title: const Text("Material Report"),
                    onTap: () {
                      context.pushNamed(MaterialReportForm.routeName);
                    },
                  ),
                  ListTile(
                    title: const Text("Create Material IQS"),
                    onTap: () {
                      context.pushNamed(CreateMaterialIqs.routeName);
                    },
                  ),
                  ListTile(
                    title: const Text("Material Group Report"),
                    onTap: () {
                      context.pushNamed(MaterialGroupReport.routeName);
                    },
                  ),
                  ListTile(
                    title: const Text("Material Unit Report"),
                    onTap: () {
                      context.pushNamed(MaterialUnitReport.routeName);
                    },
                  ),
                  ListTile(
                    title: const Text("Material Type Report"),
                    onTap: () {
                      context.pushNamed(MaterialTypeReport.routeName);
                    },
                  ),
                  ListTile(
                    title: const Text("Material Stock Report"),
                    onTap: () {
                      context.pushNamed(MatStockReportForm.routeName);
                    },
                  ),
                ],
              ),
              ExpansionTile(title: const Text('Material Source'), children: [
                ListTile(
                  // leading: const Icon(Icons.shopping_cart_outlined),
                  title: const Text("Add"),
                  onTap: () {
                    context.pushNamed(MaterialSource.routeName);
                  },
                ),
                ListTile(
                  // leading: const Icon(Icons.shopping_cart_outlined),
                  title: const Text("Edit"),
                  onTap: () {
                    context.pushNamed(GetMaterialSource.routeName);
                  },
                ),
                ListTile(
                  // leading: const Icon(Icons.shopping_cart_outlined),
                  title: const Text("Report"),
                  onTap: () {
                    context.pushNamed(MaterialSourceReportForm.routeName);
                  },
                ),
              ],)
            ]),

            ExpansionTile(
              leading: const Icon(Icons.person_add_alt_outlined),
              title: const Text("Attendance"),
              children: [
                ListTile(
                  title: const Text("Check-In"),
                  onTap: () {
                    checkIn(context);
                  },
                ),
                ListTile(
                  title: const Text("Check-Out"),
                  onTap: () {
                    checkOut(context);
                  },
                ),
                ListTile(
                  title: const Text("Report"),
                  onTap: () {
                    context.pushNamed(GetAttendanceReport.routeName);
                  },
                )
              ],
            ),
            ListTile(
              leading: const Icon(Icons.add_business_outlined),
              title: const Text("Company"),
              onTap: () {
                context.pushNamed(AddCompanyForm.routeName);
              },
            ),

            ExpansionTile(
              leading: const Icon(Icons.bookmark_border_outlined),
              title: const Text("Bill Receipt"),
              children: [
                ListTile(
                    title: const Text("Create"),
                    onTap: () {
                      context.pushNamed(CreateBillReceipt.routeName);
                    }),
                // ListTile(
                //     title: const Text("Edit"),
                //     onTap: () {
                //       context.pushNamed(GetBusinessPartner.routeName);
                //     }
                // )
              ],
            ),
            ListTile(
              leading: const Icon(Icons.bookmark_border_outlined),
              title: const Text("BR Pending"),
              onTap: () {
                context.pushNamed(BrFilterForm.routeName);
              },
            ),
            ExpansionTile(
              leading: const Icon(Icons.input_outlined),
              title: const Text("Visit Info"),
              children: [
                ListTile(
                  title: const Text("Create"),
                  onTap: () {
                    context.pushNamed(AddVisitInfo.routeName);
                  },
                ),
                ListTile(
                  title: const Text("Report"),
                  onTap: () {
                    context.pushNamed(GetVisitInfoReport.routeName);
                  },
                )
              ],
            ),
            ExpansionTile(
              leading: const Icon(Icons.document_scanner_outlined),
              title: const Text("TA Claim"),
              children: [
                ListTile(
                  title: const Text("Create"),
                  onTap: () {
                    context.pushNamed(AddTaClaim.routeName);
                  },
                ),
                ListTile(
                  title: const Text("Report"),
                  onTap: () {
                    context.pushNamed(GetClaimReport.routeName);
                  },
                )
              ],
            ),
            ExpansionTile(
              leading: const Icon(Icons.attach_money_outlined),
              title: const Text("Finance"),
              children: [
                ListTile(
                  // leading: const Icon(Icons.note_alt_outlined),
                  title: const Text("Sales Debit Note"),
                  onTap: () {
                    context.pushNamed(SalesDebitNoteDetails.routeName);
                  },
                ),
                ListTile(
                  // leading: const Icon(Icons.note_alt_outlined),
                  title: const Text("Credit Note"),
                  onTap: () {
                    context.pushNamed(CrNoteDetails.routeName);
                  },
                ),
                ListTile(
                  // leading: const Icon(Icons.note_alt_outlined),
                  title: const Text("PR Tax Invoice"),
                  onTap: () {
                    context.pushNamed(PrTaxInvoiceDetails.routeName);
                  },
                ),
                ListTile(
                  // leading: const Icon(Icons.note_alt_outlined),
                  title: const Text("Debit Note"),
                  onTap: () {
                    context.pushNamed(DbNoteDetails.routeName);
                  },
                ),
                ListTile(
                  // leading: const Icon(Icons.note_alt_outlined),
                  title: const Text("Receipt Voucher"),
                  onTap: () {
                    context.pushNamed(CreateReceiptVoucher.routeName);
                  },
                ),
                ExpansionTile(
                  // leading: const Icon(Icons.note_alt_outlined),
                  title: const Text("Journal Voucher"),
                  children: [
                    ListTile(
                      // leading: const Icon(Icons.note_alt_outlined),
                      title: const Text("Create"),
                      onTap: () {
                        context.pushNamed(AddJournalVoucher.routeName);
                      },
                    ),
                    ListTile(
                      // leading: const Icon(Icons.note_alt_outlined),
                      title: const Text("Report"),
                      onTap: () {
                        context.pushNamed(JournalVoucherReportForm.routeName);
                      },
                    ),
                  ],
                ),
                ListTile(
                  // leading: const Icon(Icons.payment_outlined),
                  title: const Text("Payment Voucher"),
                  onTap: () {
                    context.pushNamed(CreatePaymentVoucher.routeName);
                  },
                ),
                ListTile(
                  // leading: const Icon(Icons.note_alt_outlined),
                  title: const Text("Financial Credit Note"),
                  onTap: () {
                    context.pushNamed(CreateFinancialCrnote.routeName);
                  },
                ),
                ListTile(
                  // leading: const Icon(Icons.balance_outlined),
                  title: const Text("Opening Balance"),
                  onTap: () {
                    context.pushNamed(CreateOBalance.routeName);
                  },
                ),
                ListTile(
                  // leading: const Icon(Icons.request_page_outlined),
                  title: const Text("Bill Payable"),
                  onTap: () {
                    context.pushNamed(AddBillPayable.routeName);
                  },
                ),
                ListTile(
                  // leading: const Icon(Icons.request_page_outlined),
                  title: const Text("Bill Receivable"),
                  onTap: () {
                    context.pushNamed(AddBillReceivable.routeName);
                  },
                ),
                ListTile(
                  // leading: const Icon(Icons.card_giftcard_outlined),
                  title: const Text("Inward Voucher"),
                  onTap: () {
                    context.pushNamed(CreateInwardVoucher.routeName);
                  },
                ),
                ListTile(
                  title: const Text("Bill Pending"),
                  onTap: () {
                    context.pushNamed(BillPendingReportForm.routeName);
                  },
                ),
                ListTile(
                  title: const Text("Payment Pending"),
                  onTap: () {
                    context.pushNamed(PaymentPendingReportForm.routeName);
                  },
                ),
                ListTile(
                  title: const Text("Payment Advance Pending"),
                  onTap: () {
                    context.pushNamed(PaymentAdvancePending.routeName);
                  },
                ),
                ListTile(
                  title: const Text("Unadjusted Payment Pending"),
                  onTap: () {
                    context.pushNamed(UnadjustedPaymentPending.routeName);
                  },
                ),
                ListTile(
                  title: const Text("Inward Bill Report"),
                  onTap: () {
                    context.pushNamed(InwardReportForm.routeName);
                  },
                ),
                ListTile(
                  title: const Text("Purchase Transfer"),
                  onTap: () {
                    context.pushNamed(PurchaseBillPendingReportForm.routeName);
                  },
                ),
                ListTile(
                  title: const Text("Payment Inward"),
                  onTap: () {
                    context.pushNamed(AddPaymentInward.routeName);
                  },
                ),
                ListTile(
                  title: const Text("Unadjusted Payment Inward Pending"),
                  onTap: () {
                    context.pushNamed(UnadjustedPaymentInward.routeName);
                  },
                ),
                ListTile(
                  // leading: const Icon(Icons.note_alt_outlined),
                  title: const Text("Debit Note Report"),
                  onTap: () {
                    context.pushNamed(DbNoteReportForm.routeName);
                  },
                ),
                ListTile(
                  // leading: const Icon(Icons.note_alt_outlined),
                  title: const Text("Sales Debit Note Report"),
                  onTap: () {
                    context.pushNamed(SaleDebitNoteReportForm.routeName);
                  },
                ),
                ListTile(
                  // leading: const Icon(Icons.note_alt_outlined),
                  title: const Text("Credit Note Report"),
                  onTap: () {
                    context.pushNamed(CrNoteReportForm.routeName);
                  },
                ),
                ListTile(
                  // leading: const Icon(Icons.note_alt_outlined),
                  title: const Text("Pr Tax Invoice Report"),
                  onTap: () {
                    context.pushNamed(PrTaxInvoiceReportForm.routeName);
                  },
                ),
              ],
            ),
            ExpansionTile(
              leading: const Icon(Icons.shopping_cart_outlined),
              title: const Text("Sales"),
              children: [
                ExpansionTile(
                  title: const Text("Resource"),
                  children: [
                    ListTile(
                      title: const Text("Create"),
                      onTap: () {
                        context.pushNamed(Resources.routeName);
                      },
                    ),
                    ListTile(
                      title: const Text("Edit"),
                      onTap: () {
                        context.pushNamed(GetResources.routeName);
                      },
                    ),
                    ListTile(
                      title: const Text("Report"),
                      onTap: () {
                        context.pushNamed(ResourceReport.routeName);
                      },
                    ),
                  ],
                ),
                ExpansionTile(
                  title: const Text("BP Shipping"),
                  children: [
                    ListTile(
                      title: const Text("Create"),
                      onTap: () {
                        context.pushNamed(BpShipping.routeName);
                      },
                    ),
                    ListTile(
                      title: const Text("Edit"),
                      onTap: () {
                        context.pushNamed(GetBpShipping.routeName);
                      },
                    ),
                    ListTile(
                      title: const Text("Report"),
                      onTap: () {
                        context.pushNamed(ShippingReportForm.routeName);
                      },
                    ),
                  ],
                ),
                ExpansionTile(
                  title: const Text("Carrier"),
                  children: [
                    ListTile(
                      title: const Text("Create"),
                      onTap: () {
                        context.pushNamed(Carrier.routeName);
                      },
                    ),
                    ListTile(
                      title: const Text("Edit"),
                      onTap: () {
                        context.pushNamed(GetCarrier.routeName);
                      },
                    ),
                    ListTile(
                      title: const Text("Report"),
                      onTap: () {
                        context.pushNamed(CarrierReport.routeName);
                      },
                    ),
                  ],
                ),
                ExpansionTile(
                  title: const Text("Sales Order"),
                  children: [
                    ListTile(
                      title: const Text("Create Order"),
                      onTap: () {
                        context.pushNamed(SalesOrderDetails.routeName);
                      },
                    ),
                    ListTile(
                      title: const Text("Sales Order Details"),
                      onTap: () {
                        context.pushNamed(OrderReport.routeName);
                      },
                    ),
                    ListTile(
                      title: const Text("Sales Order Report"),
                      onTap: () {
                        context.pushNamed(SalesOrderReportForm.routeName);
                      },
                    )
                  ],
                ),
                ListTile(
                  title: const Text("Sale Transfer"),
                  onTap: () {
                    context.pushNamed(SalePaymentPendingReportForm.routeName);
                  },
                ),
                ListTile(
                  title: const Text("Export Eway Bill Sale"),
                  onTap: () {
                    context.pushNamed(ExportEwayBillSale.routeName);
                  },
                ),
                ListTile(
                  title: const Text("Sale Report"),
                  onTap: () {
                    context.pushNamed(SalesReportForm.routeName);
                  },
                ),
              ],
            ),
            ListTile(
              leading: const Icon(Icons.send_to_mobile_outlined),
              title: const Text("Debit Note Dispatch"),
              onTap: () {
                context.pushNamed(AddDebitNoteDispatch.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.send_to_mobile_outlined),
              title: const Text("PR Tax Invoice Dispatch"),
              onTap: () {
                context.pushNamed(AddPrTaxInvoiceDispatch.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.send_to_mobile_outlined),
              title: const Text("Debit Note Against Credit Note"),
              onTap: () {
                context.pushNamed(AddDbNoteAgainstCrNote.routeName);
              },
            ),
            ExpansionTile(
              leading: const Icon(Icons.arrow_circle_up_outlined),
              title: const Text("Order Processing"),
              children: [
                ListTile(
                  title: const Text("Order Approval Request"),
                  onTap: () {
                    context.pushNamed(GetPendingApRequest.routeName);
                  },
                ),
                ListTile(
                  title: const Text("Order Approval"),
                  onTap: () {
                    context.pushNamed(GetOrderApprovalPending.routeName);
                  },
                ),
                ListTile(
                  title: const Text("Hold/Denied Orders Report"),
                  onTap: () {
                    context.pushNamed(HoldDeniedOrderReport.routeName);
                  },
                ),
                ListTile(
                  title: const Text("Order Packing Pending"),
                  onTap: () {
                    context.pushNamed(OrderPackagingPending.routeName);
                  },
                ),
                ListTile(
                  title: const Text("Order Bill Pending"),
                  onTap: () {
                    context.pushNamed(GetOrderBilledPending.routeName);
                  },
                ),
                ListTile(
                  title: const Text("Order Goods Dispatch"),
                  onTap: () {
                    context.pushNamed(GetOrderGoodsDispatchPending.routeName);
                  },
                ),
                ListTile(
                  title: const Text("Order Transport"),
                  onTap: () {
                    context.pushNamed(GetOrderTransportPending.routeName);
                  },
                ),
                // ListTile(
                //   title: const Text("Order Delivery"),
                //   onTap: () {
                //     context.pushNamed(GetOrderDeliveryPending.routeName);
                //   },
                // ),
                ListTile(
                  title: const Text("Order Cancel"),
                  onTap: () {
                    context.pushNamed(AddOrderCancel.routeName);
                  },
                ),
              ],
            ),
            ListTile(
              leading: const Icon(Icons.linear_scale_outlined),
              title: const Text("Wire Size"),
              onTap: () {
                context.pushNamed(WireSizeByMatno.routeName);
              },
            ),
            ExpansionTile(
              leading: const Icon(Icons.perm_device_info_outlined),
              title: const Text("Resource"),
              children: [
                ListTile(
                  title: const Text("Add"),
                  onTap: () {
                    context.pushNamed(AddCostResource.routeName);
                  },
                ),
                ListTile(
                  title: const Text("Update"),
                  onTap: () {
                    context.pushNamed(GetCostResource.routeName);
                  },
                ),
                ListTile(
                  title: const Text("Report/Delete"),
                  onTap: () {
                    context.pushNamed(CostResourceReport.routeName);
                  },
                ),
              ],
            ),
            ExpansionTile(
              leading: const Icon(Icons.perm_device_info_outlined),
              title: const Text("Work Process"),
              children: [
                ListTile(
                  title: const Text("Add"),
                  onTap: () {
                    context.pushNamed(AddWorkProcess.routeName);
                  },
                ),
                ListTile(
                  title: const Text("Update"),
                  onTap: () {
                    context.pushNamed(GetWorkProcess.routeName);
                  },
                ),
                ListTile(
                  title: const Text("Report/Delete"),
                  onTap: () {
                    context.pushNamed(WorkProcessReport.routeName);
                  },
                ),
              ],
            ),
            ListTile(
              leading: const Icon(Icons.linear_scale_outlined),
              title: const Text("Part Assembly"),
              onTap: () {
                context.pushNamed(PartAssemblyByMatno.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.subscript_outlined),
              title: const Text("Part Sub Assembly"),
              onTap: () {
                context.pushNamed(PartSubAssemblyByMatno.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.production_quantity_limits_outlined),
              title: const Text("Product Breakup"),
              onTap: () {
                context.pushNamed(ProductBreakupByMatno.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.perm_device_info_outlined),
              title: const Text("Product Breakup Tech Details"),
              onTap: () {
                context.pushNamed(AddProductBreakupTechDetails.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.mode_standby_outlined),
              title: const Text("Product Final Standard"),
              onTap: () {
                context.pushNamed(AddProductFinalStandard.routeName);
              },
            ),
            ExpansionTile(leading: const Icon(Icons.upload_file_outlined),title: const Text("Bank Details"), children: [
              ListTile(
                title: const Text("Upload"),
                onTap: () {
                  context.pushNamed(BankUpload.routeName);
                },
              ),
              ListTile(
                title: const Text("Bank Statements"),
                onTap: () {
                  context.pushNamed(BankReportForm.routeName);
                },
              ),
            ],),
            ExpansionTile(
              leading: const Icon(Icons.perm_device_info_outlined),
              title: const Text("Material Incoming Standard"),
              children: [
                ListTile(
                  title: const Text("Add"),
                  onTap: () {
                    context.pushNamed(AddMaterialIncomingStandard.routeName);
                  },
                ),
                ListTile(
                  title: const Text("Report/Delete"),
                  onTap: () {
                    context.pushNamed(MaterialIncomingStandardReport.routeName);
                  },
                ),
              ],
            ),
            ExpansionTile(
                leading: const Icon(Icons.not_started_outlined),
                title: const Text("Production"),
                children: [
                  ExpansionTile(
                    title: const Text('Manufacture'),
                    children: [
                      ListTile(
                        title: const Text("Add"),
                        onTap: () {
                          context.pushNamed(AddManufacturing.routeName);
                        },
                      ),
                      ListTile(
                        title: const Text("Report/Delete"),
                        onTap: () {
                          context.pushNamed(ManufacturingReportForm.routeName);
                        },
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: const Text('Inventory Requirement'),
                    children: [
                      ListTile(
                        title: const Text("Add Req. Auto"),
                        onTap: () {
                          context.pushNamed(AddReq.routeName);
                        },
                      ),
                      ListTile(
                        title: const Text("Add Req. Manual"),
                        onTap: () {
                          context.pushNamed(AddReqDetails.routeName);
                        },
                      ),
                      // ListTile(
                      //   title: const Text("Report/Delete"),
                      //   onTap: () {
                      //     context.pushNamed(ManufacturingReportForm.routeName);
                      //   },
                      // ),
                    ],
                  ),
                  ListTile(
                    leading: const Icon(Icons.crisis_alert_outlined),
                    title: const Text("Req. Production Pending"),
                    onTap: () {
                      context.pushNamed(ReqProductionPending.routeName);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.crisis_alert_outlined),
                    title: const Text("Req. Packing Pending"),
                    onTap: () {
                      context.pushNamed(ReqPackingPending.routeName);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.crisis_alert_outlined),
                    title: const Text("Req. Packed Pending"),
                    onTap: () {
                      context.pushNamed(ReqPackedPending.routeName);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.file_open_outlined),
                    title: const Text("Req. Issue Pending"),
                    onTap: () {
                      context.pushNamed(ReqIssuePending.routeName);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.file_open_outlined),
                    title: const Text("Job WorkOut Challan Clear"),
                    onTap: () {
                      context.pushNamed(AddJobWorkOutChallanClear.routeName);
                    },
                  ),
                ]),
            ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: const Text("Logout"),
              onTap: () async {
                bool confirmation = await showConfirmationDialogue(
                    context,
                    "Logging out will end your current session. Are you sure you want to proceed?",
                    "LOGOUT",
                    "GO BACK");
                if (confirmation) {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove("auth_token");
                  GlobalVariables.requestBody.clear();
                  Navigator.pop(context);
                  context.pushNamed(LoginScreen.routeName);
                }
              },
            )
          ],
        ),
      );
    });
  }
}
