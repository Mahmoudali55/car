import 'dart:ui';
import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/common_methods.dart';
import 'package:car/core/utils/pdf_generator.dart';
import 'package:car/features/home/presentation/view/widgets/contact_bottom_sheet_widget.dart';
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
              color: AppColor.scaffoldColor(context).withOpacity(0.8),
              border: Border(
                top: BorderSide(color: AppColor.blackTextColor(context).withOpacity(0.08)),
              ),
            ),
            child: Row(
              children: [
                // Call Button (Secondary)
                Expanded(
                  flex: 1,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      fixedSize: Size.fromHeight(50.h),
                      side: BorderSide(color: AppColor.greenColor(context)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                      foregroundColor: AppColor.greenColor(context),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const ContactBottomSheetWidget(),
                      );
                    },
                    icon: Icon(Icons.phone_rounded, size: 20.sp),
                    label: Text(
                      'اتصل بنا للحجز',
                      style: AppTextStyle.bodySmall(context).copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColor.greenColor(context),
                      ),
                    ),
                  ),
                ),
                Gap(16.w),
                // Book Now Button (Primary)
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.greenColor(context),
                      fixedSize: Size.fromHeight(50.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                      elevation: 0,
                    ),
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
                      'إحجزها الآن',
                      style: AppTextStyle.bodySmall(context).copyWith(
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
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
          color: AppColor.primaryColor(context).withOpacity(0.1),
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
