import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cars/presentation/widget/car_detail_row.dart';
import 'package:car/features/cars/presentation/widget/inspection_badge_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarInfoTabsWidget extends StatefulWidget {
  final Map<String, dynamic> car;

  const CarInfoTabsWidget({super.key, required this.car});

  @override
  State<CarInfoTabsWidget> createState() => _CarInfoTabsWidgetState();
}

class _CarInfoTabsWidgetState extends State<CarInfoTabsWidget> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Color? _parseArabicColor(String? colorName) {
    if (colorName == null) return null;
    final name = colorName.trim().toLowerCase();
    if (name.contains('أبيض') || name.contains('ابيض')) return Colors.white;
    if (name.contains('أسود') || name.contains('اسود')) return Colors.black;
    if (name.contains('فضي')) return Colors.grey.shade400;
    if (name.contains('رمادي')) return Colors.grey;
    if (name.contains('أحمر') || name.contains('احمر')) return Colors.red;
    if (name.contains('أزرق') || name.contains('ازرق')) return Colors.blue;
    if (name.contains('بيج')) return const Color(0xFFF5F5DC);
    if (name.contains('بني')) return Colors.brown;
    if (name.contains('أخضر') || name.contains('اخضر')) return AppColor.greenColor(context);
    if (name.contains('أصفر') || name.contains('اصفر')) return Colors.yellow;
    if (name.contains('برتقالي')) return Colors.orange;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.car;

    final grName = c['GR_NAME'] ?? c['grName'];
    final groupName = c['GROUP_NAME'] ?? c['groupName'];

    String brandVal = c['brand'] ?? c['MAKE_NAME'] ?? "N/A";
    String typeVal = c['name'] ?? c['MODEL_NAME'] ?? "N/A";
    String categoryVal = groupName ?? c['CATEGORY'] ?? c['category'] ?? "N/A";

    if (grName != null && grName.toString().trim().isNotEmpty) {
      final parts = grName.toString().split('-').map((e) => e.trim()).toList();
      if (parts.isNotEmpty) {
        brandVal = parts.first;
        if (parts.length > 1) {
          typeVal = parts[1];
        }
      }
    }

    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: AppColor.primaryColor(context),
          unselectedLabelColor: AppColor.greyColor(context),
          labelStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 13.sp),
          indicatorColor: AppColor.primaryColor(context),
          indicatorWeight: 3,
          tabs: [
            Tab(text: AppLocaleKey.info_tab_car_info.tr()),
            Tab(text: AppLocaleKey.info_tab_inspection_report.tr()),
          ],
        ),
        if (_tabController.index == 0)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent, // remove expansion tile border
              ),
              child: ExpansionTile(
                initiallyExpanded: true,
                iconColor: AppColor.primaryColor(context),
                collapsedIconColor: AppColor.primaryColor(context),
                tilePadding: EdgeInsets.zero,
                title: Text(
                  AppLocaleKey.info_tab_car_details.tr(),
                  style: AppTextStyle.bodyLarge(
                    context,
                  ).copyWith(fontWeight: FontWeight.w900, color: AppColor.blackTextColor(context)),
                ),
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                      color: AppColor.whiteColor(context),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      children: [
                        CarDetailRow(
                          label: AppLocaleKey.info_tab_brand.tr(),
                          value: brandVal,
                          icon: Icons.vpn_key_rounded,
                        ),
                        CarDetailRow(
                          label: AppLocaleKey.info_tab_type.tr(),
                          value: typeVal,
                          icon: Icons.directions_car_rounded,
                        ),
                        CarDetailRow(
                          label: AppLocaleKey.info_tab_model.tr(),
                          value: '${c['year'] ?? c['MAKE_YEAR'] ?? "N/A"}',
                          icon: Icons.calendar_today_rounded, // Alternative to mirror
                        ),
                        CarDetailRow(
                          label: AppLocaleKey.info_tab_category.tr(),
                          value: categoryVal,
                          icon: Icons.drag_handle_rounded,
                        ),
                        CarDetailRow(
                          label: AppLocaleKey.info_tab_interior_color.tr(),
                          value: '${c['interior_color'] ?? c['INTERIOR_COLOR'] ?? "N/A"}',
                          icon: Icons.event_seat_rounded,
                          colorBox: _parseArabicColor(
                            '${c['interior_color'] ?? c['INTERIOR_COLOR']}',
                          ),
                        ),
                        CarDetailRow(
                          label: AppLocaleKey.info_tab_exterior_color.tr(),
                          value: '${c['Color'] ?? c['BODY_COLOR'] ?? "N/A"}',
                          icon: Icons.color_lens_rounded,
                          colorBox: _parseArabicColor('${c['Color'] ?? c['BODY_COLOR']}'),
                        ),
                        CarDetailRow(
                          label: AppLocaleKey.info_tab_import.tr(),
                          value: '${c['import'] ?? AppLocaleKey.info_tab_saudi.tr()}',
                          icon: Icons.reply_all_rounded,
                        ),
                        CarDetailRow(
                          label: AppLocaleKey.info_tab_fuel_type.tr(),
                          value: '${c['FUEL_TYPE'] ?? AppLocaleKey.info_tab_gasoline.tr()}',
                          icon: Icons.local_gas_station_rounded,
                          isLast: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: InspectionBadgeWidget(),
          ),
      ],
    );
  }
}
