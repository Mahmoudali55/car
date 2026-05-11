import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuyingFaqSection extends StatelessWidget {
  const BuyingFaqSection({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = [
      {'question': AppLocaleKey.faqQuestion.tr(), 'answer': AppLocaleKey.faqAnswer.tr()},
      {'question': AppLocaleKey.faqQuestion2.tr(), 'answer': AppLocaleKey.faqAnswer2.tr()},
      {'question': AppLocaleKey.faqQuestion3.tr(), 'answer': AppLocaleKey.faqAnswer3.tr()},
      {'question': AppLocaleKey.faqQuestion4.tr(), 'answer': AppLocaleKey.faqAnswer4.tr()},
      {'question': AppLocaleKey.faqQuestion5.tr(), 'answer': AppLocaleKey.faqAnswer5.tr()},
      {'question': AppLocaleKey.faqQuestion6.tr(), 'answer': AppLocaleKey.faqAnswer6.tr()},
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...faqs.map(
          (faq) => Container(
            margin: EdgeInsets.only(bottom: 12.h),
            decoration: BoxDecoration(
              color: AppColor.cardColor(context),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColor.borderColor(context)),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                title: Text(
                  faq['question']!,
                  style: AppTextStyle.bodyMedium(context).copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                    color: const Color(0xFF0D47A1),
                  ),
                ),
                iconColor: const Color(0xFF0D47A1),
                collapsedIconColor: Colors.grey,
                childrenPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    faq['answer']!,
                    style: AppTextStyle.bodySmall(context).copyWith(
                      color: AppColor.blackTextColor(context).withValues(alpha: (0.6)),
                      height: 1.6,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
