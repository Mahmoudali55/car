import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class BuyingFaqSection extends StatelessWidget {
  const BuyingFaqSection({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = [
      {
        'question': 'هل شركة سيارة هي الممول لسيارات الأقساط؟',
        'answer': 'شركة سيارة توفر لك السيارة وتقوم بإنهاء كافة الإجراءات بدءاً من رفع أوراقك لجهات التمويل إلى أن تستلم سيارتك لكن التمويل يتم من خلال البنوك وشركات التمويل.',
      },
      {
        'question': 'هل أقدر أختار مبلغ القسط الشهري أو مدة التقسيط؟',
        'answer': 'نعم، يمكنك تخصيص القسط والمدة بما يتناسب مع ميزانيتك من خلال خيارات جهات التمويل المتاحة.',
      },
      {
        'question': 'هل التمويل متوافق مع الشريعة الإسلامية؟',
        'answer': 'جميع جهات التمويل التي نتعامل معها حاصلة على شهادات توافق مع الشريعة الإسلامية.',
      },
      {
        'question': 'هل يمكنني تقديم الطلب في حالة وجود مخالفات؟',
        'answer': 'نعم، المخالفات المرورية لا تمنعك من تقديم الطلب، ولكن قد تؤثر على نسبة التمويل القصوى المسموح بها.',
      },
      {
        'question': 'هل يشترط وجود دفعة أولى؟',
        'answer': 'يعتمد ذلك على جهة التمويل وسجلك الائتماني، حيث تتوفر بعض العروض بـ 0% دفعة أولى.',
      },
      {
        'question': 'هل يشترط وجود دفعة أخيرة؟',
        'answer': 'نعم، تتوفر برامج تمويل بوجود دفعة أخيرة لتقليل القسط الشهري، ويمكن تقسيطها لاحقاً.',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...faqs.map((faq) => Container(
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
                        color: AppColor.blackTextColor(context).withOpacity(0.6),
                        height: 1.6,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
