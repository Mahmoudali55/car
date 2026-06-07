import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TranslateIconWidget extends StatefulWidget {
  const TranslateIconWidget({super.key});

  @override
  State<TranslateIconWidget> createState() => _TranslateIconWidgetState();
}

class _TranslateIconWidgetState extends State<TranslateIconWidget> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColor.greyColor(context).withValues(alpha: 0.1),
      child: IconButton(
        onPressed: () async {
          final newLocale = context.locale.languageCode == 'ar'
              ? const Locale('en')
              : const Locale('ar');
          await context.setLocale(newLocale);
          HiveMethods.updateLang(newLocale);
          if (mounted) setState(() {});
        },
        icon: Icon(Icons.translate_rounded, color: AppColor.blackTextColor(context), size: 20.sp),
      ),
    );
  }
}
