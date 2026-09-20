import 'package:car/core/custom_widgets/developer_contact_bottom_sheet.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CopyrightWidget extends StatefulWidget {
  final Color? textColor;
  final Color? linkColor;
  final double? fontSize;

  const CopyrightWidget({super.key, this.textColor, this.linkColor, this.fontSize});

  @override
  State<CopyrightWidget> createState() => _CopyrightWidgetState();
}

class _CopyrightWidgetState extends State<CopyrightWidget> {
  late TapGestureRecognizer _tapGestureRecognizer;

  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer()..onTap = _onDeveloperTap;
  }

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  void _onDeveloperTap() {
    showDeveloperContactBottomSheet(context);
  }

  @override
  Widget build(BuildContext context) {
    final defaultStyle = AppTextStyle.bodySmall(context).copyWith(
      fontSize: widget.fontSize ?? 8.sp,
      color: widget.textColor ?? AppColor.blackTextColor(context).withValues(alpha: 0.6),
    );

    final linkStyle = defaultStyle.copyWith(
      color: widget.linkColor ?? AppColor.primaryColor(context),
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline,
      decorationColor: widget.linkColor ?? AppColor.primaryColor(context),
    );

    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(text: '© 2026-'),
          TextSpan(text: 'Delta ASG', style: linkStyle, recognizer: _tapGestureRecognizer),
          const TextSpan(text: '. All rights reserved. Copyright/Trademarks'),
        ],
      ),
      textAlign: TextAlign.center,
      style: defaultStyle,
    );
  }
}
