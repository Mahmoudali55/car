import 'dart:ui';
import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/common_methods.dart';
import 'package:car/core/utils/pdf_generator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
class StickyActionBarWidget extends StatelessWidget {
  final Map<String, dynamic> car;

  const StickyActionBarWidget({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 40.h),
            decoration: BoxDecoration(
              color: AppColor.scaffoldColor(context).withValues(alpha: 0.8),
              border: Border(
                top: BorderSide(color: AppColor.blackTextColor(context).withValues(alpha: 0.08)),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CustomButton(
                    height: 50.h,
                    radius: 12.r,
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
                      AppLocaleKey.reserveCar.tr(),
                      style: AppTextStyle.buttonStyle(
                        context,
                      ).copyWith(fontWeight: FontWeight.w900, fontSize: 13.sp),
                    ),
                  ),
                ),
                Gap(16.w),
                Container(
                  height: 50.h,
                  width: 56.h,
                  decoration: BoxDecoration(
                    color: AppColor.blackTextColor(context).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.picture_as_pdf_rounded,
                      color: AppColor.blackTextColor(context),
                      size: 28,
                    ),
                    tooltip: AppLocaleKey.downloadQuotation.tr(),
                    onPressed: () => _showPdfOptions(context),
                  ),
                ),
                Gap(12.w),
                Container(
                  height: 50.h,
                  width: 56.h,
                  decoration: BoxDecoration(
                    color: const Color(0xff25D366),
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff25D366).withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(Icons.phone_rounded, color: AppColor.whiteColor(context), size: 28),
                    onPressed: () {
                      if (HiveMethods.getToken() == null) {
                        CommonMethods.showLoginRequiredDialog(context);
                      } else {
                       
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showPdfOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
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
            Text(
              AppLocaleKey.carQuotation.tr(),
              style: AppTextStyle.titleMedium(
                context,
                listen: false,
                color: AppColor.blackTextColor(context),
              ).copyWith(fontWeight: FontWeight.w900),
            ),
            Gap(24.h),
            _buildOptionItem(
              context,
              icon: Icons.print_rounded,
              label: AppLocaleKey.print.tr(),
              onTap: () async {
                final langCode = context.locale.languageCode;
                Navigator.pop(bottomSheetContext);
                final bytes = await QuotePdfGenerator.generatePdfBytes(car, langCode);
                await QuotePdfGenerator.printQuotation(bytes, 'Quotation_${car['name']}.pdf');
              },
            ),
            _buildOptionItem(
              context,
              icon: Icons.visibility_rounded,
              label: AppLocaleKey.view.tr(),
              onTap: () async {
                final langCode = context.locale.languageCode;
                Navigator.pop(bottomSheetContext);
                final bytes = await QuotePdfGenerator.generatePdfBytes(car, langCode);
                await QuotePdfGenerator.viewQuotation(bytes, 'Quotation_${car['name']}.pdf');
              },
            ),
            _buildOptionItem(
              context,
              icon: Icons.share_rounded,
              label: AppLocaleKey.share.tr(),
              onTap: () async {
                final langCode = context.locale.languageCode;
                Navigator.pop(bottomSheetContext);
                final bytes = await QuotePdfGenerator.generatePdfBytes(car, langCode);
                await QuotePdfGenerator.shareQuotation(bytes, 'Quotation_${car['name']}.pdf');
              },
            ),
            _buildOptionItem(
              context,
              icon: Icons.file_download_rounded,
              label: AppLocaleKey.downloadQuotation.tr(),
              onTap: () async {
                final langCode = context.locale.languageCode;
                Navigator.pop(bottomSheetContext);
                final bytes = await QuotePdfGenerator.generatePdfBytes(car, langCode);
                await QuotePdfGenerator.downloadQuotation(bytes, 'Quotation_${car['name']}.pdf');
                // ignore: use_build_context_synchronously
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(AppLocaleKey.orderSuccess.tr()),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
            ),
            Gap(16.h),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: AppColor.primaryColor(context).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(icon, color: AppColor.primaryColor(context)),
      ),
      title: Text(
        label,
        style: AppTextStyle.bodyMedium(context).copyWith(fontWeight: FontWeight.w600),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    );
  }
}
