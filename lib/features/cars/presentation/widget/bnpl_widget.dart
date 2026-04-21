import 'package:car/core/custom_widgets/custom_toast/custom_toast.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/services/bnpl_service.dart';
import 'package:car/core/utils/common_methods.dart';
import 'package:car/features/cars/presentation/screen/bnpl_payment_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class BnplWidget extends StatefulWidget {
  final Map<String, dynamic> car;

  const BnplWidget({super.key, required this.car});

  @override
  State<BnplWidget> createState() => _BnplWidgetState();
}

class _BnplWidgetState extends State<BnplWidget> {
  final BnplService _bnplService = BnplService();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    // Robust price parsing to handle various formats
    double parsePrice(dynamic priceValue) {
      if (priceValue == null) return 0.0;
      final priceStr = priceValue.toString();
      // Remove everything except digits and dots
      final cleanStr = priceStr.replaceAll(RegExp(r'[^0-9.]'), '');
      return double.tryParse(cleanStr) ?? 0.0;
    }

    final price = parsePrice(widget.car['price'] ?? widget.car['cashPrice']);
    if (price <= 0) return const SizedBox.shrink();

    final installment = price / 4;
    final formatter = NumberFormat('#,##0', 'en_US');
    final formattedInstallment = formatter.format(installment);

    return Column(
      children: [
        if (_isLoading)
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: LinearProgressIndicator(
              color: AppColor.primaryColor(context),
              backgroundColor: AppColor.primaryColor(context).withOpacity(0.1),
            ),
          ),
        _buildProviderCard(
          context: context,
          providerName: 'tabby',
          bgColor: const Color(0xFF3EEDC4),
          textColor: Colors.black,
          descKey: AppLocaleKey.withoutInterestTabby,
          bottomSheetDescKey: AppLocaleKey.tabbyDesc,
          installment: installment,
          formattedInstallment: formattedInstallment,
          total: price,
          isTabby: true,
        ),
        Gap(12.h),
        _buildProviderCard(
          context: context,
          providerName: 'tamara',
          bgColor: const Color(0xFFEBC18A), // More accurate Tamara gold
          textColor: Colors.black,
          descKey: AppLocaleKey.withoutInterestTamara,
          bottomSheetDescKey: AppLocaleKey.tamaraDesc,
          installment: installment,
          formattedInstallment: formattedInstallment,
          total: price,
          isTabby: false,
        ),
      ],
    );
  }

  Future<void> _handleBnplCheckout(BuildContext context, bool isTabby, double amount) async {
    if (_isLoading) return;
    setState(() => _isLoading = true);
    try {
      String? checkoutUrl;
      const String currency = 'SAR';
      const String buyerEmail = 'test@example.com';
      const String buyerPhone = '+966500000000';
      const String buyerName = 'User Name';
      final String orderId = 'ORDER_${DateTime.now().millisecondsSinceEpoch}';

      if (isTabby) {
        checkoutUrl = await _bnplService.createTabbySession(
          amount: amount, currency: currency, buyerEmail: buyerEmail,
          buyerPhone: buyerPhone, buyerName: buyerName, orderId: orderId,
        );
      } else {
        checkoutUrl = await _bnplService.createTamaraSession(
          amount: amount, currency: currency, buyerEmail: buyerEmail,
          buyerPhone: buyerPhone, buyerFullName: buyerName, orderId: orderId,
        );
      }

      if (checkoutUrl != null && mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BnplPaymentScreen(
              checkoutUrl: checkoutUrl!,
              providerName: isTabby ? 'Tabby' : 'Tamara',
            ),
          ),
        );
      } else if (mounted) {
        CommonMethods.showToast(message: 'Payment configuration required', type: ToastType.error);
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Widget _buildProviderCard({
    required BuildContext context,
    required String providerName,
    required Color bgColor,
    required Color textColor,
    required String descKey,
    required String bottomSheetDescKey,
    required double installment,
    required String formattedInstallment,
    required double total,
    required bool isTabby,
  }) {
    return GestureDetector(
      onTap: () => _showBnplDetails(
        context: context, providerName: providerName, bgColor: bgColor,
        textColor: textColor, bottomSheetDescKey: bottomSheetDescKey,
        total: total, installment: installment, formattedInstallment: formattedInstallment,
        isTabby: isTabby,
      ),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColor.secondAppColor(context),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColor.blackTextColor(context).withOpacity(0.05)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                providerName.toUpperCase(),
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 12.sp,
                  letterSpacing: 1,
                ),
              ),
            ),
            Gap(16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '${AppLocaleKey.splitPayment.tr()} ',
                      style: AppTextStyle.bodyMedium(context).copyWith(fontSize: 12.sp),
                      children: [
                        TextSpan(
                          text: '$formattedInstallment SAR',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    descKey.tr(),
                    style: AppTextStyle.bodySmall(context).copyWith(
                      color: AppColor.greyColor(context),
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: AppColor.greyColor(context), size: 14.sp),
          ],
        ),
      ),
    );
  }

  void _showBnplDetails({
    required BuildContext context,
    required String providerName,
    required Color bgColor,
    required Color textColor,
    required String bottomSheetDescKey,
    required double total,
    required double installment,
    required String formattedInstallment,
    required bool isTabby,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) => Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: AppColor.scaffoldColor(context),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w, height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Gap(24.h),
            Text(
              '${AppLocaleKey.payWith.tr()} ${providerName.toUpperCase()}',
              style: AppTextStyle.titleMedium(context).copyWith(fontWeight: FontWeight.bold),
            ),
            Gap(16.h),
            Text(
              bottomSheetDescKey.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyle.bodySmall(context).copyWith(color: AppColor.greyColor(context)),
            ),
            Gap(32.h),
            _buildTimelineItem(context, AppLocaleKey.payToday.tr(), formattedInstallment, bgColor, true),
            _buildTimelineItem(context, AppLocaleKey.inOneMonth.tr(), formattedInstallment, bgColor, false),
            _buildTimelineItem(context, AppLocaleKey.inTwoMonths.tr(), formattedInstallment, bgColor, false),
            _buildTimelineItem(context, AppLocaleKey.inThreeMonths.tr(), formattedInstallment, bgColor, false, isLast: true),
            Gap(32.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(bottomSheetContext);
                  _handleBnplCheckout(context, isTabby, total);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor(context),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                ),
                child: Text(
                  AppLocaleKey.payNow.tr(),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Gap(16.h),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem(BuildContext context, String title, String amount, Color brandColor, bool isFirst, {bool isLast = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 24.w,
          child: Column(
            children: [
              Container(
                width: 12.w, height: 12.w,
                decoration: BoxDecoration(
                  color: isFirst ? brandColor : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: isFirst ? brandColor : Colors.grey.withOpacity(0.3), width: 2),
                ),
              ),
              if (!isLast) Container(width: 1.w, height: 30.h, color: Colors.grey.withOpacity(0.2)),
            ],
          ),
        ),
        Gap(12.w),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: AppTextStyle.bodyMedium(context)),
              Text('$amount SAR', style: AppTextStyle.bodyMedium(context).copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }
}
