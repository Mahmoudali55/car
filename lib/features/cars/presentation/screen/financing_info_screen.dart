import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cars/presentation/screen/reservation_success_screen.dart';
import 'package:car/features/cars/presentation/widget/financing_contact_form.dart';
import 'package:car/features/cars/presentation/widget/pricing_details_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FinancingInfoScreen extends StatefulWidget {
  final Map<String, dynamic> car;
  final String paymentMethod;
  final double totalPrice;

  const FinancingInfoScreen({
    super.key,
    required this.car,
    required this.paymentMethod,
    required this.totalPrice,
  });

  @override
  State<FinancingInfoScreen> createState() => _FinancingInfoScreenState();
}

class _FinancingInfoScreenState extends State<FinancingInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final ValueNotifier<bool> _whatsappNotifier = ValueNotifier(true);
  final ValueNotifier<String?> _selectedCityNotifier = ValueNotifier('الرياض');

  String get _methodLabel => widget.paymentMethod == 'tamara'
      ? 'متابعة مع تمارا'
      : 'متابعة مع البنك';

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _whatsappNotifier.dispose();
    _selectedCityNotifier.dispose();
    super.dispose();
  }

  void _showPricingDetails() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.85,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: PricingDetailsBottomSheet(
            car: widget.car,
            totalPrice: widget.totalPrice,
          ),
        ),
      ),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ReservationSuccessScreen(
            car: widget.car,
            paymentMethod: widget.paymentMethod,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: AppBar(
        title: Text(
          'المعلومات الشخصية',
          style: AppTextStyle.titleMedium(context).copyWith(
            fontWeight: FontWeight.w900,
            color: AppColor.primaryColor(context),
          ),
        ),
        backgroundColor: AppColor.appBarColor(context),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColor.blackTextColor(context), size: 18.sp),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
            child: Text(
              'إلغاء',
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Compact pricing card
              Container(
                decoration: BoxDecoration(
                  color: AppColor.cardColor(context),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: AppColor.borderColor(context)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'المبلغ الإجمالي',
                            style: AppTextStyle.bodyMedium(context).copyWith(
                              color: AppColor.blackTextColor(context)
                                  .withOpacity(0.7),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.payments_outlined,
                                  size: 18.sp,
                                  color: AppColor.blackTextColor(context)),
                              Gap(6.w),
                              Text(
                                '${widget.totalPrice.toStringAsFixed(2)} SAR',
                                style: AppTextStyle.bodyMedium(context).copyWith(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: _showPricingDetails,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEF2F7),
                          borderRadius:
                              BorderRadius.vertical(bottom: Radius.circular(16.r)),
                        ),
                        child: Center(
                          child: Text(
                            'إعرض التفاصيل',
                            style: TextStyle(
                              color: AppColor.primaryColor(context),
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(32.h),
              Text(
                'ادخل معلوماتك',
                style: AppTextStyle.titleMedium(context).copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 20.sp,
                ),
              ),
              Gap(16.h),
              FinancingContactForm(
                firstNameController: _firstNameController,
                lastNameController: _lastNameController,
                phoneController: _phoneController,
                whatsappNotifier: _whatsappNotifier,
                selectedCityNotifier: _selectedCityNotifier,
              ),
              Gap(120.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 30.h),
        decoration: BoxDecoration(
          color: AppColor.scaffoldColor(context),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: CustomButton(
          height: 56.h,
          width: double.infinity,
          radius: 12.r,
          color: const Color(0xFF3F51B5),
          onPressed: _handleSubmit,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back_rounded, color: Colors.white, size: 18.sp),
              Gap(12.w),
              Text(
                _methodLabel,
                style: AppTextStyle.buttonStyle(context).copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
