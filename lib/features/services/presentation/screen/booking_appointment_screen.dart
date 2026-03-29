import 'package:animate_do/animate_do.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class BookingAppointmentScreen extends StatefulWidget {
  const BookingAppointmentScreen({super.key});

  @override
  State<BookingAppointmentScreen> createState() => _BookingAppointmentScreenState();
}

class _BookingAppointmentScreenState extends State<BookingAppointmentScreen> {
  String? selectedService;
  DateTime selectedDate = DateTime.now().add(const Duration(days: 1));
  String selectedTime = '10:00 AM';

  final List<String> services = [
    AppLocaleKey.periodicMaintenance.tr(),
    AppLocaleKey.oilChange.tr(),
    AppLocaleKey.comprehensiveInspection.tr(),
    AppLocaleKey.polishingAndCleaning.tr(),
    AppLocaleKey.paintInspection.tr(),
    AppLocaleKey.repairFaults.tr(),
  ];

  final List<String> timeSlots = [
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '01:00 PM',
    '02:00 PM',
    '04:00 PM',
    '05:00 PM',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 150.h,
            pinned: true,
            backgroundColor: AppColor.appBarColor(context),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.close_rounded, color: AppColor.appBarTextColor(context)),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                AppLocaleKey.bookNewAppointment.tr(),
                style: AppTextStyle.titleMedium(
                  context,
                ).copyWith(color: AppColor.appBarTextColor(context), fontWeight: FontWeight.bold),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColor.primaryColor(context),
                      AppColor.primaryColor(context).withValues(alpha: 0.8),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInDown(child: _buildSectionTitle(AppLocaleKey.selectService.tr())),
                  Gap(16.h),
                  FadeInDown(
                    delay: const Duration(milliseconds: 100),
                    child: SizedBox(
                      height: 110.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: services.length,
                        itemBuilder: (context, index) {
                          bool isSelected = selectedService == services[index];
                          return GestureDetector(
                            onTap: () => setState(() => selectedService = services[index]),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 100.w,
                              margin: EdgeInsets.only(left: 12.w),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColor.primaryColor(context)
                                    : AppColor.secondAppColor(context),
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColor.whiteColor(context).withValues(alpha: 0.24)
                                      : AppColor.blackTextColor(context).withValues(alpha: 0.05),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    _getServiceIcon(services[index]),
                                    color: isSelected
                                        ? AppColor.whiteColor(context)
                                        : AppColor.blackTextColor(context).withValues(alpha: 0.38),
                                    size: 28.sp,
                                  ),
                                  Gap(8.h),
                                  Text(
                                    services[index],
                                    style: TextStyle(
                                      color: isSelected
                                          ? AppColor.whiteColor(context)
                                          : AppColor.blackTextColor(
                                              context,
                                            ).withValues(alpha: 0.38),
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Gap(32.h),
                  FadeInDown(
                    delay: const Duration(milliseconds: 200),
                    child: _buildSectionTitle(AppLocaleKey.appointmentDate.tr()),
                  ),
                  Gap(16.h),
                  FadeInDown(
                    delay: const Duration(milliseconds: 300),
                    child: GestureDetector(
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 60)),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.fromSeed(
                                  seedColor: AppColor.primaryColor(context),
                                  primary: AppColor.primaryColor(context),
                                  onPrimary: Colors.white,
                                  surface: AppColor.secondAppColor(context),
                                  onSurface: AppColor.blackTextColor(context),
                                  brightness: Theme.of(context).brightness,
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (date != null) setState(() => selectedDate = date);
                      },
                      child: Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: AppColor.secondAppColor(context),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: 0.05)),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_today_rounded,
                              color: AppColor.blackTextColor(context),
                            ),
                            Gap(12.w),
                            Text(
                              DateFormat('EEEE, d MMMM yyyy', 'ar').format(selectedDate),
                              style: TextStyle(
                                color: AppColor.blackTextColor(context),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.edit_calendar_rounded,
                              color: AppColor.blackTextColor(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Gap(32.h),
                  FadeInDown(
                    delay: const Duration(milliseconds: 400),
                    child: _buildSectionTitle(AppLocaleKey.availableTime.tr()),
                  ),
                  Gap(16.h),
                  FadeInDown(
                    delay: const Duration(milliseconds: 500),
                    child: Wrap(
                      spacing: 12.w,
                      runSpacing: 12.h,
                      children: timeSlots.map((time) {
                        bool isSelected = selectedTime == time;
                        return GestureDetector(
                          onTap: () => setState(() => selectedTime = time),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColor.primaryColor(context)
                                  : AppColor.secondAppColor(context),
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: isSelected
                                    ? AppColor.blackTextColor(context).withValues(alpha: 0.24)
                                    : AppColor.blackTextColor(context).withValues(alpha: 0.05),
                              ),
                            ),
                            child: Text(
                              time,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : AppColor.blackTextColor(context).withValues(alpha: 0.60),
                                fontWeight: FontWeight.bold,
                                fontSize: 13.sp,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Gap(32.h),
                  FadeInDown(
                    delay: const Duration(milliseconds: 600),
                    child: _buildSectionTitle(AppLocaleKey.additionalDetails.tr()),
                  ),
                  Gap(16.h),
                  FadeInDown(
                    delay: const Duration(milliseconds: 700),
                    child: _buildTextField(AppLocaleKey.plateOrCarTypeHint.tr()),
                  ),
                  Gap(12.h),
                  FadeInDown(
                    delay: const Duration(milliseconds: 800),
                    child: _buildTextField(AppLocaleKey.specialNotesHint.tr(), maxLines: 3),
                  ),
                  Gap(40.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 900),
                    child: _buildConfirmButton(context),
                  ),
                  Gap(50.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: AppColor.blackTextColor(context),
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTextField(String hint, {int maxLines = 1}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.secondAppColor(context),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: 0.05)),
      ),
      child: TextField(
        maxLines: maxLines,
        style: TextStyle(color: AppColor.blackTextColor(context)),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: AppColor.blackTextColor(context).withValues(alpha: 0.38),
            fontSize: 14.sp,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55.h,
      decoration: BoxDecoration(
        color: AppColor.primaryColor(context),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor(context).withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          // TODO: Implement actual booking logic
          _showSuccessBottomSheet(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        ),
        child: Text(
          AppLocaleKey.confirmBooking.tr(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _showSuccessBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.secondAppColor(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.r),
          topRight: Radius.circular(25.r),
        ),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.all(30.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle_rounded, color: Colors.greenAccent, size: 70.sp),
            Gap(20.h),
            Text(
              AppLocaleKey.bookingReceivedSuccess.tr(),
              style: TextStyle(
                color: AppColor.blackTextColor(context),
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(10.h),
            Text(
              AppLocaleKey.teamWillContactSoon.tr(),
              style: TextStyle(color: AppColor.blackTextColor(context).withValues(alpha: 0.70)),
              textAlign: TextAlign.center,
            ),
            Gap(30.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // close sheet
                  Navigator.pop(context); // return to services
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor(context),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                child: Text(
                  AppLocaleKey.ok.tr(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getServiceIcon(String service) {
    if (service == AppLocaleKey.periodicMaintenance.tr()) {
      return Icons.build_rounded;
    }
    if (service == AppLocaleKey.oilChange.tr()) return Icons.oil_barrel_rounded;
    if (service == AppLocaleKey.comprehensiveInspection.tr()) {
      return Icons.fact_check_rounded;
    }
    if (service == AppLocaleKey.polishingAndCleaning.tr()) {
      return Icons.auto_awesome_rounded;
    }
    if (service == AppLocaleKey.paintInspection.tr()) {
      return Icons.format_paint_rounded;
    }
    if (service == AppLocaleKey.repairFaults.tr()) {
      return Icons.car_repair_rounded;
    }
    return Icons.miscellaneous_services_rounded;
  }
}
