import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/custom_widgets/custom_sar_text.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/agent/data/agent_models.dart';
import 'package:car/features/agent/presentation/screens/widget/icon_btn_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/quote_builder_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
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

      bottomNavigationBar: car.availability == CarAvailability.available
          ? Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColor.cardColor(context),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .04),
                    blurRadius: 20,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: CustomButton(
                onPressed: car.availability == CarAvailability.available ? () {} : null,
                radius: 14.r,
                child: Text(
                  AppLocaleKey.agentReserveForCustomer.tr(),
                  style: AppTextStyle.bodyMedium(
                    context,
                  ).copyWith(color: AppColor.whiteColor(context), fontWeight: FontWeight.w800),
                ),
              ),
            )
          : null,

      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 340.h,
            backgroundColor: AppColor.appBarColor(context),
            elevation: 0,

            leading: Padding(
              padding: EdgeInsets.all(8.w),
              child: IconBtn(
                icon: Icons.arrow_back_ios_new_rounded,
                onTap: () => Navigator.pop(context),
              ),
            ),

            actions: [
              if (car.availability == CarAvailability.available)
                Padding(
                  padding: EdgeInsets.all(8.w),
                  child: IconBtn(
                    icon: Icons.description_outlined,
                    onTap: () {
                      QuoteBuilderDialog.show(
                        context,
                        carName: car.name,
                        initialPrice: car.price,
                        existingSpecs: {
                          AppLocaleKey.agentYearMade.tr(): car.year,
                          AppLocaleKey.agentDistance.tr(): car.mileage,
                          AppLocaleKey.agentColor.tr(): car.color,
                          AppLocaleKey.agentTransmission.tr(): AppLocaleKey.agentAutomatic.tr(),
                        },
                      );
                    },
                  ),
                ),
            ],

            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    color: AppColor.blueColor(context).withValues(alpha: .08),
                    child: Icon(
                      Icons.directions_car_filled_rounded,
                      size: 150.sp,
                      color: AppColor.blueColor(context).withValues(alpha: .25),
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black.withValues(alpha: .75)],
                      ),
                    ),
                  ),

                  Positioned(
                    left: 20.w,
                    right: 20.w,
                    bottom: 30.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: availabilityColor,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            car.availabilityLabel,
                            style: AppTextStyle.bodySmall(context).copyWith(
                              color: AppColor.whiteColor(context),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),

                        Gap(12.h),

                        Text(
                          car.brand,
                          style: AppTextStyle.bodyMedium(
                            context,
                          ).copyWith(color: Colors.white70, fontWeight: FontWeight.w700),
                        ),

                        Gap(4.h),

                        Text(
                          car.name,
                          style: AppTextStyle.titleLarge(context).copyWith(
                            color: AppColor.whiteColor(context),
                            fontWeight: FontWeight.w900,
                          ),
                        ),

                        Gap(12.h),

                        ValueWithCurrencyIcon(
                          text:
                              '${NumberFormat('#,##0').format(car.price)} ${AppLocaleKey.sar.tr()}',
                          textStyle: AppTextStyle.titleLarge(context).copyWith(
                            color: AppColor.whiteColor(context),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// QUICK INFO
                  Container(
                    padding: EdgeInsets.all(18.w),
                    decoration: BoxDecoration(
                      color: AppColor.cardColor(context),
                      borderRadius: BorderRadius.circular(24.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: .04),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _QuickInfo(
                          icon: Icons.calendar_today_rounded,
                          title: AppLocaleKey.agentYearMade.tr(),
                          value: car.year,
                        ),

                        _QuickInfo(
                          icon: Icons.speed_rounded,
                          title: AppLocaleKey.agentDistance.tr(),
                          value: car.mileage,
                        ),

                        _QuickInfo(
                          icon: Icons.palette_rounded,
                          title: AppLocaleKey.agentColor.tr(),
                          value: car.color,
                        ),
                      ],
                    ),
                  ),

                  Gap(30.h),

                  Text(
                    AppLocaleKey.agentMainSpecs.tr(),
                    style: AppTextStyle.bodyLarge(context).copyWith(fontWeight: FontWeight.w900),
                  ),

                  Gap(16.h),

                  SpecTile(
                    icon: Icons.calendar_today_rounded,
                    title: AppLocaleKey.agentYearMade.tr(),
                    value: car.year,
                  ),

                  SpecTile(
                    icon: Icons.speed_rounded,
                    title: AppLocaleKey.agentDistance.tr(),
                    value: '${car.mileage} ${AppLocaleKey.km.tr()}',
                  ),

                  SpecTile(
                    icon: Icons.palette_rounded,
                    title: AppLocaleKey.agentColor.tr(),
                    value: car.color,
                  ),

                  SpecTile(
                    icon: Icons.settings_rounded,
                    title: AppLocaleKey.agentTransmission.tr(),
                    value: AppLocaleKey.agentAutomatic.tr(),
                  ),

                  Gap(30.h),

                  Container(
                    padding: EdgeInsets.all(18.w),
                    decoration: BoxDecoration(
                      color: AppColor.cardColor(context),
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocaleKey.agentAboutCar.tr(),
                          style: AppTextStyle.bodyLarge(
                            context,
                          ).copyWith(fontWeight: FontWeight.w900),
                        ),

                        Gap(12.h),

                        Text(
                          AppLocaleKey.agentCarDesc.tr(namedArgs: {'name': car.name}),
                          style: AppTextStyle.bodyMedium(
                            context,
                          ).copyWith(height: 1.8, color: AppColor.greyColor(context)),
                        ),
                      ],
                    ),
                  ),

                  Gap(120.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickInfo extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _QuickInfo({required this.icon, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: AppColor.primaryColor(context)),
        Gap(8.h),
        Text(value, style: AppTextStyle.bodyMedium(context).copyWith(fontWeight: FontWeight.w900)),
        Gap(4.h),
        Text(
          title,
          style: AppTextStyle.bodySmall(context).copyWith(color: AppColor.greyColor(context)),
        ),
      ],
    );
  }
}

class SpecTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const SpecTile({super.key, required this.icon, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: AppColor.primaryColor(context).withValues(alpha: .08),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: AppColor.primaryColor(context)),
          ),
          Gap(14.w),
          Expanded(child: Text(title)),
          Text(
            value,
            style: AppTextStyle.bodyMedium(context).copyWith(fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}
