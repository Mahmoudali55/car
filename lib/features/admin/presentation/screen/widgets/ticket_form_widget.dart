import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/admin/presentation/screen/widgets/drop_down_field_widget.dart';
import 'package:car/features/admin/presentation/screen/widgets/field_label_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class TicketFormWidget extends StatelessWidget {
  const TicketFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final baseColor = AppColor.blackTextColor(context);
    return FadeInUp(
      delay: const Duration(milliseconds: 200),
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: baseColor.withOpacity(0.03),
          borderRadius: BorderRadius.circular(32.r),
          border: Border.all(color: baseColor.withOpacity(0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FieldLabelWidget(label: AppLocaleKey.issueType.tr()),
            DropDownFieldWidget(hint: "Select category..."),
            Gap(20.h),
            FieldLabelWidget(label: AppLocaleKey.subject.tr()),
            CustomFormField(hintText: "Brief summary of the issue..."),
            Gap(20.h),
            FieldLabelWidget(label: AppLocaleKey.description.tr()),
            CustomFormField(hintText: "Provide detailed information...", maxLines: 5),
            Gap(24.h),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryColor(context),
                minimumSize: Size(double.infinity, 56.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                elevation: 0,
              ),
              child: Text(
                AppLocaleKey.submitTicket.tr(),
                style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
