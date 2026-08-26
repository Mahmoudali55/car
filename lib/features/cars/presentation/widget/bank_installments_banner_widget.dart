import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/custom_widgets/custom_sar_text.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/home/data/model/brand_cars_data_model.dart';
import 'package:car/features/home/data/model/financing_ad_model.dart';
import 'package:car/features/home/presentation/cubit/home_cubit.dart';
import 'package:car/features/services/presentation/screen/financing_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class BankInstallmentsBannerWidget extends StatefulWidget {
  final GetBrandCarsDataModel car;
  final bool isOffer;
  final FinancingAdModel? offer;
  final List<FinancingAdModel> offers;

  const BankInstallmentsBannerWidget({
    super.key,
    required this.car,
    this.isOffer = false,
    this.offer,
    this.offers = const [],
  });

  @override
  State<BankInstallmentsBannerWidget> createState() => _BankInstallmentsBannerWidgetState();
}

class _BankInstallmentsBannerWidgetState extends State<BankInstallmentsBannerWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.offers.isEmpty && widget.offer == null) {
        final homeCubit = context.read<HomeCubit>();
        if (homeCubit.state.normalFinancingStatus.data == null ||
            homeCubit.state.normalFinancingStatus.data!.isEmpty) {
          homeCubit.getNormalFinancing();
        }
      }
    });
  }

  FinancingAdModel? _getLowestOffer(List<FinancingAdModel> cubitOffers) {
    final List<FinancingAdModel> candidates = widget.offers.isNotEmpty
        ? widget.offers
        : (widget.offer != null ? <FinancingAdModel>[widget.offer!] : cubitOffers);

    if (candidates.isEmpty) return null;
    return candidates.reduce(
      (a, b) => (a.interestRate ?? double.infinity) <= (b.interestRate ?? double.infinity) ? a : b,
    );
  }

  String _getInstallmentPrice(List<FinancingAdModel> cubitOffers) {
    final lowestOffer = _getLowestOffer(cubitOffers);
    final priceString = widget.car.price?.replaceAll(RegExp(r'[^0-9.]'), '') ?? '';
    final price = double.tryParse(priceString) ?? 0;

    if (lowestOffer != null && price > 0) {
      return NumberFormat('#,##0').format(lowestOffer.monthlyInstallmentForPrice(price));
    }
    if (widget.isOffer && widget.car.monthlyInstallment != null) {
      return NumberFormat('#,##0').format(widget.car.monthlyInstallment);
    }
    if (price > 0) {
      final vatPercentage = double.tryParse(HiveMethods.getVatNumber()?.toString() ?? '') ?? 0;
      final priceWithVat = price * (1 + vatPercentage / 100);
      const years = 5;
      const months = 60;
      final totalInterest = priceWithVat * 0.035 * years;
      final monthly = (priceWithVat + totalInterest) / months;
      return NumberFormat('#,##0').format(monthly);
    }
    return widget.car.installments ?? '1,999';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubitOffers = state.normalFinancingStatus.data ?? const <FinancingAdModel>[];

        return GestureDetector(
          onTap: () async {
            FinancingAdModel? selectedOffer = _getLowestOffer(cubitOffers);
            List<FinancingAdModel> selectedOffers = widget.offers.isNotEmpty
                ? widget.offers
                : (widget.offer != null ? [widget.offer!] : cubitOffers);
            if (selectedOffers.isEmpty) {
              final homeCubit = context.read<HomeCubit>();
              await homeCubit.getNormalFinancing();
              if (!context.mounted) return;
              selectedOffers = homeCubit.state.normalFinancingStatus.data ?? const [];
              selectedOffer = _getLowestOffer(selectedOffers);
            }

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    FinancingScreen(car: widget.car, offer: selectedOffer, offers: selectedOffers),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocaleKey.agentInstallments.tr(),
                style: AppTextStyle.bodySmall(
                  context,
                ).copyWith(color: AppColor.blueColor(context), fontWeight: FontWeight.bold),
              ),
              Gap(6.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      _getInstallmentPrice(cubitOffers),
                      style: AppTextStyle.titleMedium(context).copyWith(
                        color: AppColor.blueColor(context),
                        fontWeight: FontWeight.w900,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                  Gap(4.w),
                  Flexible(
                    child: ValueWithCurrencyIcon(
                      text:
                          '${AppLocaleKey.aed.tr()} / ${AppLocaleKey.agentAppointment.tr() == "English" ? "Mo" : "شهرياً"}',
                      textStyle: AppTextStyle.bodySmall(
                        context,
                      ).copyWith(color: AppColor.blueColor(context), fontSize: 10.sp),
                    ),
                  ),
                ],
              ),

              Gap(10.h),
              Container(
                height: 20.h,
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: AppColor.greyColor(context), width: 0.09.w),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.calculate_outlined, color: AppColor.blueColor(context), size: 14.sp),
                    Gap(4.w),
                    Expanded(
                      child: Text(
                        AppLocaleKey.agentCalculateFinancing.tr(),
                        style: AppTextStyle.bodySmall(context).copyWith(
                          color: AppColor.blueColor(context),
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Gap(4.w),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColor.primaryColor(context),
                      size: 12.sp,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
