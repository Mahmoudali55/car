import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/agent/data/model/customer_model.dart';
import 'package:car/features/agent/presentation/screens/widget/action_card_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/address_item_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/header_profile_card.dart';
import 'package:car/features/agent/presentation/screens/widget/info_row_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

class AgentCustomerDetailsScreen extends StatelessWidget {
  const AgentCustomerDetailsScreen({super.key, required this.customer});
  final CustomerModel customer;
  Future<void> _makeCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }
  Future<void> _launchWhatsApp(String phoneNumber) async {
    final Uri whatsappUri = Uri.parse("https://wa.me/$phoneNumber");
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: CustomAppBar(
        context,
        title: Text(
          AppLocaleKey.agentCustomerDetails.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            /// Header Profile Card
            HeaderProfileCard(customer: customer),
            Gap(24.h),
            Row(
              children: [
                Expanded(
                  child: ActionCard(
                    icon: Icons.call_rounded,
                    title: AppLocaleKey.call.tr(),
                    onTap: () => _makeCall(customer.tel1 ?? ""),
                  ),
                ),
                Gap(12.w),
                Expanded(
                  child: ActionCard(
                    icon: Icons.chat_rounded,
                    title: AppLocaleKey.whatsapp.tr(),
                    onTap: () => _launchWhatsApp(customer.tel1 ?? ""),
                  ),
                ),
              ],
            ),
            Gap(24.h),
            /// Financial Summary
            _sectionTitle(AppLocaleKey.agentFinancialSummary.tr()),
            Gap(12.h),
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: AppColor.cardColor(context),
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(color: AppColor.borderColor(context).withValues(alpha: .1)),
              ),
              child: Column(
                children: [
                  InfoRowWidget(
                    label: AppLocaleKey.agentCurrentBalance.tr(),
                    value: "${customer.formattedBalance} ${AppLocaleKey.sar.tr()}",
                    isBold: true,
                    color: Colors.green,
                  ),
                  const Divider(height: 30),
                  InfoRowWidget(
                    label: AppLocaleKey.agentCreditLimit.tr(),
                    value: "${customer.creditLimit ?? 0.0} ${AppLocaleKey.sar.tr()}",
                  ),
                  Gap(12.h),
                  InfoRowWidget(
                    label: AppLocaleKey.agentCurrency.tr(),
                    value: customer.currencyName ?? AppLocaleKey.currencyRiyal.tr(),
                  ),
                ],
              ),
            ),
            Gap(24.h),
            /// Contact Info
            _sectionTitle(AppLocaleKey.agentContactInformation.tr()),
            Gap(12.h),
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: AppColor.cardColor(context),
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(color: AppColor.borderColor(context).withValues(alpha: .1)),
              ),
              child: Column(
                children: [
                  InfoRowWidget(
                    label: AppLocaleKey.agentMobile1.tr(),
                    value: customer.tel1 ?? '---',
                  ),
                  if (customer.tel2?.isNotEmpty ?? false) ...[
                    const Divider(height: 30),
                    InfoRowWidget(label: AppLocaleKey.agentMobile2.tr(), value: customer.tel2!),
                  ],
                  if (customer.tel3?.isNotEmpty ?? false) ...[
                    const Divider(height: 30),
                    InfoRowWidget(label: AppLocaleKey.agentMobile3.tr(), value: customer.tel3!),
                  ],
                  if (customer.fax?.isNotEmpty ?? false) ...[
                    const Divider(height: 30),
                    InfoRowWidget(label: AppLocaleKey.agentFax.tr(), value: customer.fax!),
                  ],
                ],
              ),
            ),
            Gap(24.h),
            /// Address Details
            _sectionTitle(AppLocaleKey.agentAddress.tr()),
            Gap(12.h),
            Container(
              padding: EdgeInsets.all(20.w),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.cardColor(context),
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(color: AppColor.borderColor(context).withValues(alpha: .1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AddressItemWidget(
                    icon: Icons.location_on_rounded,
                    label: AppLocaleKey.agentFullAddress.tr(),
                    value: customer.fullAddress,
                  ),
                  const Divider(height: 30),
                  AddressItemWidget(
                    icon: Icons.map_rounded,
                    label: AppLocaleKey.agentAreaCity.tr(),
                    value: "${customer.areaName ?? '---'} / ${customer.cityName ?? '---'}",
                  ),
                ],
              ),
            ),

            if (customer.notes?.isNotEmpty ?? false) ...[
              Gap(24.h),
              _sectionTitle(AppLocaleKey.agentNotesTitle.tr()),
              Gap(12.h),
              Container(
                padding: EdgeInsets.all(20.w),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.cardColor(context),
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(color: AppColor.borderColor(context).withValues(alpha: .1)),
                ),
                child: Text(
                  customer.notes!,
                  style: AppTextStyle.bodyMedium(
                    context,
                  ).copyWith(color: AppColor.greyColor(context), height: 1.5),
                ),
              ),
            ],

            Gap(40.h),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        title,
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800),
      ),
    );
  }
}
