import 'package:fintech_new_web/features/JVoucher/screens/add_journal_voucher.dart';
import 'package:fintech_new_web/features/JVoucher/screens/journal_voucher_report.dart';
import 'package:fintech_new_web/features/JVoucher/screens/journal_voucher_report_form.dart';
import 'package:fintech_new_web/features/additionalOrder/screen/additional_order.dart';
import 'package:fintech_new_web/features/additionalOrder/screen/additional_purchase_order_report.dart';
import 'package:fintech_new_web/features/additionalOrder/screen/additional_purchase_order_report_form.dart';
import 'package:fintech_new_web/features/attendence/screen/attendace_report.dart';
import 'package:fintech_new_web/features/attendence/screen/get_attendance_report.dart';
import 'package:fintech_new_web/features/auth/screen/otp_verification.dart';
import 'package:fintech_new_web/features/auth/screen/register_2fa.dart';
import 'package:fintech_new_web/features/bankUpload/screens/bank_report.dart';
import 'package:fintech_new_web/features/bankUpload/screens/bank_report_form.dart';
import 'package:fintech_new_web/features/bankUpload/screens/bank_upload.dart';
import 'package:fintech_new_web/features/billPayable/screen/add_bill_payable.dart';
import 'package:fintech_new_web/features/billReceipt/screen/bill_receipt.dart';
import 'package:fintech_new_web/features/billReceipt/screen/br_filter_form.dart';
import 'package:fintech_new_web/features/billReceipt/screen/create_bill_receipt.dart';
import 'package:fintech_new_web/features/billReceivable/screens/add_bill_receivable.dart';
import 'package:fintech_new_web/features/bpShipping/screens/bp_shipping.dart';
import 'package:fintech_new_web/features/bpShipping/screens/get_bp_shipping.dart';
import 'package:fintech_new_web/features/bpShipping/screens/shipping_report.dart';
import 'package:fintech_new_web/features/bpShipping/screens/shipping_report_form.dart';
import 'package:fintech_new_web/features/businessPartner/screen/bp_report.dart';
import 'package:fintech_new_web/features/businessPartner/screen/bp_report_form.dart';
import 'package:fintech_new_web/features/businessPartner/screen/business_partner.dart';
import 'package:fintech_new_web/features/carrier/screens/carrier.dart';
import 'package:fintech_new_web/features/carrier/screens/carrier_report.dart';
import 'package:fintech_new_web/features/carrier/screens/get_carrier.dart';
import 'package:fintech_new_web/features/costResource/screens/add_cost_resource.dart';
import 'package:fintech_new_web/features/costResource/screens/cost_resource_report.dart';
import 'package:fintech_new_web/features/costResource/screens/get_cost_resource.dart';
import 'package:fintech_new_web/features/crNote/screens/cr_note_details.dart';
import 'package:fintech_new_web/features/crNote/screens/cr_note_report_form.dart';
import 'package:fintech_new_web/features/crNote/screens/credit_note_report.dart';
import 'package:fintech_new_web/features/dbNote/screens/db_note_details.dart';
import 'package:fintech_new_web/features/dbNote/screens/db_note_report.dart';
import 'package:fintech_new_web/features/dbNote/screens/db_note_report_form.dart';
import 'package:fintech_new_web/features/debitNoteAgainstCreditNote/screens/add_db_note_against_cr_note.dart';
import 'package:fintech_new_web/features/debitNoteDispatch/screens/add_debit_note_dispatch.dart';
import 'package:fintech_new_web/features/dlChallan/screens/add_dl_challan.dart';
import 'package:fintech_new_web/features/dlChallan/screens/dl_challan_report.dart';
import 'package:fintech_new_web/features/dlChallan/screens/dl_challan_report_form.dart';
import 'package:fintech_new_web/features/evOrder/screen/ev_order.dart';
import 'package:fintech_new_web/features/financialCreditNote/screens/create_financial_crnote.dart';
import 'package:fintech_new_web/features/gr/screen/gr_details.dart';
import 'package:fintech_new_web/features/gr/screen/gr_rate_approval_pending.dart';
import 'package:fintech_new_web/features/gr/screen/gr_rejection_pending.dart';
import 'package:fintech_new_web/features/gr/screen/gr_report_form.dart';
import 'package:fintech_new_web/features/gr/screen/gr_report_screen.dart';
import 'package:fintech_new_web/features/gr/screen/gr_shortage_pending.dart';
import 'package:fintech_new_web/features/grIqsRep/screens/gr_iqs_pending.dart';
import 'package:fintech_new_web/features/grIqsRep/screens/add_gr_iqs_rep.dart';
import 'package:fintech_new_web/features/grOtherCharges/screens/add_gr_charges.dart';
import 'package:fintech_new_web/features/grQtyClear/screens/add_gr_qty_clear.dart';
import 'package:fintech_new_web/features/grQtyClear/screens/gr_qty_clear_pending.dart';
import 'package:fintech_new_web/features/hsn/screens/add_hsn.dart';
import 'package:fintech_new_web/features/hsn/screens/get_hsn.dart';
import 'package:fintech_new_web/features/hsn/screens/hsn_report.dart';
import 'package:fintech_new_web/features/invenReq/screens/add_req.dart';
import 'package:fintech_new_web/features/invenReq/screens/add_req_details.dart';
import 'package:fintech_new_web/features/inward/screens/inward.dart';
import 'package:fintech_new_web/features/inward/screens/inward_report.dart';
import 'package:fintech_new_web/features/inward/screens/inward_report_form.dart';
import 'package:fintech_new_web/features/inwardVoucher/screens/create_inward_voucher.dart';
import 'package:fintech_new_web/features/jobWorkOut/screens/add_job_work_out.dart';
import 'package:fintech_new_web/features/jobWorkOut/screens/add_job_work_out_details.dart';
import 'package:fintech_new_web/features/jobWorkOut/screens/job_workout_report.dart';
import 'package:fintech_new_web/features/jobWorkOut/screens/job_workout_report_form.dart';
import 'package:fintech_new_web/features/jobWorkOutChallanClear/screens/add_job_work_out_challan_clear.dart';
import 'package:fintech_new_web/features/ledgerCodes/screen/get_ledger_codes.dart';
import 'package:fintech_new_web/features/ledgerCodes/screen/ledger_code_report.dart';
import 'package:fintech_new_web/features/ledgerCodes/screen/ledger_code_report_form.dart';
import 'package:fintech_new_web/features/ledgerCodes/screen/ledger_codes.dart';
import 'package:fintech_new_web/features/lineRejection/screens/add_line_rejection.dart';
import 'package:fintech_new_web/features/manufacturing/screens/add_manufacturing.dart';
import 'package:fintech_new_web/features/manufacturing/screens/manufacturing_report.dart';
import 'package:fintech_new_web/features/manufacturing/screens/manufacturing_report_form.dart';
import 'package:fintech_new_web/features/material/screen/get_material.dart';
import 'package:fintech_new_web/features/material/screen/mat_stock_report.dart';
import 'package:fintech_new_web/features/material/screen/mat_stock_report_form.dart';
import 'package:fintech_new_web/features/material/screen/material_group_report.dart';
import 'package:fintech_new_web/features/material/screen/material_rep_form.dart';
import 'package:fintech_new_web/features/material/screen/material_rep_report.dart';
import 'package:fintech_new_web/features/material/screen/material_report.dart';
import 'package:fintech_new_web/features/material/screen/material_report_form.dart';
import 'package:fintech_new_web/features/material/screen/material_type_report.dart';
import 'package:fintech_new_web/features/materialIQS/screens/create_material_iqs.dart';
import 'package:fintech_new_web/features/materialIQS/screens/get-material-iqs.dart';
import 'package:fintech_new_web/features/materialIncomingStandard/screens/add_material_incoming_standard.dart';
import 'package:fintech_new_web/features/materialIncomingStandard/screens/material_incoming_standard_report.dart';
import 'package:fintech_new_web/features/materialReturn/screens/add_material_return.dart';
import 'package:fintech_new_web/features/materialSource/screen/get_material_source.dart';
import 'package:fintech_new_web/features/materialSource/screen/material_source.dart';
import 'package:fintech_new_web/features/materialSource/screen/material_source_report.dart';
import 'package:fintech_new_web/features/materialSource/screen/material_source_report_form.dart';
import 'package:fintech_new_web/features/obalance/screens/create-obalance.dart';
import 'package:fintech_new_web/features/obalance/screens/get-obalance.dart';
import 'package:fintech_new_web/features/orderApRequest/screens/add_order_ap_request.dart';
import 'package:fintech_new_web/features/orderApRequest/screens/get_pending_ap_request.dart';
import 'package:fintech_new_web/features/orderApproval/screens/add_order_approval.dart';
import 'package:fintech_new_web/features/orderBilled/screens/get_order_billed_pending.dart';
import 'package:fintech_new_web/features/orderBilled/screens/upload_order_bill.dart';
import 'package:fintech_new_web/features/orderCancel/screens/add_order_cancel.dart';
import 'package:fintech_new_web/features/orderDelivery/screens/add_order_delivery.dart';
import 'package:fintech_new_web/features/orderDelivery/screens/get_order_delivery_pending.dart';
import 'package:fintech_new_web/features/orderGoodsDispatch/screens/add_order_goods_dispatch.dart';
import 'package:fintech_new_web/features/orderGoodsDispatch/screens/get_order_goods_dispatch_pending.dart';
import 'package:fintech_new_web/features/orderPackaging/screens/order_packaging_pending.dart';
import 'package:fintech_new_web/features/orderPackaging/screens/pack_order.dart';
import 'package:fintech_new_web/features/orderPacked/screens/add_order_packed.dart';
import 'package:fintech_new_web/features/orderTransport/screens/add_order_transport.dart';
import 'package:fintech_new_web/features/orderTransport/screens/get_order_transport_pending.dart';
import 'package:fintech_new_web/features/partAssembly/screens/create_part_assembly_details.dart';
import 'package:fintech_new_web/features/partAssembly/screens/create_part_assembly_processing.dart';
import 'package:fintech_new_web/features/partAssembly/screens/part_assembly_by_matno.dart';
import 'package:fintech_new_web/features/partAssembly/screens/part_assembly_details.dart';
import 'package:fintech_new_web/features/partAssembly/screens/part_assembly_details_master_table.dart';
import 'package:fintech_new_web/features/partAssembly/screens/part_assembly_processing_table.dart';
import 'package:fintech_new_web/features/payment/screens/add_payment.dart';
import 'package:fintech_new_web/features/paymentClear/screens/add_payment_clear.dart';
import 'package:fintech_new_web/features/paymentClear/screens/payment_advance_pending.dart';
import 'package:fintech_new_web/features/payment/screens/bill_pending_report.dart';
import 'package:fintech_new_web/features/paymentClear/screens/unadjusted_payment_pending.dart';
import 'package:fintech_new_web/features/paymentInward/screens/add_cr_note_clear.dart';
import 'package:fintech_new_web/features/paymentInward/screens/add_payment_inward.dart';
import 'package:fintech_new_web/features/paymentInward/screens/unadjusted_payment_inward.dart';
import 'package:fintech_new_web/features/prTaxInvoice/screens/pr_tax_invoice_details.dart';
import 'package:fintech_new_web/features/prTaxInvoice/screens/pr_tax_invoice_report.dart';
import 'package:fintech_new_web/features/prTaxInvoice/screens/pr_tax_invoice_report_form.dart';
import 'package:fintech_new_web/features/prTaxInvoiceDispatch/screens/add_pr_tax_invoice_dispatch.dart';
import 'package:fintech_new_web/features/productBreakupTechDetails/screens/add_product_breakup_tech_details.dart';
import 'package:fintech_new_web/features/productFinalStandard/screens/add_product_final_standard.dart';
import 'package:fintech_new_web/features/productionPlan/screens/add_production_plan.dart';
import 'package:fintech_new_web/features/productionPlan/screens/delete_production_plan.dart';
import 'package:fintech_new_web/features/purchaseTransfer/screens/add_purchase_transfer.dart';
import 'package:fintech_new_web/features/purchaseTransfer/screens/add_purchase_transfer_clear.dart';
import 'package:fintech_new_web/features/purchaseTransfer/screens/purchase_bill_pending_report.dart';
import 'package:fintech_new_web/features/purchaseTransfer/screens/purchase_bill_pending_report_form.dart';
import 'package:fintech_new_web/features/receiptVoucher/screens/create_receipt_voucher.dart';
import 'package:fintech_new_web/features/reqIssue/screens/add_req_issue.dart';
import 'package:fintech_new_web/features/reqIssue/screens/req_issue_pending.dart';
import 'package:fintech_new_web/features/reqPacked/screens/add_req_packed.dart';
import 'package:fintech_new_web/features/reqPacked/screens/req_packed_pending.dart';
import 'package:fintech_new_web/features/reqPacking/screens/add_req_packing.dart';
import 'package:fintech_new_web/features/reqPacking/screens/req_packing_pending.dart';
import 'package:fintech_new_web/features/reqProduction/screens/add_req_production.dart';
import 'package:fintech_new_web/features/reqProduction/screens/req_production_pending.dart';
import 'package:fintech_new_web/features/resources/screens/resource_report.dart';
import 'package:fintech_new_web/features/resources/screens/resources.dart';
import 'package:fintech_new_web/features/saleTransfer/screens/add_sale_transfer.dart';
import 'package:fintech_new_web/features/saleTransfer/screens/add_sale_transfer_clear.dart';
import 'package:fintech_new_web/features/saleTransfer/screens/payment_pending_report.dart';
import 'package:fintech_new_web/features/saleTransfer/screens/payment_pending_report_form.dart';
import 'package:fintech_new_web/features/saleTransfer/screens/sale_payment_pending_report.dart';
import 'package:fintech_new_web/features/saleTransfer/screens/sale_payment_pending_report_form.dart';
import 'package:fintech_new_web/features/salesDebitNote/screens/sale_debit_note_report_form.dart';
import 'package:fintech_new_web/features/salesDebitNote/screens/sales_debit_note_details.dart';
import 'package:fintech_new_web/features/salesOrder/screens/export_eway_bill_sale.dart';
import 'package:fintech_new_web/features/salesOrder/screens/order_report.dart';
import 'package:fintech_new_web/features/salesOrder/screens/sales_order.dart';
import 'package:fintech_new_web/features/salesOrder/screens/sales_order_add_item.dart';
import 'package:fintech_new_web/features/salesOrder/screens/sales_order_report.dart';
import 'package:fintech_new_web/features/salesOrder/screens/sales_order_report_form.dart';
import 'package:fintech_new_web/features/salesOrder/screens/sales_report_form.dart';
import 'package:fintech_new_web/features/taClaim/screens/add_ta_claim.dart';
import 'package:fintech_new_web/features/taClaim/screens/claim_report.dart';
import 'package:fintech_new_web/features/taClaim/screens/get_claim_report.dart';
import 'package:fintech_new_web/features/visitInfo/screens/add_visit_info.dart';
import 'package:fintech_new_web/features/visitInfo/screens/get_visit_info_report.dart';
import 'package:fintech_new_web/features/wireSize/screens/add_wire_size_details.dart';
import 'package:fintech_new_web/features/wireSize/screens/wire_size_by_matno.dart';
import 'package:fintech_new_web/features/wireSize/screens/wire_size_details.dart';
import 'package:fintech_new_web/features/workProcess/screens/add_work_process.dart';
import 'package:fintech_new_web/features/workProcess/screens/get_work_process.dart';
import 'package:fintech_new_web/features/workProcess/screens/work_process_report.dart';
import 'package:fintech_new_web/main.dart';
import 'package:go_router/go_router.dart';

import 'features/auth/screen/login.dart';
import 'features/businessPartner/screen/get-business-partner.dart';
import 'features/businessPartner/screen/bp_search_report.dart';
import 'features/businessPartner/screen/business_partner_search_form.dart';
import 'features/businessPartner/screen/business_partner_tabs.dart';
import 'features/company/screens/add_company_form.dart';
import 'features/gr/screen/add_gr_rate_approval.dart';
import 'features/gr/screen/gr_rate_difference_pending.dart';
import 'features/gr/screen/pending_gr_report.dart';
import 'features/home.dart';
import 'features/hsn/screens/ac_groups_report.dart';
import 'features/material/screen/material_screen.dart';
import 'features/material/screen/material_unit_report.dart';
import 'features/orderApproval/screens/get_order_approval_pending.dart';
import 'features/orderApproval/screens/hold_denied_order_report.dart';
import 'features/partAssembly/screens/part_assembly_details_table.dart';
import 'features/partSubAssembly/screens/create_part_sub_assembly_details.dart';
import 'features/partSubAssembly/screens/create_part_sub_assembly_processing.dart';
import 'features/partSubAssembly/screens/part_sub_assembly_by_matno.dart';
import 'features/partSubAssembly/screens/part_sub_assembly_details.dart';
import 'features/partSubAssembly/screens/part_sub_assembly_details_master_table.dart';
import 'features/partSubAssembly/screens/part_sub_assembly_details_table.dart';
import 'features/partSubAssembly/screens/part_sub_assembly_processing_table.dart';
import 'features/payment/screens/bill_pending_report_form.dart';
import 'features/paymentVoucher/screens/create_payment_voucher.dart';
import 'features/productBreakup/screens/create_product_breakup_details.dart';
import 'features/productBreakup/screens/create_product_breakup_processing.dart';
import 'features/productBreakup/screens/product_breakup_by_matno.dart';
import 'features/productBreakup/screens/product_breakup_details.dart';
import 'features/productBreakup/screens/product_breakup_details_master_table.dart';
import 'features/productBreakup/screens/product_breakup_details_table.dart';
import 'features/productBreakup/screens/product_breakup_processing_table.dart';
import 'features/productionPlanA/screen/add_production_planA.dart';
import 'features/purchaseOrder/screen/purchase_order.dart';
import 'features/purchaseOrder/screen/purchase_order_report_form.dart';
import 'features/purchaseOrder/screen/purchase_order_report_screen.dart';
import 'features/resources/screens/get_resources.dart';
import 'features/salesDebitNote/screens/sale_debit_note_report.dart';
import 'features/salesOrder/screens/delete_order_material.dart';
import 'features/salesOrder/screens/sales_report.dart';
import 'features/visitInfo/screens/visit_info_report.dart';
import 'features/warehouse/screen/warehouse.dart';
import 'features/wireSize/screens/edit_wire_size.dart';
import 'features/wireSize/screens/edit_wire_size_details.dart';
import 'features/wireSize/screens/wire_size_details_table.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: "/",
    routes: <RouteBase>[
      GoRoute(
          path: "/",
          name: "/",
          builder: (context, state) {
            return const HomeScreen();
          }),
      GoRoute(
        path: LoginScreen.routeName,
        name: "/login",
        builder: (context, state) {
          return const LoginScreen();
        },
        routes: [
          GoRoute(
            path: OTPVerificationScreen.routeName,
            name: OTPVerificationScreen.routeName,
            builder: (context, state) {
              return const OTPVerificationScreen();
            },
          ),
          GoRoute(
            path: Register2fa.routeName,
            name: Register2fa.routeName,
            builder: (context, state) {
              return Register2fa(qrUrl: state.uri.queryParameters['qrUrl'] ?? "");
            },
          ),
        ]
      ),

      GoRoute(
        path: AddCompanyForm.routeName,
        name: AddCompanyForm.routeName,
        builder: (context, state) {
          return const AddCompanyForm();
        },
      ),
      GoRoute(
          path: CreateBillReceipt.routeName,
          name: CreateBillReceipt.routeName,
          builder: (context, state) {
            return CreateBillReceipt(
                editing: state.uri.queryParameters["editing"] ?? '');
          },
          routes: [
            GoRoute(
                path: GetBusinessPartner.routeName,
                name: GetBusinessPartner.routeName,
                builder: (context, state) {
                  return const GetBusinessPartner();
                }),
            GoRoute(
                path: BpReportForm.routeName,
                name: BpReportForm.routeName,
                builder: (context, state) {
                  return const BpReportForm();
                }),
            GoRoute(
                path: BpReport.routeName,
                name: BpReport.routeName,
                builder: (context, state) {
                  return const BpReport();
                })
          ]),
      GoRoute(
          path: BusinessPartnerSearchForm.routeName,
          name: BusinessPartnerSearchForm.routeName,
          builder: (context, state) {
            return const BusinessPartnerSearchForm();
          },
          routes: [
            GoRoute(
                path: BpSearchReport.routeName,
                name: BpSearchReport.routeName,
                builder: (context, state) {
                  return const BpSearchReport();
                })
          ]),
      GoRoute(
        path: HomePageScreen.routeName,
        name: HomePageScreen.routeName,
        builder: (context, state) {
          return const HomePageScreen();
        },
      ),
      GoRoute(
        path: BusinessPartner.routeName,
        name: BusinessPartner.routeName,
        builder: (context, state) {
          return BusinessPartner(
              editing: state.uri.queryParameters['editing'] ?? '');
        },
      ),
      GoRoute(
          path: LedgerCodes.routeName,
          name: LedgerCodes.routeName,
          builder: (context, state) {
            return LedgerCodes(
                editing: state.uri.queryParameters['editing'] ?? '',
                partyCode: state.uri.queryParameters['partyCode'] ?? '');
          },
          routes: [
            GoRoute(
              path: GetLedgerCodes.routeName,
              name: GetLedgerCodes.routeName,
              builder: (context, state) {
                return const GetLedgerCodes();
              },
            ),
            GoRoute(
              path: LedgerCodeReportForm.routeName,
              name: LedgerCodeReportForm.routeName,
              builder: (context, state) {
                return const LedgerCodeReportForm();
              },
            ),
            GoRoute(
              path: LedgerCodeReport.routeName,
              name: LedgerCodeReport.routeName,
              builder: (context, state) {
                return const LedgerCodeReport();
              },
            ),
          ]),
      GoRoute(
          path: MaterialScreen.routeName,
          name: MaterialScreen.routeName,
          builder: (context, state) {
            return MaterialScreen(
                editing: state.uri.queryParameters['editing'] ?? "");
          },
          routes: [
            GoRoute(
              path: GetMaterial.routeName,
              name: GetMaterial.routeName,
              builder: (context, state) {
                return const GetMaterial();
              },
            ),
            GoRoute(
              path: MaterialTypeReport.routeName,
              name: MaterialTypeReport.routeName,
              builder: (context, state) {
                return const MaterialTypeReport();
              },
            ),
            GoRoute(
              path: MaterialUnitReport.routeName,
              name: MaterialUnitReport.routeName,
              builder: (context, state) {
                return const MaterialUnitReport();
              },
            ),
            GoRoute(
              path: MaterialGroupReport.routeName,
              name: MaterialGroupReport.routeName,
              builder: (context, state) {
                return const MaterialGroupReport();
              },
            ),
            GoRoute(
              path: MaterialReportForm.routeName,
              name: MaterialReportForm.routeName,
              builder: (context, state) {
                return const MaterialReportForm();
              },
            ),
            GoRoute(
              path: MaterialReport.routeName,
              name: MaterialReport.routeName,
              builder: (context, state) {
                return const MaterialReport();
              },
            ),
            GoRoute(
              path: MatStockReportForm.routeName,
              name: MatStockReportForm.routeName,
              builder: (context, state) {
                return const MatStockReportForm();
              },
            ),
            GoRoute(
              path: MatStockReport.routeName,
              name: MatStockReport.routeName,
              builder: (context, state) {
                return const MatStockReport();
              },
            ),
          ]),
      GoRoute(
          path: MaterialSource.routeName,
          name: MaterialSource.routeName,
          builder: (context, state) {
            return MaterialSource(
                editing: state.uri.queryParameters['editing'] ?? "");
          },
          routes: [
            GoRoute(
              path: MaterialSourceReport.routeName,
              name: MaterialSourceReport.routeName,
              builder: (context, state) {
                return const MaterialSourceReport();
              },
            ),
            GoRoute(
              path: MaterialSourceReportForm.routeName,
              name: MaterialSourceReportForm.routeName,
              builder: (context, state) {
                return const MaterialSourceReportForm();
              },
            ),
            GoRoute(
              path: GetMaterialSource.routeName,
              name: GetMaterialSource.routeName,
              builder: (context, state) {
                return const GetMaterialSource();
              },
            ),
          ]),
      GoRoute(
          path: PurchaseOrderScreen.routeName,
          name: PurchaseOrderScreen.routeName,
          builder: (context, state) {
            return const PurchaseOrderScreen();
          },
          routes: [
            GoRoute(
              path: PurchaseOrderReportForm.routeName,
              name: PurchaseOrderReportForm.routeName,
              builder: (context, state) {
                return const PurchaseOrderReportForm();
              },
            ),
            GoRoute(
              path: PurchaseOrderReportScreen.routeName,
              name: PurchaseOrderReportScreen.routeName,
              builder: (context, state) {
                return const PurchaseOrderReportScreen();
              },
            ),
          ]),
      GoRoute(
        path: BusinessPartnerTabs.routeName,
        name: BusinessPartnerTabs.routeName,
        builder: (context, state) {
          return const BusinessPartnerTabs();
        },
      ),
      GoRoute(
          path: MaterialRepForm.routeName,
          name: MaterialRepForm.routeName,
          builder: (context, state) {
            return const MaterialRepForm();
          },
          routes: [
            GoRoute(
              path: MaterialRepReport.routeName,
              name: MaterialRepReport.routeName,
              builder: (context, state) {
                return const MaterialRepReport();
              },
            ),
          ]),
      GoRoute(
          path: GrDetails.routeName,
          name: GrDetails.routeName,
          builder: (context, state) {
            return GrDetails(brDetails: state.uri.queryParameters['brDetails']);
          },
          routes: [
            GoRoute(
                path: GrIqsPending.routeName,
                name: GrIqsPending.routeName,
                builder: (context, state) {
                  return const GrIqsPending();
                }),
            GoRoute(
                path: GrRateDifferencePending.routeName,
                name: GrRateDifferencePending.routeName,
                builder: (context, state) {
                  return const GrRateDifferencePending();
                }),
            GoRoute(
                path: GrShortagePending.routeName,
                name: GrShortagePending.routeName,
                builder: (context, state) {
                  return const GrShortagePending();
                }),
            GoRoute(
                path: GrRateApprovalPending.routeName,
                name: GrRateApprovalPending.routeName,
                builder: (context, state) {
                  return const GrRateApprovalPending();
                }),
            GoRoute(
                path: GrRejectionPending.routeName,
                name: GrRejectionPending.routeName,
                builder: (context, state) {
                  return const GrRejectionPending();
                }),
            GoRoute(
                path: GrReportForm.routeName,
                name: GrReportForm.routeName,
                builder: (context, state) {
                  return const GrReportForm();
                }),
            GoRoute(
                path: GrReportScreen.routeName,
                name: GrReportScreen.routeName,
                builder: (context, state) {
                  return const GrReportScreen();
                }),
          ]),
      GoRoute(
          path: BillReceipt.routeName,
          name: BillReceipt.routeName,
          builder: (context, state) {
            return const BillReceipt();
          },
          routes: [
            GoRoute(
                path: BrFilterForm.routeName,
                name: BrFilterForm.routeName,
                builder: (context, state) {
                  return const BrFilterForm();
                }),
          ]),
      GoRoute(
          path: EvOrder.routeName,
          name: EvOrder.routeName,
          builder: (context, state) {
            return const EvOrder();
          }),
      GoRoute(
          path: AdditionalOrder.routeName,
          name: AdditionalOrder.routeName,
          builder: (context, state) {
            return const AdditionalOrder();
          }, routes: [
        GoRoute(
            path: AdditionalPurchaseOrderReportForm.routeName,
            name: AdditionalPurchaseOrderReportForm.routeName,
            builder: (context, state) {
              return const AdditionalPurchaseOrderReportForm();
            }),
        GoRoute(
            path: AdditionalPurchaseOrderReport.routeName,
            name: AdditionalPurchaseOrderReport.routeName,
            builder: (context, state) {
              return const AdditionalPurchaseOrderReport();
            }),
      ]),
      GoRoute(
          path: CreateMaterialIqs.routeName,
          name: CreateMaterialIqs.routeName,
          builder: (context, state) {
            return CreateMaterialIqs(
              editing: state.uri.queryParameters['editing'] ?? "",
            );
          },
          routes: [
            GoRoute(
                path: GetMaterialIqs.routeName,
                name: GetMaterialIqs.routeName,
                builder: (context, state) {
                  return const GetMaterialIqs();
                })
          ]),
      GoRoute(
          path: CreateOBalance.routeName,
          name: CreateOBalance.routeName,
          builder: (context, state) {
            return CreateOBalance(
              editing: state.uri.queryParameters['editing'] ?? "",
            );
          },
          routes: [
            GoRoute(
                path: GetOBalance.routeName,
                name: GetOBalance.routeName,
                builder: (context, state) {
                  return const GetOBalance();
                })
          ]),
      GoRoute(
          path: AddBillPayable.routeName,
          name: AddBillPayable.routeName,
          builder: (context, state) {
            return const AddBillPayable();
          }),
      GoRoute(
          path: AddBillReceivable.routeName,
          name: AddBillReceivable.routeName,
          builder: (context, state) {
            return const AddBillReceivable();
          }),
      GoRoute(
          path: CreateInwardVoucher.routeName,
          name: CreateInwardVoucher.routeName,
          builder: (context, state) {
            return CreateInwardVoucher(
              editing: state.uri.queryParameters['editing'] ?? "",
            );
          },
          routes: [
            GoRoute(
                path: InwardReportForm.routeName,
                name: InwardReportForm.routeName,
                builder: (context, state) {
                  return const InwardReportForm();
                }),
            GoRoute(
                path: InwardReport.routeName,
                name: InwardReport.routeName,
                builder: (context, state) {
                  return const InwardReport();
                }),
          ]),
      GoRoute(
          path: AddVisitInfo.routeName,
          name: AddVisitInfo.routeName,
          builder: (context, state) {
            return const AddVisitInfo();
          }),
      GoRoute(
          path: AddTaClaim.routeName,
          name: AddTaClaim.routeName,
          builder: (context, state) {
            return const AddTaClaim();
          }),
      GoRoute(
          path: GetAttendanceReport.routeName,
          name: GetAttendanceReport.routeName,
          builder: (context, state) {
            return const GetAttendanceReport();
          },
          routes: [
            GoRoute(
                path: AttendanceReport.routeName,
                name: AttendanceReport.routeName,
                builder: (context, state) {
                  return const AttendanceReport();
                })
          ]),
      GoRoute(
          path: GetVisitInfoReport.routeName,
          name: GetVisitInfoReport.routeName,
          builder: (context, state) {
            return const GetVisitInfoReport();
          },
          routes: [
            GoRoute(
                path: VisitInfoReport.routeName,
                name: VisitInfoReport.routeName,
                builder: (context, state) {
                  return const VisitInfoReport();
                })
          ]),
      GoRoute(
          path: GetClaimReport.routeName,
          name: GetClaimReport.routeName,
          builder: (context, state) {
            return const GetClaimReport();
          },
          routes: [
            GoRoute(
                path: ClaimReport.routeName,
                name: ClaimReport.routeName,
                builder: (context, state) {
                  return const ClaimReport();
                })
          ]),
      GoRoute(
          path: InwardDetails.routeName,
          name: InwardDetails.routeName,
          builder: (context, state) {
            return InwardDetails(
                grDetails: state.uri.queryParameters['grDetails'],
                disable: state.uri.queryParameters['disable'] ?? "");
          }),
      GoRoute(
          path: CreateFinancialCrnote.routeName,
          name: CreateFinancialCrnote.routeName,
          builder: (context, state) {
            return const CreateFinancialCrnote();
          }),
      GoRoute(
          path: CreateReceiptVoucher.routeName,
          name: CreateReceiptVoucher.routeName,
          builder: (context, state) {
            return const CreateReceiptVoucher();
          }),
      GoRoute(
          path: CreatePaymentVoucher.routeName,
          name: CreatePaymentVoucher.routeName,
          builder: (context, state) {
            return const CreatePaymentVoucher();
          }),
      GoRoute(
          path: DbNoteDetails.routeName,
          name: DbNoteDetails.routeName,
          builder: (context, state) {
            return const DbNoteDetails();
          }, routes: [
        GoRoute(
            path: DbNoteReportForm.routeName,
            name: DbNoteReportForm.routeName,
            builder: (context, state) {
              return const DbNoteReportForm();
            }),
        GoRoute(
            path: DbNoteReport.routeName,
            name: DbNoteReport.routeName,
            builder: (context, state) {
              return const DbNoteReport();
            }),
      ]),
      GoRoute(
          path: PrTaxInvoiceDetails.routeName,
          name: PrTaxInvoiceDetails.routeName,
          builder: (context, state) {
            return const PrTaxInvoiceDetails();
          }, routes: [
        GoRoute(
            path: PrTaxInvoiceReportForm.routeName,
            name: PrTaxInvoiceReportForm.routeName,
            builder: (context, state) {
              return const PrTaxInvoiceReportForm();
            }),
        GoRoute(
            path: PrTaxInvoiceReport.routeName,
            name: PrTaxInvoiceReport.routeName,
            builder: (context, state) {
              return const PrTaxInvoiceReport();
            }),
      ]),
      GoRoute(
          path: CrNoteDetails.routeName,
          name: CrNoteDetails.routeName,
          builder: (context, state) {
            return const CrNoteDetails();
          }, routes: [
        GoRoute(
            path: CrNoteReportForm.routeName,
            name: CrNoteReportForm.routeName,
            builder: (context, state) {
              return const CrNoteReportForm();
            }),
        GoRoute(
            path: CreditNoteReport.routeName,
            name: CreditNoteReport.routeName,
            builder: (context, state) {
              return const CreditNoteReport();
            }),
      ]),
      GoRoute(
          path: SalesDebitNoteDetails.routeName,
          name: SalesDebitNoteDetails.routeName,
          builder: (context, state) {
            return const SalesDebitNoteDetails();
          }, routes: [
        GoRoute(
            path: SaleDebitNoteReportForm.routeName,
            name: SaleDebitNoteReportForm.routeName,
            builder: (context, state) {
              return const SaleDebitNoteReportForm();
            }),
        GoRoute(
            path: SaleDebitNoteReport.routeName,
            name: SaleDebitNoteReport.routeName,
            builder: (context, state) {
              return const SaleDebitNoteReport();
            }),
      ]),
      GoRoute(
          path: AddDebitNoteDispatch.routeName,
          name: AddDebitNoteDispatch.routeName,
          builder: (context, state) {
            return const AddDebitNoteDispatch();
          }),
      GoRoute(
          path: AddDbNoteAgainstCrNote.routeName,
          name: AddDbNoteAgainstCrNote.routeName,
          builder: (context, state) {
            return const AddDbNoteAgainstCrNote();
          }),
      GoRoute(
          path: AddPrTaxInvoiceDispatch.routeName,
          name: AddPrTaxInvoiceDispatch.routeName,
          builder: (context, state) {
            return const AddPrTaxInvoiceDispatch();
          }),
      GoRoute(
          path: Resources.routeName,
          name: Resources.routeName,
          builder: (context, state) {
            return Resources(
                editing: state.uri.queryParameters["editing"] ?? '');
          },
          routes: [
            GoRoute(
                path: GetResources.routeName,
                name: GetResources.routeName,
                builder: (context, state) {
                  return const GetResources();
                }),
            GoRoute(
                path: ResourceReport.routeName,
                name: ResourceReport.routeName,
                builder: (context, state) {
                  return const ResourceReport();
                })
          ]),
      GoRoute(
          path: BpShipping.routeName,
          name: BpShipping.routeName,
          builder: (context, state) {
            return BpShipping(
                editing: state.uri.queryParameters["editing"] ?? '');
          },
          routes: [
            GoRoute(
                path: GetBpShipping.routeName,
                name: GetBpShipping.routeName,
                builder: (context, state) {
                  return const GetBpShipping();
                }),
            GoRoute(
                path: ShippingReportForm.routeName,
                name: ShippingReportForm.routeName,
                builder: (context, state) {
                  return const ShippingReportForm();
                }),
            GoRoute(
                path: ShippingReport.routeName,
                name: ShippingReport.routeName,
                builder: (context, state) {
                  return const ShippingReport();
                })
          ]),
      GoRoute(
          path: Carrier.routeName,
          name: Carrier.routeName,
          builder: (context, state) {
            return Carrier(editing: state.uri.queryParameters["editing"] ?? '');
          },
          routes: [
            GoRoute(
                path: GetCarrier.routeName,
                name: GetCarrier.routeName,
                builder: (context, state) {
                  return const GetCarrier();
                }),
            GoRoute(
                path: CarrierReport.routeName,
                name: CarrierReport.routeName,
                builder: (context, state) {
                  return const CarrierReport();
                })
          ]),
      GoRoute(
          path: SalesOrderDetails.routeName,
          name: SalesOrderDetails.routeName,
          builder: (context, state) {
            return const SalesOrderDetails();
          },
          routes: [
            GoRoute(
                path: OrderReport.routeName,
                name: OrderReport.routeName,
                builder: (context, state) {
                  return const OrderReport();
                }),
            GoRoute(
                path: SalesOrderAddItem.routeName,
                name: SalesOrderAddItem.routeName,
                builder: (context, state) {
                  return SalesOrderAddItem(
                    orderId: state.uri.queryParameters['orderId'] ?? "",
                    custCode: state.uri.queryParameters['custCode'] ?? "",
                  );
                }),
            GoRoute(
                path: DeleteOrderMaterial.routeName,
                name: DeleteOrderMaterial.routeName,
                builder: (context, state) {
                  return DeleteOrderMaterial(
                      orderId: state.uri.queryParameters['orderId'] ?? "");
                }),
            GoRoute(
                path: SalesOrderReportForm.routeName,
                name: SalesOrderReportForm.routeName,
                builder: (context, state) {
                  return const SalesOrderReportForm();
                }),
            GoRoute(
                path: SalesOrderReport.routeName,
                name: SalesOrderReport.routeName,
                builder: (context, state) {
                  return const SalesOrderReport();
                }),
            GoRoute(
                path: SalesReport.routeName,
                name: SalesReport.routeName,
                builder: (context, state) {
                  return const SalesReport();
                }),
            GoRoute(
                path: SalesReportForm.routeName,
                name: SalesReportForm.routeName,
                builder: (context, state) {
                  return const SalesReportForm();
                }),
          ]),
      GoRoute(
          path: AddGrCharges.routeName,
          name: AddGrCharges.routeName,
          builder: (context, state) {
            return const AddGrCharges();
          }),
      GoRoute(
          path: AddGrQtyClear.routeName,
          name: AddGrQtyClear.routeName,
          builder: (context, state) {
            return AddGrQtyClear(
                details: state.uri.queryParameters['details'] ?? "");
          },
          routes: [
            GoRoute(
                path: GrQtyClearPending.routeName,
                name: GrQtyClearPending.routeName,
                builder: (context, state) {
                  return const GrQtyClearPending();
                }),
          ]),
      GoRoute(
          path: AddGrIqsRep.routeName,
          name: AddGrIqsRep.routeName,
          builder: (context, state) {
            return const AddGrIqsRep();
          }),
      GoRoute(
          path: AddGrRateApproval.routeName,
          name: AddGrRateApproval.routeName,
          builder: (context, state) {
            return AddGrRateApproval(
                rateDetails: state.uri.queryParameters['rateDetails'] ?? "");
          }),
      GoRoute(
          path: GetOrderApprovalPending.routeName,
          name: GetOrderApprovalPending.routeName,
          builder: (context, state) {
            return const GetOrderApprovalPending();
          }),
      GoRoute(
          path: AddOrderApproval.routeName,
          name: AddOrderApproval.routeName,
          builder: (context, state) {
            return AddOrderApproval(
                orderId: state.uri.queryParameters['orderId'] ?? "");
          }),
      GoRoute(
          path: AddOrderCancel.routeName,
          name: AddOrderCancel.routeName,
          builder: (context, state) {
            return const AddOrderCancel();
          }),
      GoRoute(
          path: AddOrderPacked.routeName,
          name: AddOrderPacked.routeName,
          builder: (context, state) {
            return AddOrderPacked(
                orderId: state.uri.queryParameters['orderId'] ?? "");
          }),
      GoRoute(
          path: AddOrderTransport.routeName,
          name: AddOrderTransport.routeName,
          builder: (context, state) {
            return AddOrderTransport(
                orderId: state.uri.queryParameters['orderId'] ?? "");
          }),
      GoRoute(
          path: GetOrderTransportPending.routeName,
          name: GetOrderTransportPending.routeName,
          builder: (context, state) {
            return const GetOrderTransportPending();
          }),
      GoRoute(
          path: GetOrderGoodsDispatchPending.routeName,
          name: GetOrderGoodsDispatchPending.routeName,
          builder: (context, state) {
            return const GetOrderGoodsDispatchPending();
          }),
      GoRoute(
          path: AddOrderGoodsDispatch.routeName,
          name: AddOrderGoodsDispatch.routeName,
          builder: (context, state) {
            return AddOrderGoodsDispatch(
                orderId: state.uri.queryParameters['orderId'] ?? "");
          }),
      GoRoute(
          path: GetOrderDeliveryPending.routeName,
          name: GetOrderDeliveryPending.routeName,
          builder: (context, state) {
            return const GetOrderDeliveryPending();
          }),
      GoRoute(
          path: AddOrderDelivery.routeName,
          name: AddOrderDelivery.routeName,
          builder: (context, state) {
            return AddOrderDelivery(
                orderId: state.uri.queryParameters['orderId'] ?? "");
          }),
      GoRoute(
          path: AddOrderApRequest.routeName,
          name: AddOrderApRequest.routeName,
          builder: (context, state) {
            return AddOrderApRequest(
                orderId: state.uri.queryParameters['orderId'] ?? "");
          }),
      GoRoute(
          path: GetPendingApRequest.routeName,
          name: GetPendingApRequest.routeName,
          builder: (context, state) {
            return const GetPendingApRequest();
          }),
      GoRoute(
          path: UploadOrderBill.routeName,
          name: UploadOrderBill.routeName,
          builder: (context, state) {
            return UploadOrderBill(
                orderId: state.uri.queryParameters['orderId'] ?? "");
          }),
      GoRoute(
          path: GetOrderBilledPending.routeName,
          name: GetOrderBilledPending.routeName,
          builder: (context, state) {
            return const GetOrderBilledPending();
          }),
      GoRoute(
          path: OrderPackagingPending.routeName,
          name: OrderPackagingPending.routeName,
          builder: (context, state) {
            return const OrderPackagingPending();
          },
          routes: [
            GoRoute(
                path: PackOrder.routeName,
                name: PackOrder.routeName,
                builder: (context, state) {
                  return PackOrder(
                    orderId: state.uri.queryParameters['orderId'] ?? "",
                  );
                }),
          ]),
      GoRoute(
          path: Warehouse.routeName,
          name: Warehouse.routeName,
          builder: (context, state) {
            return const Warehouse();
          }),
      GoRoute(
          path: PendingGrReport.routeName,
          name: PendingGrReport.routeName,
          builder: (context, state) {
            return const PendingGrReport();
          }),
      GoRoute(
          path: WireSizeDetails.routeName,
          name: WireSizeDetails.routeName,
          builder: (context, state) {
            return const WireSizeDetails();
          },
          routes: [
            GoRoute(
                path: WireSizeByMatno.routeName,
                name: WireSizeByMatno.routeName,
                builder: (context, state) {
                  return const WireSizeByMatno();
                }),
            GoRoute(
                path: WireSizeDetailsTable.routeName,
                name: WireSizeDetailsTable.routeName,
                builder: (context, state) {
                  return const WireSizeDetailsTable();
                }),
            GoRoute(
                path: AddWireSizeDetails.routeName,
                name: AddWireSizeDetails.routeName,
                builder: (context, state) {
                  return const AddWireSizeDetails();
                }),
            GoRoute(
                path: EditWireSizeDetails.routeName,
                name: EditWireSizeDetails.routeName,
                builder: (context, state) {
                  return EditWireSizeDetails(
                      editData: state.uri.queryParameters['editData']);
                }),
            GoRoute(
                path: EditWireSize.routeName,
                name: EditWireSize.routeName,
                builder: (context, state) {
                  return EditWireSize(
                      editData: state.uri.queryParameters['editData'] ?? "");
                }),
          ]),
      GoRoute(
          path: AddPayment.routeName,
          name: AddPayment.routeName,
          builder: (context, state) {
            return AddPayment(
                editing: state.uri.queryParameters['editing'] ?? "",
                partyCode: state.uri.queryParameters['partyCode'] ?? "");
          },
          routes: [
            GoRoute(
                path: BillPendingReportForm.routeName,
                name: BillPendingReportForm.routeName,
                builder: (context, state) {
                  return const BillPendingReportForm();
                }),
            GoRoute(
                path: BillPendingReport.routeName,
                name: BillPendingReport.routeName,
                builder: (context, state) {
                  return const BillPendingReport();
                }),
          ]),
      GoRoute(
          path: BankUpload.routeName,
          name: BankUpload.routeName,
          builder: (context, state) {
            return const BankUpload();
          }, routes: [
        GoRoute(
            path: BankReportForm.routeName,
            name: BankReportForm.routeName,
            builder: (context, state) {
              return const BankReportForm();
            }),
        GoRoute(
            path: BankReport.routeName,
            name: BankReport.routeName,
            builder: (context, state) {
              return const BankReport();
            }),
      ]),

      GoRoute(
          path: PartAssemblyByMatno.routeName,
          name: PartAssemblyByMatno.routeName,
          builder: (context, state) {
            return const PartAssemblyByMatno();
          },
          routes: [
            GoRoute(
                path: PartAssemblyDetails.routeName,
                name: PartAssemblyDetails.routeName,
                builder: (context, state) {
                  return const PartAssemblyDetails();
                }),
            GoRoute(
                path: CreatePartAssemblyDetails.routeName,
                name: CreatePartAssemblyDetails.routeName,
                builder: (context, state) {
                  return const CreatePartAssemblyDetails();
                }),
            GoRoute(
                path: PartAssemblyDetailsTable.routeName,
                name: PartAssemblyDetailsTable.routeName,
                builder: (context, state) {
                  return const PartAssemblyDetailsTable();
                }),
            GoRoute(
                path: CreatePartAssemblyProcessing.routeName,
                name: CreatePartAssemblyProcessing.routeName,
                builder: (context, state) {
                  return const CreatePartAssemblyProcessing();
                }),
            GoRoute(
                path: PartAssemblyDetailsMasterTable.routeName,
                name: PartAssemblyDetailsMasterTable.routeName,
                builder: (context, state) {
                  return const PartAssemblyDetailsMasterTable();
                }),
            GoRoute(
                path: PartAssemblyProcessingTable.routeName,
                name: PartAssemblyProcessingTable.routeName,
                builder: (context, state) {
                  return const PartAssemblyProcessingTable();
                }),
          ]),

      GoRoute(
          path: PartSubAssemblyByMatno.routeName,
          name: PartSubAssemblyByMatno.routeName,
          builder: (context, state) {
            return const PartSubAssemblyByMatno();
          },
          routes: [
            GoRoute(
                path: PartSubAssemblyDetails.routeName,
                name: PartSubAssemblyDetails.routeName,
                builder: (context, state) {
                  return const PartSubAssemblyDetails();
                }),
            GoRoute(
                path: CreatePartSubAssemblyDetails.routeName,
                name: CreatePartSubAssemblyDetails.routeName,
                builder: (context, state) {
                  return const CreatePartSubAssemblyDetails();
                }),
            GoRoute(
                path: PartSubAssemblyDetailsTable.routeName,
                name: PartSubAssemblyDetailsTable.routeName,
                builder: (context, state) {
                  return const PartSubAssemblyDetailsTable();
                }),
            GoRoute(
                path: CreatePartSubAssemblyProcessing.routeName,
                name: CreatePartSubAssemblyProcessing.routeName,
                builder: (context, state) {
                  return const CreatePartSubAssemblyProcessing();
                }),
            GoRoute(
                path: PartSubAssemblyDetailsMasterTable.routeName,
                name: PartSubAssemblyDetailsMasterTable.routeName,
                builder: (context, state) {
                  return const PartSubAssemblyDetailsMasterTable();
                }),
            GoRoute(
                path: PartSubAssemblyProcessingTable.routeName,
                name: PartSubAssemblyProcessingTable.routeName,
                builder: (context, state) {
                  return const PartSubAssemblyProcessingTable();
                }),
          ]),

      // PRODUCT BREAKUP

      GoRoute(
          path: ProductBreakupByMatno.routeName,
          name: ProductBreakupByMatno.routeName,
          builder: (context, state) {
            return const ProductBreakupByMatno();
          },
          routes: [
            GoRoute(
                path: ProductBreakupDetails.routeName,
                name: ProductBreakupDetails.routeName,
                builder: (context, state) {
                  return const ProductBreakupDetails();
                }),
            GoRoute(
                path: CreateProductBreakupDetails.routeName,
                name: CreateProductBreakupDetails.routeName,
                builder: (context, state) {
                  return const CreateProductBreakupDetails();
                }),
            GoRoute(
                path: ProductBreakupDetailsTable.routeName,
                name: ProductBreakupDetailsTable.routeName,
                builder: (context, state) {
                  return const ProductBreakupDetailsTable();
                }),
            GoRoute(
                path: CreateProductBreakupProcessing.routeName,
                name: CreateProductBreakupProcessing.routeName,
                builder: (context, state) {
                  return const CreateProductBreakupProcessing();
                }),
            GoRoute(
                path: ProductBreakupDetailsMasterTable.routeName,
                name: ProductBreakupDetailsMasterTable.routeName,
                builder: (context, state) {
                  return const ProductBreakupDetailsMasterTable();
                }),
            GoRoute(
                path: ProductBreakupProcessingTable.routeName,
                name: ProductBreakupProcessingTable.routeName,
                builder: (context, state) {
                  return const ProductBreakupProcessingTable();
                }),
          ]),
      GoRoute(
          path: HoldDeniedOrderReport.routeName,
          name: HoldDeniedOrderReport.routeName,
          builder: (context, state) {
            return const HoldDeniedOrderReport();
          }),
      GoRoute(
          path: AddProductBreakupTechDetails.routeName,
          name: AddProductBreakupTechDetails.routeName,
          builder: (context, state) {
            return const AddProductBreakupTechDetails();
          }),
      GoRoute(
          path: AddProductFinalStandard.routeName,
          name: AddProductFinalStandard.routeName,
          builder: (context, state) {
            return const AddProductFinalStandard();
          }),

      GoRoute(
          path: AddJournalVoucher.routeName,
          name: AddJournalVoucher.routeName,
          builder: (context, state) {
            return const AddJournalVoucher();
          },
          routes: [
            GoRoute(
                path: JournalVoucherReportForm.routeName,
                name: JournalVoucherReportForm.routeName,
                builder: (context, state) {
                  return const JournalVoucherReportForm();
                }),
            GoRoute(
                path: JournalVoucherReport.routeName,
                name: JournalVoucherReport.routeName,
                builder: (context, state) {
                  return const JournalVoucherReport();
                }),
          ]),
      GoRoute(
          path: AddHsn.routeName,
          name: AddHsn.routeName,
          builder: (context, state) {
            return AddHsn(editing: state.uri.queryParameters["editing"] ?? '');
          },
          routes: [
            GoRoute(
                path: GetHsn.routeName,
                name: GetHsn.routeName,
                builder: (context, state) {
                  return const GetHsn();
                }),
            GoRoute(
                path: HsnReport.routeName,
                name: HsnReport.routeName,
                builder: (context, state) {
                  return const HsnReport();
                }),
            GoRoute(
                path: AcGroupsReport.routeName,
                name: AcGroupsReport.routeName,
                builder: (context, state) {
                  return const AcGroupsReport();
                }),
          ]),
      GoRoute(
          path: AddPaymentClear.routeName,
          name: AddPaymentClear.routeName,
          builder: (context, state) {
            return AddPaymentClear(
                details: state.uri.queryParameters['details'] ?? "");
          },
          routes: [
            GoRoute(
                path: PaymentAdvancePending.routeName,
                name: PaymentAdvancePending.routeName,
                builder: (context, state) {
                  return const PaymentAdvancePending();
                }),
            GoRoute(
                path: UnadjustedPaymentPending.routeName,
                name: UnadjustedPaymentPending.routeName,
                builder: (context, state) {
                  return const UnadjustedPaymentPending();
                }),
          ]),
      GoRoute(
          path: AddSaleTransfer.routeName,
          name: AddSaleTransfer.routeName,
          builder: (context, state) {
            return AddSaleTransfer(
                details: state.uri.queryParameters['details'] ?? "");
          },
          routes: [
            GoRoute(
                path: AddSaleTransferClear.routeName,
                name: AddSaleTransferClear.routeName,
                builder: (context, state) {
                  return AddSaleTransferClear(
                      details: state.uri.queryParameters['details'] ?? "");
                }),
            GoRoute(
                path: SalePaymentPendingReportForm.routeName,
                name: SalePaymentPendingReportForm.routeName,
                builder: (context, state) {
                  return const SalePaymentPendingReportForm();
                }),
            GoRoute(
                path: SalePaymentPendingReport.routeName,
                name: SalePaymentPendingReport.routeName,
                builder: (context, state) {
                  return const SalePaymentPendingReport();
                }),
          ]),
      GoRoute(
          path: AddPurchaseTransfer.routeName,
          name: AddPurchaseTransfer.routeName,
          builder: (context, state) {
            return AddPurchaseTransfer(
                details: state.uri.queryParameters['details'] ?? "");
          },
          routes: [
            GoRoute(
                path: AddPurchaseTransferClear.routeName,
                name: AddPurchaseTransferClear.routeName,
                builder: (context, state) {
                  return AddPurchaseTransferClear(
                      details: state.uri.queryParameters['details'] ?? "");
                }),
            GoRoute(
                path: PurchaseBillPendingReportForm.routeName,
                name: PurchaseBillPendingReportForm.routeName,
                builder: (context, state) {
                  return const PurchaseBillPendingReportForm();
                }),
            GoRoute(
                path: PurchaseBillPendingReport.routeName,
                name: PurchaseBillPendingReport.routeName,
                builder: (context, state) {
                  return const PurchaseBillPendingReport();
                }),
          ]),
      GoRoute(
          path: AddPaymentInward.routeName,
          name: AddPaymentInward.routeName,
          builder: (context, state) {
            return const AddPaymentInward();
          },
          routes: [
            GoRoute(
                path: AddCrNoteClear.routeName,
                name: AddCrNoteClear.routeName,
                builder: (context, state) {
                  return AddCrNoteClear(
                      details: state.uri.queryParameters['details'] ?? "");
                }),
            GoRoute(
                path: UnadjustedPaymentInward.routeName,
                name: UnadjustedPaymentInward.routeName,
                builder: (context, state) {
                  return const UnadjustedPaymentInward();
                }),
          ]),
      GoRoute(
          path: PaymentPendingReportForm.routeName,
          name: PaymentPendingReportForm.routeName,
          builder: (context, state) {
            return const PaymentPendingReportForm();
          },
          routes: [
            GoRoute(
                path: PaymentPendingReport.routeName,
                name: PaymentPendingReport.routeName,
                builder: (context, state) {
                  return const PaymentPendingReport();
                }),
          ]),
      GoRoute(
          path: AddWorkProcess.routeName,
          name: AddWorkProcess.routeName,
          builder: (context, state) {
            return AddWorkProcess(
                editing: state.uri.queryParameters["editing"] ?? '');
          },
          routes: [
            GoRoute(
                path: GetWorkProcess.routeName,
                name: GetWorkProcess.routeName,
                builder: (context, state) {
                  return const GetWorkProcess();
                }),
            GoRoute(
                path: WorkProcessReport.routeName,
                name: WorkProcessReport.routeName,
                builder: (context, state) {
                  return const WorkProcessReport();
                }),
          ]),
      GoRoute(
          path: AddCostResource.routeName,
          name: AddCostResource.routeName,
          builder: (context, state) {
            return AddCostResource(
                editing: state.uri.queryParameters["editing"] ?? '');
          },
          routes: [
            GoRoute(
                path: GetCostResource.routeName,
                name: GetCostResource.routeName,
                builder: (context, state) {
                  return const GetCostResource();
                }),
            GoRoute(
                path: CostResourceReport.routeName,
                name: CostResourceReport.routeName,
                builder: (context, state) {
                  return const CostResourceReport();
                }),
          ]),
      GoRoute(
          path: AddMaterialIncomingStandard.routeName,
          name: AddMaterialIncomingStandard.routeName,
          builder: (context, state) {
            return const AddMaterialIncomingStandard();
          },
          routes: [
            GoRoute(
                path: MaterialIncomingStandardReport.routeName,
                name: MaterialIncomingStandardReport.routeName,
                builder: (context, state) {
                  return const MaterialIncomingStandardReport();
                }),
          ]),
      GoRoute(
          path: ExportEwayBillSale.routeName,
          name: ExportEwayBillSale.routeName,
          builder: (context, state) {
            return const ExportEwayBillSale();
          }),
      GoRoute(
          path: AddManufacturing.routeName,
          name: AddManufacturing.routeName,
          builder: (context, state) {
            return const AddManufacturing();
          },
          routes: [
            GoRoute(
                path: ManufacturingReportForm.routeName,
                name: ManufacturingReportForm.routeName,
                builder: (context, state) {
                  return const ManufacturingReportForm();
                }),
            GoRoute(
                path: ManufacturingReport.routeName,
                name: ManufacturingReport.routeName,
                builder: (context, state) {
                  return const ManufacturingReport();
                }),
          ]),
      GoRoute(
          path: AddJobWorkOutDetails.routeName,
          name: AddJobWorkOutDetails.routeName,
          builder: (context, state) {
            return const AddJobWorkOutDetails();
          }),
      GoRoute(
          path: AddJobWorkOut.routeName,
          name: AddJobWorkOut.routeName,
          builder: (context, state) {
            return const AddJobWorkOut();
          }, routes: [
        GoRoute(
            path: JobWorkoutReportForm.routeName,
            name: JobWorkoutReportForm.routeName,
            builder: (context, state) {
              return const JobWorkoutReportForm();
            }),
        GoRoute(
            path: JobWorkoutReport.routeName,
            name: JobWorkoutReport.routeName,
            builder: (context, state) {
              return const JobWorkoutReport();
            }),
      ]),
      GoRoute(
          path: AddReq.routeName,
          name: AddReq.routeName,
          builder: (context, state) {
            return const AddReq();
          }),
      GoRoute(
          path: AddReqDetails.routeName,
          name: AddReqDetails.routeName,
          builder: (context, state) {
            return const AddReqDetails();
          }),
      GoRoute(
          path: AddReqProduction.routeName,
          name: AddReqProduction.routeName,
          builder: (context, state) {
            return AddReqProduction(
                details: state.uri.queryParameters['details'] ?? "");
          },
          routes: [
            GoRoute(
                path: ReqProductionPending.routeName,
                name: ReqProductionPending.routeName,
                builder: (context, state) {
                  return const ReqProductionPending();
                }),
          ]),
      GoRoute(
          path: AddReqPacking.routeName,
          name: AddReqPacking.routeName,
          builder: (context, state) {
            return AddReqPacking(
                details: state.uri.queryParameters['details'] ?? "");
          },
          routes: [
            GoRoute(
                path: ReqPackingPending.routeName,
                name: ReqPackingPending.routeName,
                builder: (context, state) {
                  return const ReqPackingPending();
                }),
          ]),
      GoRoute(
          path: AddReqPacked.routeName,
          name: AddReqPacked.routeName,
          builder: (context, state) {
            return AddReqPacked(
                details: state.uri.queryParameters['details'] ?? "");
          },
          routes: [
            GoRoute(
                path: ReqPackedPending.routeName,
                name: ReqPackedPending.routeName,
                builder: (context, state) {
                  return const ReqPackedPending();
                }),
          ]),
      GoRoute(
          path: AddReqIssue.routeName,
          name: AddReqIssue.routeName,
          builder: (context, state) {
            return AddReqIssue(reqId: state.uri.queryParameters['reqId'] ?? "");
          },
          routes: [
            GoRoute(
                path: ReqIssuePending.routeName,
                name: ReqIssuePending.routeName,
                builder: (context, state) {
                  return const ReqIssuePending();
                })
          ]),
      GoRoute(
          path: AddDlChallan.routeName,
          name: AddDlChallan.routeName,
          builder: (context, state) {
            return const AddDlChallan();
          }, routes: [
        GoRoute(
            path: DlChallanReportForm.routeName,
            name: DlChallanReportForm.routeName,
            builder: (context, state) {
              return const DlChallanReportForm();
            }),
        GoRoute(
            path: DlChallanReport.routeName,
            name: DlChallanReport.routeName,
            builder: (context, state) {
              return const DlChallanReport();
            }),
      ]),
      GoRoute(
          path: AddJobWorkOutChallanClear.routeName,
          name: AddJobWorkOutChallanClear.routeName,
          builder: (context, state) {
            return const AddJobWorkOutChallanClear();
          }),
      GoRoute(
          path: AddProductionPlan.routeName,
          name: AddProductionPlan.routeName,
          builder: (context, state) {
            return const AddProductionPlan();
          }, routes: [
        GoRoute(
            path: DeleteProductionPlan.routeName,
            name: DeleteProductionPlan.routeName,
            builder: (context, state) {
              return const DeleteProductionPlan();
            }),
      ]),
      GoRoute(
          path: AddProductionPlanA.routeName,
          name: AddProductionPlanA.routeName,
          builder: (context, state) {
            return const AddProductionPlanA();
          }),
      GoRoute(
          path: AddLineRejection.routeName,
          name: AddLineRejection.routeName,
          builder: (context, state) {
            return const AddLineRejection();
          }),
      GoRoute(
          path: AddMaterialReturn.routeName,
          name: AddMaterialReturn.routeName,
          builder: (context, state) {
            return const AddMaterialReturn();
          })
    ],
  );
}
