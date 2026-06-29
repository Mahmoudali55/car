import 'package:car/core/custom_widgets/custom_toast/custom_toast.dart';
import 'package:car/core/images/app_images.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/services/bnpl_service.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/common_methods.dart';
import 'package:car/features/cars/presentation/screen/bnpl_payment_screen.dart';
import 'package:car/features/home/data/model/brand_cars_data_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class BnplWidget extends StatefulWidget {
  final GetBrandCarsDataModel car;

  const BnplWidget({super.key, required this.car});

  @override
  State<BnplWidget> createState() => _BnplWidgetState();
}

class _BnplWidgetState extends State<BnplWidget> {
  final BnplService _bnplService = BnplService();
  bool _isLoading = false;

  // دالة لحساب السعر مع الضريبة
  double _getPriceWithVat() {
    // الحصول على السعر الأصلي
    final priceStr = widget.car.price ?? widget.car.cashPrice;
    if (priceStr == null || priceStr.isEmpty) return 0.0;

    // تنظيف السعر من الرموز غير الرقمية
    final cleanPrice = priceStr.replaceAll(RegExp(r'[^0-9.]'), '');
    final double originalPrice = double.tryParse(cleanPrice) ?? 0.0;

    if (originalPrice <= 0) return 0.0;

    // الحصول على نسبة الضريبة (من الـ API أو من Hive)
    // يمكنك إضافة دالة لجلب النسبة من Hive كما في المثال السابق
    final double vatPercentage = _getVatPercentage(); // 15.0 افتراضياً

    // حساب السعر شامل الضريبة
    return originalPrice * (1 + (vatPercentage / 100));
  }

  // دالة لجلب نسبة الضريبة
  double _getVatPercentage() {
    // يمكنك جلب النسبة من Hive أو من الـ API
    // مثال: final vatSerial = HiveMethods.getVatNumber();
    // return double.tryParse(vatSerial.toString()) ?? 15.0;

    // حالياً نستخدم قيمة افتراضية 15%
    return 15.0;
  }

  @override
  Widget build(BuildContext context) {
    // استخدام السعر مع الضريبة
    final priceWithVat = _getPriceWithVat();

    if (priceWithVat <= 0) return const SizedBox.shrink();

    final installment = priceWithVat / 4;
    final formatter = NumberFormat('#,##0', 'en_US');
    final formattedInstallment = formatter.format(installment);

    return Column(
      children: [
        if (_isLoading)
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: LinearProgressIndicator(
              color: AppColor.primaryColor(context),
              backgroundColor: AppColor.primaryColor(context).withValues(alpha: (0.1)),
            ),
          ),
        _buildProviderCard(
          context: context,
          providerName: 'tabby',
          bgColor: const Color(0xFF3EEDC4),
          textColor: AppColor.blackColor(context),
          descKey: AppLocaleKey.withoutInterestTabby,
          bottomSheetDescKey: AppLocaleKey.tabbyDesc,
          installment: installment,
          formattedInstallment: formattedInstallment,
          total: priceWithVat,
          isTabby: true,
        ),
        Gap(12.h),
        _buildProviderCard(
          context: context,
          providerName: 'tamara',
          bgColor: const Color(0xFFEBC18A),
          textColor: AppColor.blackColor(context),
          descKey: AppLocaleKey.withoutInterestTamara,
          bottomSheetDescKey: AppLocaleKey.tamaraDesc,
          installment: installment,
          formattedInstallment: formattedInstallment,
          total: priceWithVat,
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
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: (0.05))),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(8.r)),
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
                          text: '$formattedInstallment ',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: SvgPicture.asset(AppImages.sar, width: 12.w, height: 12.h),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    descKey.tr(),
                    style: AppTextStyle.bodySmall(
                      context,
                    ).copyWith(color: AppColor.greyColor(context), fontSize: 10.sp),
                  ),
                  // إضافة نص يوضح أن السعر شامل الضريبة
                  Text(
                    'السعر شامل الضريبة',
                    style: AppTextStyle.bodySmall(context).copyWith(
                      color: AppColor.primaryColor(context),
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w500,
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
    final formatter = NumberFormat('#,##0', 'en_US');
    final formattedTotal = formatter.format(total);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) => Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: AppColor.scaffoldColor(bottomSheetContext),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: (0.3)),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Gap(24.h),
            Text(
              '${AppLocaleKey.payWith.tr()} ${providerName.toUpperCase()}',
              style: AppTextStyle.titleMedium(
                bottomSheetContext,
              ).copyWith(fontWeight: FontWeight.bold),
            ),
            Gap(8.h),
            // إضافة السعر الإجمالي شامل الضريبة
            Text(
              'المبلغ الإجمالي: $formattedTotal ${AppLocaleKey.sar.tr()} (شامل الضريبة)',
              style: AppTextStyle.bodyMedium(bottomSheetContext).copyWith(
                color: AppColor.primaryColor(bottomSheetContext),
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(16.h),
            Text(
              bottomSheetDescKey.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyle.bodySmall(
                bottomSheetContext,
              ).copyWith(color: AppColor.greyColor(bottomSheetContext)),
            ),
            Gap(32.h),
            _buildTimelineItem(
              bottomSheetContext,
              AppLocaleKey.payToday.tr(),
              formattedInstallment,
              bgColor,
              true,
            ),
            _buildTimelineItem(
              bottomSheetContext,
              AppLocaleKey.inOneMonth.tr(),
              formattedInstallment,
              bgColor,
              false,
            ),
            _buildTimelineItem(
              bottomSheetContext,
              AppLocaleKey.inTwoMonths.tr(),
              formattedInstallment,
              bgColor,
              false,
            ),
            _buildTimelineItem(
              bottomSheetContext,
              AppLocaleKey.inThreeMonths.tr(),
              formattedInstallment,
              bgColor,
              false,
              isLast: true,
            ),
            Gap(32.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(bottomSheetContext);
                  _handleBnplCheckout(context, isTabby, total);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor(bottomSheetContext),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                ),
                child: Text(
                  '${AppLocaleKey.payNow.tr()} ($formattedTotal ${AppLocaleKey.sar.tr()})',
                  style: TextStyle(
                    color: AppColor.whiteColor(bottomSheetContext),
                    fontWeight: FontWeight.bold,
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

  Widget _buildTimelineItem(
    BuildContext context,
    String title,
    String amount,
    Color brandColor,
    bool isFirst, {
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 24.w,
          child: Column(
            children: [
              Container(
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                  color: isFirst ? brandColor : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isFirst ? brandColor : Colors.grey.withValues(alpha: (0.3)),
                    width: 2,
                  ),
                ),
              ),
              if (!isLast)
                Container(
                  width: 1.w,
                  height: 30.h,
                  color: Colors.grey.withValues(alpha: (0.2)),
                ),
            ],
          ),
        ),
        Gap(12.w),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: AppTextStyle.bodyMedium(context)),
              Text(
                '$amount ${AppLocaleKey.sar.tr()}',
                style: AppTextStyle.bodyMedium(context).copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
