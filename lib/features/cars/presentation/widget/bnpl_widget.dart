import 'package:car/core/custom_widgets/custom_toast/custom_toast.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
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
    // Correct price parsing: extract only digits
    final priceRawString = widget.car['price']?.toString() ?? '0';
    final priceString = priceRawString.replaceAll(RegExp(r'[^0-9.]'), '');
    final price = double.tryParse(priceString) ?? 0.0;

    if (price <= 0) return const SizedBox.shrink();

    final installment = price / 4;
    final formatter = NumberFormat('#,##0', 'en_US');
    final formattedInstallment = formatter.format(installment);

    return Container(
      margin: EdgeInsets.only(top: 16.h),
      child: Column(
        children: [
          if (_isLoading)
            Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: LinearProgressIndicator(
                color: AppColor.primaryColor(context),
                backgroundColor: AppColor.primaryColor(context).withValues(alpha: 0.1),
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
            bgColor: const Color(0xFFE89A8E),
            textColor: Colors.black,
            descKey: AppLocaleKey.withoutInterestTamara,
            bottomSheetDescKey: AppLocaleKey.tamaraDesc,
            installment: installment,
            formattedInstallment: formattedInstallment,
            total: price,
            isTabby: false,
          ),
        ],
      ),
    );
  }

  Future<void> _handleBnplCheckout(BuildContext context, bool isTabby, double amount) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      String? checkoutUrl;
      const String currency = 'SAR';
      const String buyerEmail = 'test@example.com'; // Hardcoded for demo/placeholders
      const String buyerPhone = '+966500000000';
      const String buyerName = 'User Name';
      final String orderId = 'ORDER_${DateTime.now().millisecondsSinceEpoch}';

      if (isTabby) {
        checkoutUrl = await _bnplService.createTabbySession(
          amount: amount,
          currency: currency,
          buyerEmail: buyerEmail,
          buyerPhone: buyerPhone,
          buyerName: buyerName,
          orderId: orderId,
        );
      } else {
        checkoutUrl = await _bnplService.createTamaraSession(
          amount: amount,
          currency: currency,
          buyerEmail: buyerEmail,
          buyerPhone: buyerPhone,
          buyerFullName: buyerName,
          orderId: orderId,
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
      } else {
        if (mounted) {
          CommonMethods.showToast(message: 'Failed to create ${isTabby ? "Tabby" : "Tamara"} session. Check API config.', type: ToastType.error);
        }
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
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
        context: context,
        providerName: providerName,
        bgColor: bgColor,
        textColor: textColor,
        bottomSheetDescKey: bottomSheetDescKey,
        total: total,
        installment: installment,
        formattedInstallment: formattedInstallment,
        isTabby: isTabby,
      ),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColor.secondAppColor(context),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Provider Logo Box
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: _buildLogo(providerName, bgColor, textColor, isTabby: isTabby, fullSize: true),
            ),
            Gap(12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '${AppLocaleKey.splitPayment.tr()} ',
                      style: TextStyle(
                        color: AppColor.blackTextColor(context),
                        fontSize: 13.sp,
                      ),
                      children: [
                        TextSpan(
                          text: '$formattedInstallment SAR',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColor.primaryColor(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(4.h),
                  Text(
                    descKey.tr(),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.info_outline_rounded, color: Colors.grey[400], size: 20.sp),
          ],
        ),
      ),
    );
  }
  Widget _buildLogo(String text, Color bgColor, Color textColor, {bool isTabby = true, bool fullSize = false}) {
    if (fullSize) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w900,
            fontFamily: 'Arial',
            fontSize: 14.sp,
          ),
        ),
      );
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w900,
          fontFamily: 'Arial',
          fontSize: 10.sp,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            Gap(24.h),
            Center(
              child: _buildLogo(providerName, bgColor, textColor, isTabby: isTabby, fullSize: true),
            ),
            Gap(16.h),
            Center(
              child: Text(
                AppLocaleKey.howItWorks.tr(),
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.blackTextColor(context),
                ),
              ),
            ),
            Gap(8.h),
            Center(
              child: Text(
                bottomSheetDescKey.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.grey[600],
                ),
              ),
            ),
            Gap(32.h),
            _buildTimelineItem(context, AppLocaleKey.payToday.tr(), formattedInstallment, bgColor, true),
            _buildTimelineItem(context, AppLocaleKey.inOneMonth.tr(), formattedInstallment, bgColor, false),
            _buildTimelineItem(context, AppLocaleKey.inTwoMonths.tr(), formattedInstallment, bgColor, false),
            _buildTimelineItem(context, AppLocaleKey.inThreeMonths.tr(), formattedInstallment, bgColor, false, isLast: true),
            Gap(24.h),
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
                  '${AppLocaleKey.ok.tr()} - ${AppLocaleKey.payWith.tr()} ${providerName.toUpperCase()}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
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
          width: 30.w,
          child: Column(
            children: [
              Container(
                width: 16.w,
                height: 16.w,
                decoration: BoxDecoration(
                  color: isFirst ? brandColor : AppColor.scaffoldColor(context),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isFirst ? brandColor : Colors.grey.withValues(alpha: 0.3),
                    width: 4.w,
                  ),
                ),
              ),
              if (!isLast)
                Container(
                  width: 2.w,
                  height: 30.h,
                  color: Colors.grey.withValues(alpha: 0.2),
                ),
            ],
          ),
        ),
        Gap(12.w),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: isFirst ? FontWeight.bold : FontWeight.w500,
                    color: AppColor.blackTextColor(context),
                  ),
                ),
                Text(
                  '$amount SAR',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.blackTextColor(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
