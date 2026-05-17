import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SecurityLockWrapper extends StatefulWidget {
  final Widget child;

  const SecurityLockWrapper({super.key, required this.child});

  @override
  State<SecurityLockWrapper> createState() => _SecurityLockWrapperState();
}

class _SecurityLockWrapperState extends State<SecurityLockWrapper> {
  bool _isCompromised = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkDeviceSecurity();
  }

  Future<void> _checkDeviceSecurity() async {
    try {
      // Perform security check
      final bool jailbroken = await FlutterJailbreakDetection.jailbroken;

      if (mounted) {
        setState(() {
          _isCompromised = jailbroken;
          _isLoading = false;
        });
      }
    } catch (_) {
      // In case checking fails, default to safe to prevent blocking users
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: AppColor.whiteColor(context))),
      );
    }

    if (!_isCompromised) {
      return widget.child;
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0F0000), // Premium very deep red-black color
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Premium Glowing Shield Alert Icon
              Container(
                width: 150.r,
                height: 150.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.redColor(context).withValues(alpha: 0.08),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.redColor(context).withValues(alpha: 0.15),
                      blurRadius: 40,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.security_update_warning_rounded,
                  color: AppColor.redColor(context),
                  size: 80.r,
                ),
              ),
              Gap(40.h),

              // Security Title
              Text(
                AppLocaleKey.securityCompromisedTitle.tr(),
                style: AppTextStyle.formTitleStyle(context).copyWith(
                  color: AppColor.whiteColor(context),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
              Gap(16.h),

              // Security Warning Description
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Text(
                  AppLocaleKey.securityCompromisedDesc.tr(),
                  style: AppTextStyle.bodyMedium(context).copyWith(
                    color: AppColor.whiteColor(context).withValues(alpha: 0.7),
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const Spacer(),

              // Security Alert Tag
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: AppColor.redColor(context).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: AppColor.redColor(context).withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.gpp_bad_rounded, color: AppColor.redColor(context), size: 18.sp),
                    Gap(8.w),
                    Text(
                      AppLocaleKey.securityAlert.tr().toUpperCase(),
                      style: AppTextStyle.bodySmall(
                        context,
                      ).copyWith(color: AppColor.redColor(context), fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              Gap(40.h),
            ],
          ),
        ),
      ),
    );
  }
}
