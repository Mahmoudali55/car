import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  const FAQItem({super.key, required this.question, required this.answer});

  @override
  State<FAQItem> createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final baseColor = AppColor.blackTextColor(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: baseColor.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: _isExpanded
              ? AppColor.primaryColor(context).withValues(alpha: 0.2)
              : baseColor.withValues(alpha: 0.05),
        ),
      ),
      child: Column(
        children: [
          ListTile(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            title: Text(
              widget.question,
              style: AppTextStyle.bodyMedium(context).copyWith(
                color: baseColor,
                fontWeight: _isExpanded ? FontWeight.bold : FontWeight.w600,
              ),
            ),
            trailing: AnimatedRotation(
              turns: _isExpanded ? 0.5 : 0,
              duration: const Duration(milliseconds: 300),
              child: Icon(
                _isExpanded
                    ? Icons.remove_circle_outline_rounded
                    : Icons.add_circle_outline_rounded,
                color: _isExpanded
                    ? AppColor.primaryColor(context)
                    : baseColor.withValues(alpha: 0.3),
                size: 24.sp,
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
              child: Text(
                widget.answer,
                style: AppTextStyle.bodySmall(
                  context,
                ).copyWith(color: baseColor.withValues(alpha: 0.6), height: 1.6),
              ),
            ),
            crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}
