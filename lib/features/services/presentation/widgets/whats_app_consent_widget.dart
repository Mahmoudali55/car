import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class WhatsAppConsentWidget extends StatefulWidget {
  const WhatsAppConsentWidget({super.key});

  @override
  State<WhatsAppConsentWidget> createState() => _WhatsAppConsentWidgetState();
}

class _WhatsAppConsentWidgetState extends State<WhatsAppConsentWidget> {
  @override
  bool _whatsappConsent = true;
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _whatsappConsent = !_whatsappConsent),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 22.w,
            height: 22.w,
            decoration: BoxDecoration(
              color: _whatsappConsent ? AppColor.primaryColor(context) : Colors.transparent,
              borderRadius: BorderRadius.circular(5.r),
              border: Border.all(
                color: _whatsappConsent
                    ? AppColor.primaryColor(context)
                    : AppColor.borderColor(context),
                width: 1.5,
              ),
            ),
            child: _whatsappConsent
                ? Icon(Icons.check_rounded, color: AppColor.whiteColor(context), size: 14.sp)
                : null,
          ),
          Gap(10.w),
          Icon(Icons.phone, color: AppColor.greenColor(context), size: 20.sp),
          Gap(6.w),
          Expanded(
            child: Text(
              AppLocaleKey.agentWhatsAppNotification.tr(),
              style: AppTextStyle.bodySmall(
                context,
              ).copyWith(color: AppColor.blackTextColor(context).withValues(alpha: 0.75)),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
