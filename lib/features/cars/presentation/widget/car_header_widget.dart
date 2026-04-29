import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cars/presentation/widget/bank_installments_banner_widget.dart'
    show BankInstallmentsBannerWidget;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CarHeaderWidget extends StatefulWidget {
  final Map<String, dynamic> car;

  const CarHeaderWidget({super.key, required this.car});

  @override
  State<CarHeaderWidget> createState() => _CarHeaderWidgetState();
}

class _CarHeaderWidgetState extends State<CarHeaderWidget> {
  Color _getStatusColor(int status) {
    switch (status) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isInCompare = HiveMethods.isInComparison(widget.car['name'] ?? '');

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
                      widget.car['brand'] ?? '',
                      style: AppTextStyle.bodyMedium(context).copyWith(
                        color: AppColor.blackTextColor(context),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Gap(8.h),
                  Text(
                    widget.car['name'] ?? '',
                    style: AppTextStyle.bodyMedium(context).copyWith(
                      color: AppColor.blackTextColor(context),
                      fontWeight: FontWeight.w900,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(8.h),
                  if (widget.car['carStatusText'] != null)
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: _getStatusColor(
                              widget.car['carStatus'] ?? 0,
                            ).withValues(alpha: (0.1)),
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: _getStatusColor(
                                widget.car['carStatus'] ?? 0,
                              ).withValues(alpha: (0.3)),
                            ),
                          ),
                          child: Text(
                            widget.car['carStatusText'],
                            style: TextStyle(
                              color: _getStatusColor(widget.car['carStatus'] ?? 0),
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Gap(8.w),
                        if (widget.car['Color'] != null) ...[
                          Gap(8.w),
                          Text(
                            '(${widget.car['Color']})',
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
                  HiveMethods.removeFromComparison(widget.car['name'] ?? '');
                  setState(() {});
                } else {
                  HiveMethods.addToComparison(widget.car);
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
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColor.whiteColor(context),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColor.greyColor(context).withValues(alpha: 0.1)),
            boxShadow: [
              BoxShadow(
                color: AppColor.blackColor(context).withValues(alpha: 0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                // Cash Price (Right)
                Expanded(
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.car['price']?.toString().replaceAll(RegExp(r'[^0-9,]'), '') ??
                                '---',
                            style: AppTextStyle.titleMedium(context).copyWith(
                              color: AppColor.greenColor(context),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Gap(4.w),
                          Text(
                            AppLocaleKey.aed.tr(),
                            style: AppTextStyle.bodySmall(
                              context,
                            ).copyWith(color: AppColor.greenColor(context), fontSize: 10.sp),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        AppLocaleKey.agentIncludesVat.tr(),
                        style: AppTextStyle.bodySmall(context),
                      ),
                    ],
                  ),
                ),
                VerticalDivider(color: AppColor.greyColor(context), width: 32.w),
                widget.car['installments'] == null
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
                          child: BankInstallmentsBannerWidget(car: widget.car),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
