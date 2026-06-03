import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CarDetailingScreen extends StatefulWidget {
  const CarDetailingScreen({super.key});

  @override
  State<CarDetailingScreen> createState() => _CarDetailingScreenState();
}

class _CarDetailingScreenState extends State<CarDetailingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _carModelController = TextEditingController();
  final _notesController = TextEditingController();

  int _selectedPackageIndex = 2; // Default to Nano Ceramic
  int _selectedCarSizeIndex = 1; // Default to Sedan

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void dispose() {
    _carModelController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 60)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColor.primaryColor(context),
              onPrimary: AppColor.whiteColor(context),
              onSurface: AppColor.blackTextColor(context),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColor.primaryColor(context),
              onPrimary: AppColor.whiteColor(context),
              onSurface: AppColor.blackTextColor(context),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _bookAppointment() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDate == null || _selectedTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocaleKey.pleaseSelectDateAndTime.tr()),
            backgroundColor: AppColor.redColor(context),
          ),
        );
        return;
      }

      showDialog(
        context: context,
        builder: (context) => FadeInUp(
          duration: const Duration(milliseconds: 300),
          child: AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
            backgroundColor: AppColor.cardColor(context),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle_outline_rounded,
                  color: AppColor.greenColor(context),
                  size: 60.sp,
                ),
                Gap(16.h),
                Text(
                  AppLocaleKey.bookingReceivedSuccess.tr(),
                  style: AppTextStyle.titleMedium(context).copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Gap(8.h),
                Text(
                  AppLocaleKey.teamWillContactSoon.tr(),
                  style: AppTextStyle.bodySmall(
                    context,
                  ).copyWith(color: AppColor.greyColor(context)),
                  textAlign: TextAlign.center,
                ),
                Gap(20.h),
                CustomButton(
                  onPressed: () {
                    Navigator.pop(context); // Close dialog
                    Navigator.pop(context); // Go back
                  },
                  text: AppLocaleKey.ok.tr(),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final packages = [
      {
        'title': AppLocaleKey.comprehensivePolish.tr(),
        'desc': AppLocaleKey.paintCorrectionDesc.tr(),
        'price': '350',
        'icon': Icons.brush_rounded,
        'color': const Color(0xFFF59E0B),
      },
      {
        'title': AppLocaleKey.deepInteriorClean.tr(),
        'desc': AppLocaleKey.steamCleaningDesc.tr(),
        'price': '150',
        'icon': Icons.layers_rounded,
        'color': const Color(0xFF10B981),
      },
      {
        'title': AppLocaleKey.nanoCeramicTitle.tr(),
        'desc': AppLocaleKey.nanoCeramicDesc.tr(),
        'price': '999',
        'icon': Icons.auto_awesome_rounded,
        'color': const Color(0xFFEC4899),
      },
      {
        'title': AppLocaleKey.fullPpfShield.tr(),
        'desc': AppLocaleKey.selfHealingPpfDesc.tr(),
        'price': '3499',
        'icon': Icons.security_rounded,
        'color': const Color(0xFF3B82F6),
      },
    ];

    final carSizes = [
      {'title': AppLocaleKey.sizeSmall.tr(), 'icon': Icons.directions_car_rounded},
      {'title': AppLocaleKey.sizeMedium.tr(), 'icon': Icons.airport_shuttle_rounded},
      {'title': AppLocaleKey.sizeLarge.tr(), 'icon': Icons.local_taxi_rounded},
    ];

    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: CustomAppBar(
        context,
        title: Text(
          AppLocaleKey.showroomShine.tr(),
          style: AppTextStyle.titleMedium(context).copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Intro
              FadeInDown(
                duration: const Duration(milliseconds: 500),
                child: Text(
                  AppLocaleKey.chooseCarePackage.tr(),
                  style: AppTextStyle.titleSmall(context).copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Gap(12.h),

              // Horizontal Packages Carousel
              SizedBox(
                height: 180.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: packages.length,
                  itemBuilder: (context, index) {
                    final pkg = packages[index];
                    final isSelected = index == _selectedPackageIndex;
                    return FadeInRight(
                      delay: Duration(milliseconds: 100 * index),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedPackageIndex = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 170.w,
                          margin: EdgeInsets.only(right: 12.w, bottom: 8.h),
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColor.primaryColor(context)
                                : AppColor.secondAppColor(context),
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: isSelected
                                  ? AppColor.primaryColor(context)
                                  : AppColor.borderColor(context).withValues(alpha: 0.3),
                              width: 1.5,
                            ),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: AppColor.primaryColor(context).withValues(alpha: 0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ]
                                : null,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                pkg['icon'] as IconData,
                                color: isSelected
                                    ? AppColor.whiteColor(context)
                                    : pkg['color'] as Color,
                                size: 28.sp,
                              ),
                              const Spacer(),
                              Text(
                                pkg['title'] as String,
                                style: AppTextStyle.bodyMedium(context).copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: isSelected
                                      ? AppColor.whiteColor(context)
                                      : AppColor.blackTextColor(context),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Gap(4.h),
                              Text(
                                pkg['desc'] as String,
                                style: AppTextStyle.bodySmall(context).copyWith(
                                  fontSize: 10.sp,
                                  color: isSelected ? Colors.white70 : AppColor.greyColor(context),
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Spacer(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    pkg['price'] as String,
                                    style: AppTextStyle.titleMedium(context).copyWith(
                                      fontWeight: FontWeight.w900,
                                      color: isSelected
                                          ? AppColor.whiteColor(context)
                                          : AppColor.primaryColor(context),
                                    ),
                                  ),
                                  Gap(4.w),
                                  Text(
                                    AppLocaleKey.sar.tr(),
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: isSelected
                                          ? AppColor.whiteColor(context).withValues(alpha: 0.7)
                                          : AppColor.greyColor(context),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              Gap(24.h),

              // Car Size Selector
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocaleKey.selectVehicleSize.tr(),
                      style: AppTextStyle.titleSmall(context).copyWith(fontWeight: FontWeight.bold),
                    ),
                    Gap(12.h),
                    Row(
                      children: List.generate(carSizes.length, (index) {
                        final size = carSizes[index];
                        final isSelected = index == _selectedCarSizeIndex;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedCarSizeIndex = index;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: EdgeInsets.symmetric(horizontal: 4.w),
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColor.primaryColor(context).withValues(alpha: 0.1)
                                    : AppColor.secondAppColor(context),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColor.primaryColor(context)
                                      : AppColor.borderColor(context).withValues(alpha: 0.3),
                                  width: 1.5,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    size['icon'] as IconData,
                                    color: isSelected
                                        ? AppColor.primaryColor(context)
                                        : AppColor.greyColor(context),
                                    size: 24.sp,
                                  ),
                                  Gap(6.h),
                                  Text(
                                    size['title'] as String,
                                    style: AppTextStyle.bodySmall(context).copyWith(
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                      color: isSelected
                                          ? AppColor.primaryColor(context)
                                          : AppColor.blackTextColor(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),

              Gap(24.h),

              // Booking Details
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocaleKey.preferredAppointment.tr(),
                      style: AppTextStyle.titleSmall(context).copyWith(fontWeight: FontWeight.bold),
                    ),
                    Gap(12.h),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => _selectDate(context),
                            borderRadius: BorderRadius.circular(12.r),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
                              decoration: BoxDecoration(
                                color: AppColor.secondAppColor(context),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: AppColor.borderColor(context).withValues(alpha: 0.3),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today_rounded,
                                    color: AppColor.primaryColor(context),
                                    size: 18.sp,
                                  ),
                                  Gap(10.w),
                                  Text(
                                    _selectedDate == null
                                        ? AppLocaleKey.appointmentDate.tr()
                                        : DateFormat('yyyy-MM-dd', 'en').format(_selectedDate!),
                                    style: AppTextStyle.bodyMedium(context).copyWith(
                                      color: _selectedDate == null
                                          ? AppColor.hintColor(context)
                                          : AppColor.blackTextColor(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Gap(12.w),
                        Expanded(
                          child: InkWell(
                            onTap: () => _selectTime(context),
                            borderRadius: BorderRadius.circular(12.r),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
                              decoration: BoxDecoration(
                                color: AppColor.secondAppColor(context),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: AppColor.borderColor(context).withValues(alpha: 0.3),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.access_time_rounded,
                                    color: AppColor.primaryColor(context),
                                    size: 18.sp,
                                  ),
                                  Gap(10.w),
                                  Text(
                                    _selectedTime == null
                                        ? AppLocaleKey.availableTime.tr()
                                        : _selectedTime!.format(context),
                                    style: AppTextStyle.bodyMedium(context).copyWith(
                                      color: _selectedTime == null
                                          ? AppColor.hintColor(context)
                                          : AppColor.blackTextColor(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Gap(24.h),

              // Form Details
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocaleKey.carDetails.tr(),
                      style: AppTextStyle.titleSmall(context).copyWith(fontWeight: FontWeight.bold),
                    ),
                    Gap(12.h),

                    // Car Type/Model
                    CustomFormField(
                      controller: _carModelController,
                      title: AppLocaleKey.carTypeModel.tr(),
                      hintText: AppLocaleKey.toyotaCamryYearHint.tr(),
                      validator: (value) =>
                          value == null || value.isEmpty ? AppLocaleKey.validateEmpty.tr() : null,
                    ),
                    Gap(16.h),

                    // Special Notes
                    CustomFormField(
                      controller: _notesController,
                      title: AppLocaleKey.additionalNotes.tr(),
                      hintText: AppLocaleKey.rearSeatCleanRequest.tr(),
                      maxLines: 3,
                    ),

                    Gap(32.h),

                    // Book Button
                    CustomButton(
                      onPressed: _bookAppointment,
                      text: AppLocaleKey.bookAppointment.tr(),
                    ),
                    Gap(30.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
