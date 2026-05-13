import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CarStatusConfig {
  final String label;
  final Color bg;
  final Color textColor;
  final Color accent;

  const CarStatusConfig({
    required this.label,
    required this.bg,
    required this.textColor,
    required this.accent,
  });

  static CarStatusConfig of(String status) => switch (status) {
    'published' => const CarStatusConfig(
      label: 'منشور',
      bg: Color(0xFFEAF3DE),
      textColor: Color(0xFF3B6D11),
      accent: Color(0xFF639922),
    ),
    'pending' => const CarStatusConfig(
      label: 'معلق',
      bg: Color(0xFFFAEEDA),
      textColor: Color(0xFF854F0B),
      accent: Color(0xFFEF9F27),
    ),
    _ => const CarStatusConfig(
      label: 'محذوف',
      bg: Color(0xFFFCEBEB),
      textColor: Color(0xFFA32D2D),
      accent: Color(0xFFE24B4A),
    ),
  };
}

class CarInventoryCard extends StatelessWidget {
  final Map<String, String> car;
  final VoidCallback? onEdit;
  final VoidCallback? onWhatsApp;
  final VoidCallback? onDelete;

  const CarInventoryCard({
    super.key,
    required this.car,
    this.onEdit,
    this.onWhatsApp,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final cfg = CarStatusConfig.of(car['status'] ?? '');

    return Container(
      decoration: BoxDecoration(
        color: AppColor.scaffoldColor(context),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: 0.07)),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── الصورة ──────────────────────────────────────
          Stack(
            children: [
              car['image'] != null && car['image']!.isNotEmpty
                  ? Image.asset(
                      car['image']!,
                      height: 160.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _ImagePlaceholder(),
                    )
                  : _ImagePlaceholder(),

              // Badge فوق الصورة
              Positioned(
                top: 10.h,
                right: 10.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: cfg.bg,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    cfg.label,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: cfg.textColor,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // ── accent bar + المحتوى ─────────────────────────
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(width: 4.w, color: cfg.accent),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(14.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _CardHeader(car: car, cfg: cfg, showBadge: false), // ← Badge اتنقل فوق
                        Gap(8.h),
                        _CardMeta(car: car, context: context),
                        Gap(10.h),
                        const Divider(height: 1),
                        Gap(10.h),
                        _CardFooter(
                          car: car,
                          context: context,
                          onEdit: onEdit,
                          onWhatsApp: onWhatsApp,
                          onDelete: onDelete,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.h,
      width: double.infinity,
      color: AppColor.blackTextColor(context).withValues(alpha: 0.04),
      child: Icon(
        Icons.directions_car_rounded,
        size: 48.sp,
        color: AppColor.blackTextColor(context).withValues(alpha: 0.12),
      ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  final Map<String, String> car;
  final CarStatusConfig cfg;
  final bool showBadge; // ← جديد

  const _CardHeader({required this.car, required this.cfg, this.showBadge = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            car['name'] ?? '',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColor.blackTextColor(context),
              height: 1.3,
            ),
          ),
        ),
        if (showBadge) ...[
          Gap(8.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(color: cfg.bg, borderRadius: BorderRadius.circular(20.r)),
            child: Text(
              cfg.label,
              style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500, color: cfg.textColor),
            ),
          ),
        ],
      ],
    );
  }
}

class _CardMeta extends StatelessWidget {
  final Map<String, String> car;
  final BuildContext context;

  const _CardMeta({required this.car, required this.context});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _MetaItem(icon: Icons.calendar_today_rounded, text: car['year'] ?? ''),
        Gap(14.w),
        _MetaItem(icon: Icons.speed_rounded, text: car['mileage'] ?? ''),
      ],
    );
  }
}

class _MetaItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _MetaItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 13.sp, color: AppColor.blackTextColor(context).withValues(alpha: 0.35)),
        Gap(4.w),
        Text(
          text,
          style: AppTextStyle.bodySmall(
            context,
          ).copyWith(color: AppColor.blackTextColor(context).withValues(alpha: 0.45)),
        ),
      ],
    );
  }
}

class _CardFooter extends StatelessWidget {
  final Map<String, String> car;
  final BuildContext context;
  final VoidCallback? onEdit;
  final VoidCallback? onWhatsApp;
  final VoidCallback? onDelete;

  const _CardFooter({
    required this.car,
    required this.context,
    this.onEdit,
    this.onWhatsApp,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          ' ${car['price'] ?? ''} ${AppLocaleKey.sar.tr()}',
          style: AppTextStyle.bodyMedium(
            context,
          ).copyWith(fontWeight: FontWeight.w600, color: AppColor.blackTextColor(context)),
        ),
        const Spacer(),
        _ActionBtn(icon: Icons.edit_rounded, onTap: onEdit),
        Gap(6.w),
        _ActionBtn(icon: Icons.phone, onTap: onWhatsApp),
        Gap(6.w),
        _ActionBtn(icon: Icons.delete_outline_rounded, onTap: onDelete, isDanger: true),
      ],
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool isDanger;

  const _ActionBtn({required this.icon, this.onTap, this.isDanger = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30.w,
        height: 30.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isDanger
                ? AppColor.redColor(context).withValues(alpha: 0.3)
                : AppColor.blackTextColor(context).withValues(alpha: 0.1),
          ),
        ),
        child: Icon(
          icon,
          size: 14.sp,
          color: isDanger
              ? AppColor.redColor(context)
              : AppColor.blackTextColor(context).withValues(alpha: 0.45),
        ),
      ),
    );
  }
}
