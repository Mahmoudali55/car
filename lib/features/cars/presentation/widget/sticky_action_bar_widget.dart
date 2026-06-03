import 'dart:ui';

import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/common_methods.dart';
import 'package:car/features/home/data/model/brand_cars_data_model.dart';
import 'package:car/features/home/presentation/view/widgets/contact_bottom_sheet_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class StickyActionBarWidget extends StatelessWidget {
  final GetBrandCarsDataModel car;

  const StickyActionBarWidget({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: EdgeInsets.only(top: 10.h, bottom: 20.h, left: 20.w, right: 20.w),
          decoration: BoxDecoration(
            color: AppColor.scaffoldColor(context).withValues(alpha: 0.8),
            border: Border(
              top: BorderSide(color: AppColor.blackTextColor(context).withValues(alpha: 0.08)),
            ),
          ),
          child: Row(
            children: [
              // Call Button (Secondary)
              Expanded(
                flex: 1,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    fixedSize: Size.fromHeight(35.h),
                    side: BorderSide(color: AppColor.greenColor(context)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                    foregroundColor: AppColor.greenColor(context),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) => const ContactBottomSheetWidget(),
                    );
                  },
                  icon: Icon(Icons.phone_rounded, size: 20.sp),
                  label: Text(
                    AppLocaleKey.agentCallButton.tr(),
                    style: AppTextStyle.bodySmall(
                      context,
                    ).copyWith(fontWeight: FontWeight.bold, color: AppColor.greenColor(context)),
                  ),
                ),
              ),
              Gap(16.w),
              // Book Now Button (Primary)
              Expanded(
                flex: 1,
                child: CustomButton(
                  radius: 10.r,
                  onPressed: () {
                    if (HiveMethods.getToken() == null) {
                      CommonMethods.showLoginRequiredDialog(context);
                    } else {
                      Navigator.pushNamed(
                        context,
                        RoutesName.carReservationScreen,
                        arguments: {'car': car, 'isFromLink': false},
                      );
                    }
                  },
                  child: Text(
                    AppLocaleKey.agentReserveButton.tr(),
                    style: AppTextStyle.bodySmall(
                      context,
                    ).copyWith(fontWeight: FontWeight.w900, color: AppColor.whiteColor(context)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
