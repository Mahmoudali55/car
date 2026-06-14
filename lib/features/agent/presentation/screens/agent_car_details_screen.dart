import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/custom_widgets/custom_loading/custom_loading.dart';
import 'package:car/core/custom_widgets/custom_sar_text.dart';
import 'package:car/core/custom_widgets/custom_toast/custom_toast.dart';
import 'package:car/core/images/app_images.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/common_methods.dart';
import 'package:car/features/agent/data/agent_models.dart';
import 'package:car/features/agent/presentation/screens/widget/custom_agent_car_details_info_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/icon_btn_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/quote_builder_dialog.dart';
import 'package:car/features/home/data/model/add_booking_permission_model.dart';
import 'package:car/features/home/presentation/cubit/home_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class AgentCarDetailsScreen extends StatefulWidget {
  final AgentCar car;

  const AgentCarDetailsScreen({super.key, required this.car});

  @override
  State<AgentCarDetailsScreen> createState() => _AgentCarDetailsScreenState();
}

class _AgentCarDetailsScreenState extends State<AgentCarDetailsScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final availabilityColor = widget.car.getAvailabilityColor(context);
    final isArabic = context.locale.languageCode == 'ar';

    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        final status = state.addBookingPermissionResponseModel;
        if (status.isSuccess) {
          setState(() => _isLoading = false);
          final msg = status.data?.msg ?? (isArabic ? 'تم الحفظ بنجاح' : 'Saved successfully');
          CommonMethods.showToast(message: msg, type: ToastType.success);
          Navigator.pop(context);
        } else if (status.isFailure) {
          setState(() => _isLoading = false);
          CommonMethods.showToast(
            message:
                status.error ??
                (isArabic ? 'حدث خطأ أثناء حفظ الحجز' : 'Error occurred while saving reservation'),
            type: ToastType.error,
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.scaffoldColor(context),

        bottomNavigationBar: widget.car.availability == CarAvailability.available
            ? Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColor.cardColor(context),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.blackColor(context).withValues(alpha: .04),
                      blurRadius: 20,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: CustomButton(
                  onPressed: (widget.car.availability == CarAvailability.available && !_isLoading)
                      ? () {
                          _showReserveDialog();
                        }
                      : null,
                  radius: 14.r,
                  child: _isLoading
                      ? SizedBox(
                          height: 20.h,
                          width: 20.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColor.whiteColor(context),
                          ),
                        )
                      : Text(
                          AppLocaleKey.agentReserveForCustomer.tr(),
                          style: AppTextStyle.bodyMedium(context).copyWith(
                            color: AppColor.whiteColor(context),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                ),
              )
            : null,

        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 340.h,
              backgroundColor: AppColor.appBarColor(context),
              elevation: 0,

              leading: Padding(
                padding: EdgeInsets.all(8.w),
                child: IconBtn(
                  icon: Icons.arrow_back_ios_new_rounded,
                  onTap: () => Navigator.pop(context),
                ),
              ),

              actions: [
                if (widget.car.availability == CarAvailability.available)
                  Padding(
                    padding: EdgeInsets.all(8.w),
                    child: IconBtn(
                      icon: Icons.description_outlined,
                      onTap: () {
                        QuoteBuilderDialog.show(
                          context,
                          carName: widget.car.name,
                          initialPrice: widget.car.price,
                          existingSpecs: {
                            AppLocaleKey.agentYearMade.tr(): widget.car.year,
                            AppLocaleKey.agentSimNumber.tr(): widget.car.mileage,
                            AppLocaleKey.agentColor.tr(): widget.car.color,
                            AppLocaleKey.agentTransmission.tr(): AppLocaleKey.agentAutomatic.tr(),
                          },
                        );
                      },
                    ),
                  ),
              ],

              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      color: AppColor.blueColor(context).withValues(alpha: .08),
                      child: Icon(
                        Icons.directions_car_filled_rounded,
                        size: 150.sp,
                        color: AppColor.blueColor(context).withValues(alpha: .25),
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            AppColor.blackColor(context).withValues(alpha: .75),
                          ],
                        ),
                      ),
                    ),

                    Positioned(
                      left: 20.w,
                      right: 20.w,
                      bottom: 30.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                            decoration: BoxDecoration(
                              color: availabilityColor,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              widget.car.availabilityLabel,
                              style: AppTextStyle.bodySmall(context).copyWith(
                                color: AppColor.whiteColor(context),
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),

                          Gap(12.h),

                          Text(
                            widget.car.brand,
                            style: AppTextStyle.bodyMedium(
                              context,
                            ).copyWith(color: Colors.white70, fontWeight: FontWeight.w700),
                          ),

                          Gap(4.h),

                          Text(
                            widget.car.name,
                            style: AppTextStyle.titleLarge(context).copyWith(
                              color: AppColor.whiteColor(context),
                              fontWeight: FontWeight.w900,
                            ),
                          ),

                          Gap(12.h),

                          ValueWithCurrencyIcon(
                            text:
                                '${NumberFormat('#,##0').format(widget.car.price)} ${AppLocaleKey.sar.tr()}',
                            textStyle: AppTextStyle.titleLarge(context).copyWith(
                              color: AppColor.whiteColor(context),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: CustomAgentCarDetailsInfoWidget(car: widget.car),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showReserveDialog() {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final depositController = TextEditingController(text: '0');
    final formKey = GlobalKey<FormState>();
    final isArabic = context.locale.languageCode == 'ar';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),

      builder: (BuildContext dialogContext) {
        return SizedBox(
          height: 380.h,
          child: Column(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: AppColor.primaryColor(context).withValues(alpha: .1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.bookmark_add_rounded,
                                color: AppColor.primaryColor(context),
                                size: 24.sp,
                              ),
                            ),
                            Gap(12.w),
                            Expanded(
                              child: Text(
                                isArabic ? 'حجز سيارة للعميل' : 'Reserve Car for Customer',
                                style: AppTextStyle.titleMedium(context).copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: AppColor.blackTextColor(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gap(20.h),
                        const Divider(height: 1),
                        Gap(20.h),
                        CustomFormField(
                          controller: nameController,
                          hintText: isArabic ? 'الاسم بالكامل للعميل' : 'Customer Full Name',
                          radius: 12.r,
                          keyboardType: TextInputType.text,
                          prefixIcon: Icon(
                            Icons.person_outline_rounded,
                            color: AppColor.hintColor(context),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return isArabic
                                  ? 'برجاء إدخال اسم العميل'
                                  : 'Please enter customer name';
                            }
                            return null;
                          },
                        ),
                        Gap(16.h),
                        CustomFormField(
                          controller: phoneController,
                          hintText: isArabic ? 'رقم جوال العميل' : 'Customer Phone Number',
                          radius: 12.r,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          prefixIcon: Icon(
                            Icons.phone_android_rounded,
                            color: AppColor.hintColor(context),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return isArabic
                                  ? 'برجاء إدخال رقم الجوال'
                                  : 'Please enter phone number';
                            }
                            if (value.trim().length < 10) {
                              return isArabic
                                  ? 'رقم الجوال يجب أن يكون 10 أرقام'
                                  : 'Phone number must be 10 digits';
                            }
                            return null;
                          },
                        ),
                        Gap(16.h),
                        CustomFormField(
                          controller: depositController,
                          hintText: isArabic
                              ? 'مبلغ العربون (اختياري)'
                              : 'Deposit Amount (Optional)',
                          radius: 12.r,
                          keyboardType: TextInputType.number,
                          prefixIcon: Icon(
                            Icons.payments_outlined,
                            color: AppColor.hintColor(context),
                          ),
                          suffixIcon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AppImages.sar,
                                width: 15.w,
                                height: 15.h,
                                colorFilter: ColorFilter.mode(
                                  AppColor.blackColor(context),
                                  BlendMode.srcIn,
                                ),
                              ),
                            ],
                          ),
                          validator: (value) {
                            if (value != null && value.trim().isNotEmpty) {
                              final amount = double.tryParse(value.trim());
                              if (amount == null) {
                                return isArabic
                                    ? 'الرجاء إدخال رقم صحيح'
                                    : 'Please enter a valid number';
                              }
                              if (amount < 0) {
                                return isArabic
                                    ? 'المبلغ لا يمكن أن يكون سالباً'
                                    : 'Amount cannot be negative';
                              }
                              if (amount > widget.car.price) {
                                return isArabic
                                    ? 'المبلغ لا يمكن أن يتجاوز سعر السيارة'
                                    : 'Amount cannot exceed the car price';
                              }
                            }
                            return null;
                          },
                        ),
                        Gap(24.h),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () => Navigator.pop(dialogContext),
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 14.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                    side: BorderSide(color: AppColor.borderColor(context)),
                                  ),
                                ),
                                child: Text(
                                  isArabic ? 'إلغاء' : 'Cancel',
                                  style: AppTextStyle.bodyMedium(context).copyWith(
                                    color: AppColor.greyColor(context),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Gap(12.w),
                            Expanded(
                              child: CustomButton(
                                radius: 12.r,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    final name = nameController.text.trim();
                                    final phone = phoneController.text.trim();
                                    final deposit =
                                        double.tryParse(depositController.text.trim()) ?? 0.0;
                                    Navigator.pop(dialogContext);
                                    _submitReservation(
                                      customerName: name,
                                      customerPhone: phone,
                                      depositAmount: deposit,
                                    );
                                  }
                                },
                                child: _isLoading
                                    ? CustomLoading(color: AppColor.whiteColor(context))
                                    : Text(
                                        isArabic ? 'تأكيد الحجز' : 'Confirm Reservation',
                                        style: AppTextStyle.bodyMedium(context).copyWith(
                                          color: AppColor.whiteColor(context),
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _submitReservation({
    required String customerName,
    required String customerPhone,
    required double depositAmount,
  }) {
    setState(() => _isLoading = true);

    final todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final futureDateStr = DateFormat(
      'yyyy-MM-dd',
    ).format(DateTime.now().add(const Duration(days: 1)));

    final itemCode = widget.car.itemCode;
    final itemName = widget.car.itemName;
    final chassisNo = widget.car.chassisNo;
    final storeCodeVal = int.tryParse(widget.car.storeCode) ?? 1;

    final model = AddBookingPermissionModel(
      lpoNos: '',
      lpono: '',
      listNo: 0,
      analytical: '',
      customerNo: 5,
      represCode: 1,
      fDate: todayStr,
      lDate: futureDateStr,
      lpoDate: todayStr,
      storeCode: storeCodeVal,
      taamedNo: '',
      payCond: '',
      guarFinal: 0,
      notes: 'حجز سيارة كاش - $customerName ($customerPhone)',
      userName: HiveMethods.getUserName() ?? '',
      subLpo: [
        SubLpoModel(
          itemCode: itemCode,
          itemName: itemName,
          chassisNo: chassisNo,
          price: widget.car.price,
          advancedAmount: depositAmount,
          lpoNo: '',
          lpoType: 3,
          storeCode: storeCodeVal,
          transDate: todayStr,
          fDate: todayStr,
          lDate: futureDateStr,
          userName: HiveMethods.getUserName() ?? '',
        ),
      ],
    );

    context.read<HomeCubit>().getAddBookingPermission(model);
  }
}
