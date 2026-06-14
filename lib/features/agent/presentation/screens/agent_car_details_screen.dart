import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/custom_widgets/custom_sar_text.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/agent/data/agent_models.dart';
import 'package:car/features/agent/presentation/screens/widget/custom_agent_car_details_info_widget.dart';
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
                    color: AppColor.blackColor(context).withValues(alpha: .04),
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
                          AppLocaleKey.agentSimNumber.tr(): car.mileage,
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
                        colors: [
                          Colors.transparent,
                          AppColor.blackColor(context).withValues(alpha: .75),
                        ],
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
              child: CustomAgentCarDetailsInfoWidget(car: car),
            ),
          ),
        ],
      ),
    );
  }
}
