import 'package:animate_do/animate_do.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactItemWidget extends StatelessWidget {
  const ContactItemWidget({super.key, required this.value, required this.icon});
  final String value;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        decoration: BoxDecoration(
          color: AppColor.secondAppColor(context),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: 0.05)),
        ),
        child: ListTile(
          dense: true,
          leading: Icon(
            icon,
            color: AppColor.blackTextColor(context).withValues(alpha: 0.6),
            size: 18.sp,
          ),
          title: Text(
            value,
            style: TextStyle(
              color: AppColor.blackTextColor(context),
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
          trailing: Icon(
            Icons.copy_rounded,
            color: AppColor.blackTextColor(context).withValues(alpha: 0.2),
            size: 16.sp,
          ),
          onTap: () {
            Clipboard.setData(ClipboardData(text: value));
            BotToast.showText(
              text: context.locale.languageCode == 'ar' ? 'تم النسخ' : 'Copied',
              duration: const Duration(seconds: 2),
            );
          },
        ),
      ),
    );
  }
}
