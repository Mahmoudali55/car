import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/custom_widgets/custom_loading/custom_loading.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/agent/data/model/customer_model.dart';
import 'package:car/features/agent/data/model/customer_profile_model.dart';
import 'package:car/features/agent/presentation/cubit/agent_cubit.dart';
import 'package:car/features/agent/presentation/cubit/agent_state.dart';
import 'package:car/features/agent/presentation/screens/widget/action_card_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/address_item_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/header_profile_card.dart';
import 'package:car/features/agent/presentation/screens/widget/info_row_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

class AgentCustomerDetailsScreen extends StatefulWidget {
  const AgentCustomerDetailsScreen({super.key, required this.customer});
  final CustomerModel customer;

  @override
  State<AgentCustomerDetailsScreen> createState() => _AgentCustomerDetailsScreenState();
}

class _AgentCustomerDetailsScreenState extends State<AgentCustomerDetailsScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.customer.customerNo != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<AgentCubit>().getCustomerProfile(widget.customer.customerNo.toString());
      });
    }
  }

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
    final isArabic = context.locale.languageCode == 'ar';

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
      body: BlocBuilder<AgentCubit, AgentState>(
        builder: (context, state) {
          final profileStatus = state.customerProfileStatus;
          final CustomerProfileModel? profile = profileStatus.data;

          final customerName = profile?.displayName.isNotEmpty == true
              ? profile!.displayName
              : (widget.customer.customerName ?? '');
          final tel1 = (profile?.tel1?.isNotEmpty == true)
              ? profile!.tel1!
              : (widget.customer.tel1 ?? '');
          final balanceStr = profile != null
              ? profile.formattedBalance
              : widget.customer.formattedBalance;
          final creditLimitVal = profile?.creditLimit ?? widget.customer.creditLimit ?? 0.0;
          final currencyStr = profile?.currencyName ?? widget.customer.currencyName ?? AppLocaleKey.currencyRiyal.tr();
          final areaStr = profile?.areaName ?? widget.customer.areaName ?? '---';
          final cityStr = profile?.cityName ?? widget.customer.cityName ?? '---';
          final addressStr = (profile?.address?.isNotEmpty == true)
              ? profile!.address!
              : widget.customer.fullAddress;
          final taxNo = profile?.custTaxNo ?? widget.customer.custTaxNo;
          final tradeName = profile?.tradeName ?? widget.customer.tradeName;
          final notes = profile?.notes ?? widget.customer.notes;

          return SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                if (profileStatus.isLoading)
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: const CustomLoading(),
                  ),

                /// Header Profile Card
                HeaderProfileCard(customer: widget.customer),
                Gap(24.h),

                Row(
                  children: [
                    Expanded(
                      child: ActionCard(
                        icon: Icons.call_rounded,
                        title: AppLocaleKey.call.tr(),
                        onTap: () => _makeCall(tel1),
                      ),
                    ),
                    Gap(12.w),
                    Expanded(
                      child: ActionCard(
                        icon: Icons.chat_rounded,
                        title: AppLocaleKey.whatsapp.tr(),
                        onTap: () => _launchWhatsApp(tel1),
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
                        value: "$balanceStr ${AppLocaleKey.sar.tr()}",
                        isBold: true,
                        color: Colors.green,
                      ),
                      const Divider(height: 30),
                      InfoRowWidget(
                        label: AppLocaleKey.agentCreditLimit.tr(),
                        value: "$creditLimitVal ${AppLocaleKey.sar.tr()}",
                      ),
                      Gap(12.h),
                      InfoRowWidget(
                        label: AppLocaleKey.agentCurrency.tr(),
                        value: currencyStr,
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
                        label: isArabic ? 'اسم العميل' : 'Customer Name',
                        value: customerName.isNotEmpty ? customerName : '---',
                      ),
                      const Divider(height: 30),
                      InfoRowWidget(
                        label: AppLocaleKey.agentMobile1.tr(),
                        value: tel1.isNotEmpty ? tel1 : '---',
                      ),
                      if ((profile?.tel2 ?? widget.customer.tel2)?.isNotEmpty ?? false) ...[
                        const Divider(height: 30),
                        InfoRowWidget(
                          label: AppLocaleKey.agentMobile2.tr(),
                          value: (profile?.tel2 ?? widget.customer.tel2)!,
                        ),
                      ],
                      if ((profile?.tel3 ?? widget.customer.tel3)?.isNotEmpty ?? false) ...[
                        const Divider(height: 30),
                        InfoRowWidget(
                          label: AppLocaleKey.agentMobile3.tr(),
                          value: (profile?.tel3 ?? widget.customer.tel3)!,
                        ),
                      ],
                      if ((profile?.fax ?? widget.customer.fax)?.isNotEmpty ?? false) ...[
                        const Divider(height: 30),
                        InfoRowWidget(
                          label: AppLocaleKey.agentFax.tr(),
                          value: (profile?.fax ?? widget.customer.fax)!,
                        ),
                      ],
                      if (taxNo?.isNotEmpty ?? false) ...[
                        const Divider(height: 30),
                        InfoRowWidget(
                          label: isArabic ? 'الرقم الضريبي' : 'Tax Number',
                          value: taxNo!,
                        ),
                      ],
                      if (tradeName?.isNotEmpty ?? false) ...[
                        const Divider(height: 30),
                        InfoRowWidget(
                          label: isArabic ? 'الاسم التجاري' : 'Trade Name',
                          value: tradeName!,
                        ),
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
                        value: addressStr.isNotEmpty ? addressStr : '---',
                      ),
                      const Divider(height: 30),
                      AddressItemWidget(
                        icon: Icons.map_rounded,
                        label: AppLocaleKey.agentAreaCity.tr(),
                        value: "$areaStr / $cityStr",
                      ),
                    ],
                  ),
                ),

                if (notes?.isNotEmpty ?? false) ...[
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
                      notes!,
                      style: AppTextStyle.bodyMedium(
                        context,
                      ).copyWith(color: AppColor.greyColor(context), height: 1.5),
                    ),
                  ),
                ],

                Gap(40.h),
              ],
            ),
          );
        },
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
