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

class ShippingScreen extends StatefulWidget {
  const ShippingScreen({super.key});

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fromCityController = TextEditingController();
  final _toCityController = TextEditingController();
  final _carController = TextEditingController();
  final _notesController = TextEditingController();

  int _selectedCarrierIndex = 1;
  DateTime? _selectedDate;
  bool _expressShipping = false;
  bool _fullInsurance = true;

  @override
  void dispose() {
    _fromCityController.dispose();
    _toCityController.dispose();
    _carController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  double _calculateEstimate() {
    double basePrice = _selectedCarrierIndex == 0 ? 400.0 : 1500.0;

    final from = _fromCityController.text.trim().toLowerCase();
    final to = _toCityController.text.trim().toLowerCase();
    if (from.isNotEmpty && to.isNotEmpty && from != to) {
      basePrice += 450.0;
    }

    if (_expressShipping) {
      basePrice += 250.0;
    }

    if (_fullInsurance) {
      basePrice += 150.0;
    }

    return basePrice;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 2)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
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

  void _bookShipment() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              context.locale.languageCode == 'ar'
                  ? 'يرجى اختيار تاريخ الشحن المفضل.'
                  : 'Please select preferred shipping date.',
            ),
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
                  context.locale.languageCode == 'ar'
                      ? 'تم تسجيل طلب الشحن بنجاح!'
                      : 'Shipping request placed successfully!',
                  style: AppTextStyle.titleMedium(context).copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Gap(8.h),
                Text(
                  context.locale.languageCode == 'ar'
                      ? 'تم تأكيد حجز الشحنة. سيقوم فريق الخدمات اللوجستية بالتواصل معك لتأكيد موعد الاستلام وتفاصيل النقل.'
                      : 'Shipment booking confirmed. Our logistics team will reach out to verify pickup details.',
                  style: AppTextStyle.bodySmall(
                    context,
                  ).copyWith(color: AppColor.greyColor(context)),
                  textAlign: TextAlign.center,
                ),
                Gap(20.h),
                CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
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
    final isAr = context.locale.languageCode == 'ar';

    final carrierTypes = [
      {
        'title': AppLocaleKey.openFlatbed.tr(),
        'desc': isAr
            ? 'نقل مكشوف وسريع مناسب للمسافات الإقليمية'
            : 'Open car carrier for local & regional shipping',
        'icon': Icons.local_shipping_rounded,
        'base': '400',
      },
      {
        'title': AppLocaleKey.closedCarrierVip.tr(),
        'desc': isAr
            ? 'حاوية مغلقة حماية كاملة من الغبار وعوامل الجو'
            : 'Premium enclosed carrier for maximum paint protection',
        'icon': Icons.stars_rounded,
        'base': '1500',
      },
    ];

    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: CustomAppBar(
        context,
        title: Text(
          AppLocaleKey.vipCarShipping.tr(),
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
              // Carrier selection
              FadeInDown(
                duration: const Duration(milliseconds: 500),
                child: Text(
                  AppLocaleKey.truckType.tr(),
                  style: AppTextStyle.titleSmall(context).copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Gap(12.h),

              // Carrier Selection Cards
              Column(
                children: List.generate(carrierTypes.length, (index) {
                  final type = carrierTypes[index];
                  final isSelected = index == _selectedCarrierIndex;
                  return FadeInUp(
                    delay: Duration(milliseconds: 100 * index),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCarrierIndex = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: EdgeInsets.only(bottom: 12.h),
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColor.primaryColor(context).withValues(alpha: 0.08)
                              : AppColor.secondAppColor(context),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: isSelected
                                ? AppColor.primaryColor(context)
                                : AppColor.borderColor(context).withValues(alpha: 0.3),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColor.primaryColor(context)
                                    : AppColor.scaffoldColor(context),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                type['icon'] as IconData,
                                color: isSelected
                                    ? AppColor.whiteColor(context)
                                    : AppColor.primaryColor(context),
                                size: 22.sp,
                              ),
                            ),
                            Gap(16.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    type['title'] as String,
                                    style: AppTextStyle.bodyMedium(context).copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.blackTextColor(context),
                                    ),
                                  ),
                                  Gap(4.h),
                                  Text(
                                    type['desc'] as String,
                                    style: AppTextStyle.bodySmall(
                                      context,
                                    ).copyWith(fontSize: 10.sp, color: AppColor.greyColor(context)),
                                  ),
                                ],
                              ),
                            ),
                            Gap(10.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  isAr ? 'يبدأ من' : 'Starts from',
                                  style: AppTextStyle.bodySmall(
                                    context,
                                  ).copyWith(fontSize: 8.sp, color: AppColor.greyColor(context)),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      type['base'] as String,
                                      style: AppTextStyle.bodyLarge(context).copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.primaryColor(context),
                                      ),
                                    ),
                                    Gap(2.w),
                                    Text(
                                      AppLocaleKey.sar.tr(),
                                      style: AppTextStyle.bodySmall(context).copyWith(
                                        fontSize: 8.sp,
                                        color: AppColor.greyColor(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),

              Gap(16.h),

              // From / To Locations
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocaleKey.shippingDetails.tr(),
                      style: AppTextStyle.titleSmall(context).copyWith(fontWeight: FontWeight.bold),
                    ),
                    Gap(12.h),
                    Row(
                      children: [
                        Expanded(
                          child: CustomFormField(
                            controller: _fromCityController,
                            title: AppLocaleKey.departurePoint.tr(),
                            hintText: isAr ? 'المدينة (مثلاً: الرياض)' : 'City (e.g. Riyadh)',
                            onChanged: (val) => setState(() {}),
                            validator: (value) => value == null || value.isEmpty
                                ? AppLocaleKey.validateEmpty.tr()
                                : null,
                          ),
                        ),
                        Gap(12.w),
                        Expanded(
                          child: CustomFormField(
                            controller: _toCityController,
                            title: AppLocaleKey.arrivalDestination.tr(),
                            hintText: isAr ? 'المدينة (مثلاً: جدة)' : 'City (e.g. Jeddah)',
                            onChanged: (val) => setState(() {}),
                            validator: (value) => value == null || value.isEmpty
                                ? AppLocaleKey.validateEmpty.tr()
                                : null,
                          ),
                        ),
                      ],
                    ),
                    Gap(16.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: CustomFormField(
                            controller: _carController,
                            title: AppLocaleKey.carTypeModel.tr(),
                            hintText: isAr ? 'مرسيدس، كامري...' : 'Brand, model...',
                            validator: (value) => value == null || value.isEmpty
                                ? AppLocaleKey.validateEmpty.tr()
                                : null,
                          ),
                        ),
                        Gap(12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocaleKey.preferredShippingDate.tr(),
                                style: AppTextStyle.formTitleStyle(context),
                              ),
                              Gap(5.h),
                              InkWell(
                                onTap: () => _selectDate(context),
                                borderRadius: BorderRadius.circular(5.r),
                                child: Container(
                                  height: 48.h,
                                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                                  decoration: BoxDecoration(
                                    color: AppColor.textFormFillColor(context),
                                    borderRadius: BorderRadius.circular(5.r),
                                    border: Border.all(
                                      color: AppColor.textFormBorderColor(context),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _selectedDate == null
                                            ? '2026-05-20'
                                            : DateFormat('yyyy-MM-dd').format(_selectedDate!),
                                        style: AppTextStyle.bodyMedium(context).copyWith(
                                          color: _selectedDate == null
                                              ? AppColor.hintColor(context)
                                              : AppColor.blackTextColor(context),
                                        ),
                                      ),
                                      Icon(
                                        Icons.calendar_month_rounded,
                                        color: AppColor.primaryColor(context),
                                        size: 18.sp,
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
                  ],
                ),
              ),

              Gap(24.h),

              // Options Switches
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: AppColor.secondAppColor(context),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AppColor.borderColor(context).withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    children: [
                      SwitchListTile(
                        value: _expressShipping,
                        onChanged: (val) {
                          setState(() {
                            _expressShipping = val;
                          });
                        },
                        title: Text(
                          isAr ? 'شحن سريع (خلال 24 ساعة)' : 'Express Shipping (within 24 hrs)',
                          style: AppTextStyle.bodyMedium(
                            context,
                          ).copyWith(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          isAr
                              ? 'أولوية قصوى وجدول زمني أسرع (+250 ر.س)'
                              : 'Top priority dispatch & transport (+250 SAR)',
                          style: AppTextStyle.bodySmall(
                            context,
                          ).copyWith(fontSize: 10.sp, color: AppColor.greyColor(context)),
                        ),
                        activeThumbColor: AppColor.primaryColor(context),
                      ),
                      const Divider(),
                      SwitchListTile(
                        value: _fullInsurance,
                        onChanged: (val) {
                          setState(() {
                            _fullInsurance = val;
                          });
                        },
                        title: Text(
                          isAr ? 'تأمين شامل على النقل' : 'Comprehensive Transit Insurance',
                          style: AppTextStyle.bodyMedium(
                            context,
                          ).copyWith(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          isAr
                              ? 'تغطية مالية كاملة لسلامة سيارتك (+150 ر.س)'
                              : 'Full protection coverage for transit (+150 SAR)',
                          style: AppTextStyle.bodySmall(
                            context,
                          ).copyWith(fontSize: 10.sp, color: AppColor.greyColor(context)),
                        ),
                        activeThumbColor: AppColor.primaryColor(context),
                      ),
                    ],
                  ),
                ),
              ),

              Gap(24.h),

              // Dynamic Cost Estimation Card
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColor.primaryColor(context).withValues(alpha: .12),
                        AppColor.primaryColor(context).withValues(alpha: 0.04),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: AppColor.primaryColor(context).withValues(alpha: 0.2),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        isAr ? 'التكلفة التقديرية للشحن' : 'Estimated Shipping Cost',
                        style: AppTextStyle.bodyMedium(context).copyWith(
                          color: AppColor.primaryColor(context),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            _calculateEstimate().toStringAsFixed(0),
                            style: TextStyle(
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w900,
                              color: AppColor.blackTextColor(context),
                              letterSpacing: -1,
                            ),
                          ),
                          Gap(6.w),
                          Text(
                            AppLocaleKey.sar.tr(),
                            style: AppTextStyle.bodyMedium(
                              context,
                            ).copyWith(color: AppColor.greyColor(context)),
                          ),
                        ],
                      ),
                      Gap(6.h),
                      Text(
                        isAr
                            ? '* التكلفة نهائية وشاملة للتأمين والضرائب'
                            : '* Price includes transit insurance & taxes',
                        style: AppTextStyle.bodySmall(
                          context,
                        ).copyWith(fontSize: 9.sp, color: AppColor.greyColor(context)),
                      ),
                    ],
                  ),
                ),
              ),

              Gap(32.h),

              // Submit Button
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                child: CustomButton(onPressed: _bookShipment, text: AppLocaleKey.bookShipment.tr()),
              ),
              Gap(30.h),
            ],
          ),
        ),
      ),
    );
  }
}
