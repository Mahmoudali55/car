import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/features/agent/presentation/screens/widget/spec_card_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:car/features/agent/data/agent_models.dart';
import 'package:car/features/agent/presentation/screens/widget/icon_btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
class AgentCarDetailsScreen extends StatelessWidget {
  final AgentCar car;
  const AgentCarDetailsScreen({super.key, required this.car});
  @override
  Widget build(BuildContext context) {
    final availabilityColor = car.getAvailabilityColor(context);
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.w),
        child: CustomButton(
          onPressed: () {},
          radius: 12.r,
          child: Text(
            AppLocaleKey.agentReserveForCustomer.tr(),
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w900,
              color: AppColor.whiteColor(context),
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 320.h,
            pinned: true,
            elevation: 0,
            backgroundColor: AppColor.appBarColor(context),
            leading: Padding(
              padding: EdgeInsets.all(8.w),
              child: IconBtn(
                icon: Icons.arrow_back_ios_new_rounded,
                onTap: () => Navigator.pop(context),
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.all(8.w),
                child: IconBtn(
                  icon: Icons.share_rounded,
                  onTap: () {},
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColor.blueColor(context).withValues(alpha: (0.15)),
                      AppColor.scaffoldColor(context),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.directions_car_filled_rounded,
                    size: 120.sp,
                    color: AppColor.blueColor(context).withValues(alpha: (0.2)),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 120.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: availabilityColor.withValues(alpha: (0.12)),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          car.availabilityLabel,
                          style: TextStyle(
                            color: availabilityColor,
                            fontWeight: FontWeight.w900,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'ID: #${car.id.padLeft(6, '0')}',
                        style: TextStyle(
                          color: AppColor.greyColor(context),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  Gap(20.h),

                  /// Brand & Name
                  Text(
                    car.brand,
                    style: TextStyle(
                      color: AppColor.blueColor(context),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Gap(4.h),
                  Text(
                    car.name,
                    style: TextStyle(
                      color: AppColor.blackTextColor(context),
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  Gap(12.h),

                  /// Price
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        NumberFormat('#,##0').format(car.price),
                        style: TextStyle(
                          color: AppColor.blackTextColor(context),
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Gap(6.w),
                      Text(
                        AppLocaleKey.sar.tr(),
                        style: TextStyle(
                          color: AppColor.greyColor(context),
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),

                  Gap(32.h),

                  /// Specs
                  Text(
                    AppLocaleKey.agentMainSpecs.tr(),
                    style: TextStyle(
                      color: AppColor.blackTextColor(context),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Gap(16.h),

                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 12.h,
                    crossAxisSpacing: 12.w,
                    childAspectRatio: 2.2,
                    children: [
                      SpecCard(
                        icon: Icons.calendar_today_rounded,
                        label: AppLocaleKey.agentYearMade.tr(),
                        value: car.year,
                      ),
                      SpecCard(
                        icon: Icons.speed_rounded,
                        label: AppLocaleKey.agentDistance.tr(),
                        value:
                            '${car.mileage} ${AppLocaleKey.km.tr()}',
                      ),
                      SpecCard(
                        icon: Icons.palette_rounded,
                        label: AppLocaleKey.agentColor.tr(),
                        value: car.color,
                      ),
                      SpecCard(
                        icon: Icons.settings_rounded,
                        label: AppLocaleKey.agentTransmission.tr(),
                        value: AppLocaleKey.agentAutomatic.tr(),
                      ),
                    ],
                  ),

                  Gap(32.h),

                  /// Description
                  Text(
                    AppLocaleKey.agentAboutCar.tr(),
                    style: TextStyle(
                      color: AppColor.blackTextColor(context),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Gap(12.h),
                  Text(
                    AppLocaleKey.agentCarDesc
                        .tr(namedArgs: {'name': car.name}),
                    style: TextStyle(
                      color:
                          AppColor.greyColor(context).withValues(alpha: (0.8)),
                      fontSize: 14.sp,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}