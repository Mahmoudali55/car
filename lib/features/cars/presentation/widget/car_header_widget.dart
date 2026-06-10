import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/images/app_images.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cars/presentation/widget/bank_installments_banner_widget.dart'
    show BankInstallmentsBannerWidget;
import 'package:car/features/home/data/model/brand_cars_data_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class CarHeaderWidget extends StatefulWidget {
  final GetBrandCarsDataModel car;

  const CarHeaderWidget({super.key, required this.car});

  @override
  State<CarHeaderWidget> createState() => _CarHeaderWidgetState();
}

class _CarHeaderWidgetState extends State<CarHeaderWidget> {
  Color _getStatusColor(int status) {
    switch (status) {
      case 1:
        return AppColor.greenColor(context);
      case 2:
        return AppColor.iconColor(context);
      case 3:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isInCompare = HiveMethods.isInComparison(widget.car.itemName);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title and Comparison Button
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: AppColor.greenColor(context).withValues(alpha: (0.3)),
                      ),
                    ),
                    child: Text(
                      widget.car.groupName,
                      style: AppTextStyle.bodyMedium(context).copyWith(
                        color: AppColor.blackTextColor(context),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Gap(8.h),
                  Text(
                    widget.car.itemName,
                    style: AppTextStyle.bodyMedium(context).copyWith(
                      color: AppColor.blackTextColor(context),
                      fontWeight: FontWeight.w900,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(8.h),
                  if (widget.car.carStatusText.isNotEmpty)
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: _getStatusColor(widget.car.carStatus).withValues(alpha: (0.1)),
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: _getStatusColor(widget.car.carStatus).withValues(alpha: (0.3)),
                            ),
                          ),
                          child: Text(
                            widget.car.carStatusText,
                            style: TextStyle(
                              color: _getStatusColor(widget.car.carStatus),
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Gap(8.w),
                        if (widget.car.color.isNotEmpty) ...[
                          Gap(8.w),
                          Text(
                            '(${widget.car.color})',
                            style: AppTextStyle.bodySmall(context).copyWith(
                              color: AppColor.greyColor(context),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ],
                    ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                if (isInCompare) {
                  HiveMethods.removeFromComparison(widget.car.itemName);
                  setState(() {});
                } else {
                  HiveMethods.addToComparison(widget.car.toMap());
                  setState(() {});
                }
              },
              icon: Icon(
                isInCompare ? Icons.compare_arrows_rounded : Icons.add_chart_rounded,
                color: isInCompare ? AppColor.primaryColor(context) : AppColor.greyColor(context),
                size: 26.sp,
              ),
            ),
          ],
        ),
        Gap(15.h),

        // Pricing Section Card
        IntrinsicHeight(
          child: Row(
            children: [
              // Cash Price (Right)
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: AppColor.whiteColor(context),
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border(
                      right: BorderSide(color: AppColor.greenColor(context), width: 2.w),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocaleKey.cash.tr(),
                        style: AppTextStyle.bodySmall(context).copyWith(
                          color: AppColor.blackColor(context),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(6.h),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: AlignmentDirectional.centerStart,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.car.formattedPrice,
                              style: AppTextStyle.titleMedium(context).copyWith(
                                color: AppColor.greenColor(context),
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Gap(4.w),
                            SvgPicture.asset(
                              AppImages.sar,
                              height: 16.h,
                              width: 16.w,
                              colorFilter: ColorFilter.mode(
                                AppColor.greenColor(context),
                                BlendMode.srcIn,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Text(
                        AppLocaleKey.agentIncludesVat.tr(),
                        style: AppTextStyle.bodySmall(context),
                      ),
                    ],
                  ),
                ),
              ),

              widget.car.installments == null
                  ? Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BankInstallmentsBannerWidget(car: widget.car),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                          decoration: BoxDecoration(
                            color: AppColor.whiteColor(context),
                            borderRadius: BorderRadius.circular(6.r),
                            border: Border(
                              right: BorderSide(color: AppColor.primaryColor(context), width: 2.w),
                            ),
                          ),
                          child: BankInstallmentsBannerWidget(car: widget.car),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }
}
