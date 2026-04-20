import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportIconWidget extends StatelessWidget {
  const SupportIconWidget({super.key});

  void _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 25.r,
        backgroundColor: AppColor.primaryColor(context),
        child: IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) => _buildContactBottomSheet(context),
            );
          },
          icon: Icon(
            Icons.headset_mic_rounded,
            color: Colors.white,
            size: 24.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildContactBottomSheet(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: AppColor.greyColor(context).withOpacity(0.3),
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          Gap(20.h),
          Text(
            AppLocaleKey.contactSupport.tr(),
            style: AppTextStyle.titleLarge(context).copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          Gap(10.h),
          Text(
            AppLocaleKey.weAreHereToHelp.tr(),
            style: AppTextStyle.bodySmall(context).copyWith(
              color: AppColor.greyColor(context),
            ),
          ),
          Gap(30.h),
          _buildContactButton(
            context,
            icon: Icons.phone_in_talk_rounded,
            title: AppLocaleKey.callUs.tr(),
            subtitle: '+1 234 567 890',
            color: AppColor.primaryColor(context),
            onTap: () => _launchUrl('tel:+1234567890'),
          ),
          Gap(15.h),
          _buildContactButton(
            context,
            icon: Icons.chat_rounded,
            title: AppLocaleKey.whatsapp.tr(),
            subtitle: 'Chat with our team',
            color: const Color(0xFF25D366),
            onTap: () => _launchUrl('https://wa.me/+1234567890'),
          ),
          Gap(20.h),
        ],
      ),
    );
  }

  Widget _buildContactButton(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 24.sp),
            ),
            Gap(15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyle.titleMedium(context).copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColor.blackTextColor(context),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTextStyle.bodySmall(context).copyWith(
                      color: AppColor.greyColor(context),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16.sp,
              color: AppColor.greyColor(context),
            ),
          ],
        ),
      ),
    );
  }
}
