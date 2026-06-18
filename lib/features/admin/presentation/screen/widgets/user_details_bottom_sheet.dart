import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/admin/presentation/screen/widgets/custom_info_section_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class UserDetailsBottomSheet extends StatelessWidget {
  const UserDetailsBottomSheet({
    super.key,
    required this.name,
    required this.id,
    required this.roleLabel,
    required this.roleColor,
    this.phone,
    this.area,
    this.address,
    this.balance,
    this.notes,
    this.email,
  });

  final String name;
  final String id;
  final String roleLabel;
  final Color roleColor;
  final String? phone;
  final String? area;
  final String? address;
  final double? balance;
  final String? notes;
  final String? email;
  Future<void> makePhoneCall(String phoneNumber) async {
    if (phoneNumber.trim().isEmpty) return;

    final Uri uri = Uri.parse('tel:$phoneNumber');

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> shareUser() async {
    final text =
        '''
$name

${AppLocaleKey.code.tr()}: $id
${phone != null ? '${AppLocaleKey.phone.tr()}: $phone' : ''}
${area != null ? '${AppLocaleKey.area.tr()}: $area' : ''}
${address != null ? '${AppLocaleKey.address.tr()}: $address' : ''}
''';

    await SharePlus.instance.share(ShareParams(text: text));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.scaffoldColor(context),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Gap(12.h),
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: AppColor.blackTextColor(context).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          Gap(24.h),
          Row(
            children: [
              Container(
                width: 70.w,
                height: 70.w,
                decoration: BoxDecoration(
                  color: roleColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Icon(
                  roleLabel == AppLocaleKey.admins.tr()
                      ? Icons.storefront_rounded
                      : Icons.person_outline_rounded,
                  color: roleColor,
                  size: 32.sp,
                ),
              ),
              Gap(16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppTextStyle.titleMedium(context).copyWith(
                        color: AppColor.blackTextColor(context),
                        fontWeight: FontWeight.w900,
                        fontSize: 20.sp,
                      ),
                    ),
                    Gap(4.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: roleColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        roleLabel,
                        style: AppTextStyle.bodySmall(
                          context,
                        ).copyWith(color: roleColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Gap(32.h),
          CustomInfoSectionWidget(
            id: id,
            phone: phone,
            area: area,
            address: address,
            balance: balance,
            notes: notes,
          ),
          Gap(32.h),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  radius: 12.r,
                  onPressed: () async {
                    await makePhoneCall(phone ?? '');
                  },
                  text: AppLocaleKey.call.tr(),
                ),
              ),
              Gap(12.w),
              Container(
                decoration: BoxDecoration(
                  color: AppColor.whiteColor(context),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: AppColor.blackTextColor(context).withValues(alpha: 0.1),
                  ),
                ),
                child: IconButton(
                  onPressed: () async {
                    await shareUser();
                  },
                  icon: Icon(Icons.share_rounded, color: AppColor.blackTextColor(context)),
                ),
              ),
            ],
          ),
          Gap(40.h),
        ],
      ),
    );
  }
}
