import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/agent/data/model/customer_model.dart';
import 'package:car/features/agent/presentation/screens/widget/custom_action_button_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/custom_customer_item_data_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomCustomerItemWidget extends StatelessWidget {
  const CustomCustomerItemWidget({
    super.key,
    required this.customerName,
    required this.phone,
    required this.customer,
  });
  final String customerName;
  final String phone;
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
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColor.borderColor(context).withValues(alpha: .2)),
        boxShadow: [
          BoxShadow(
            color: AppColor.blackColor(context).withValues(alpha: .03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(18.w),
        child: Column(
          children: [
            CustomCustomerItemDataWidget(customerName: customerName, phone: phone),
            if (customer.address?.isNotEmpty ?? false) ...[
              Gap(16.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: AppColor.scaffoldColor(context),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: AppColor.redColor(context),
                      size: 18.sp,
                    ),
                    Gap(8.w),
                    Expanded(
                      child: Text(
                        customer.address!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.bodySmall(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            Gap(16.h),
            Divider(height: 1, color: AppColor.borderColor(context).withValues(alpha: .2)),
            Gap(14.h),
            Row(
              children: [
                Expanded(
                  child: CustomActionButtonWidget(
                    icon: Icons.call_rounded,
                    title: AppLocaleKey.agentCall.tr(),
                    onTap: () => _makeCall(phone),
                  ),
                ),
                Gap(10.w),
                Expanded(
                  child: CustomActionButtonWidget(
                    icon: Icons.chat_rounded,
                    title: AppLocaleKey.agentWhatsapp.tr(),
                    onTap: () => _launchWhatsApp(phone),
                  ),
                ),
                Gap(10.w),
                Expanded(
                  child: CustomActionButtonWidget(
                    icon: Icons.person_outline,
                    title: AppLocaleKey.agentDetails.tr(),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RoutesName.agentCustomerDetailsScreen,
                        arguments: customer,
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
