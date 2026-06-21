import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/agent/presentation/screens/widget/quote_builder_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomGridViewExistSpecsWidget extends StatelessWidget {
  const CustomGridViewExistSpecsWidget({super.key, required this.widget});

  final QuoteBuilderDialog widget;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 2.5,
      ),
      itemCount: widget.existingSpecs.length,
      itemBuilder: (context, index) {
        final key = widget.existingSpecs.keys.elementAt(index);
        final value = widget.existingSpecs.values.elementAt(index);
        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          color: AppColor.greyColor(context).withValues(alpha: 0.05),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  key,
                  style: AppTextStyle.bodySmall(context).copyWith(
                    color: AppColor.blackTextColor(context).withValues(alpha: 0.4),
                    fontSize: 10.sp,
                  ),
                ),
                Gap(2.h),
                Text(
                  value,
                  style: AppTextStyle.bodySmall(
                    context,
                  ).copyWith(fontWeight: FontWeight.bold, color: AppColor.blackTextColor(context)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
