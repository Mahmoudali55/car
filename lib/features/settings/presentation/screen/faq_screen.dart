import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = [
      {'q': AppLocaleKey.faqQ1, 'a': AppLocaleKey.faqA1},
      {'q': AppLocaleKey.faqQ2, 'a': AppLocaleKey.faqA2},
      {'q': AppLocaleKey.faqQ3, 'a': AppLocaleKey.faqA3},
      {'q': AppLocaleKey.faqQ4, 'a': AppLocaleKey.faqA4},
    ];

    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: CustomAppBar(
        context,
        title: Text(
          AppLocaleKey.faqs.tr(),
          style: AppTextStyle.titleMedium(
            context,
          ).copyWith(color: AppColor.blackTextColor(context), fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20.w),
        physics: const BouncingScrollPhysics(),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return FadeInUp(
            delay: Duration(milliseconds: 100 * index),
            child: _FAQItem(question: faqs[index]['q']!.tr(), answer: faqs[index]['a']!.tr()),
          );
        },
      ),
    );
  }
}

class _FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  const _FAQItem({required this.question, required this.answer});

  @override
  State<_FAQItem> createState() => _FAQItemState();
}

class _FAQItemState extends State<_FAQItem> {
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
