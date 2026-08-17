import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ReservationTermItem {
  final String ar;
  final String en;

  const ReservationTermItem({required this.ar, required this.en});
}

const List<ReservationTermItem> kCarReservationTermsBilingual = [
  ReservationTermItem(
    ar: '1- المبلغ المدفوع لا يرد للضيف مرة أخرى في حال الإلغاء',
    en: '1- The paid deposit amount is non-refundable to the guest under any circumstances in case of cancellation.',
  ),
  ReservationTermItem(
    ar: '2- في حال الحجز تكون شركة ماجد بن وزير وأولاده غير ملزمة بتثبيت سعر السيارة أو وقت التسليم',
    en: '2- Upon reservation, Majid Bin Wazir & Sons Co. is not obligated to lock in the car price or delivery time.',
  ),
  ReservationTermItem(
    ar: '3- مدة التسليم هي سبعة أيام عمل رسمية تبدأ من اليوم التالي لإنتهاء فترة الحجز المذكورة بنموذج الحجز ولسداد الضيف كامل مبلغ السيارة نقداً ويضاف يومين في حالة السداد بشيك أو حوالة',
    en: '3- Delivery duration is seven official working days starting the day after the reservation period ends as specified in the form and upon full cash payment; two extra days are added for check or bank transfer payments.',
  ),
  ReservationTermItem(
    ar: '4- يستثنى من مدة التسليم / عدم توافر لوحات واستمارة لدى إدارة المرور، إيقاف خدمات الضيف، وجود مخالفات مرورية على الضيف، رفض إدارة المرور استخراج لوحات واستمارة لسبب يعود للضيف ووجود الضيف تحت طائلة قانونية للدولة، عدم توقيع الضيف على نموذج ماجد بن وزير وأولاده لاستخراج اللوحات والاستمارة',
    en: '4- Exceptions to delivery time include: unavailability of license plates/registration at Traffic Dept, suspension of guest services, traffic violations on guest, Traffic Dept rejection for guest-related reasons, legal restrictions on guest, or guest failing to sign Majid Bin Wazir & Sons forms.',
  ),
  ReservationTermItem(
    ar: '5- يلتزم ماجد بن وزير وأولاده بدفع مبلغ 150.00 مائة وخمسون ريال للضيف عن كل يوم تأخير في حالة عدم الالتزام بموعد التسليم يستثنى منها ما ذكر في البند رقم 4 أعلاه',
    en: '5- Majid Bin Wazir & Sons is committed to paying SAR 150.00 to the guest for each day of delay in case of failure to meet delivery deadline, excluding reasons mentioned in Item 4 above.',
  ),
  ReservationTermItem(
    ar: '6- يشترط مطابقة وجه المرأة المنقبة على صورة بطاقة الأحوال عند شراءها مركبة جديدة باسمها، وذلك من قبل موظف/ة الصندوق',
    en: '6- Face matching against National ID photo is required for niqab-wearing women purchasing a new vehicle under their name, verified by cashier staff.',
  ),
  ReservationTermItem(
    ar: '7- في حال تفويض استلام المركبة / المركبات أو البطاقة الجمركية / البطاقات الجمركية يعتبر هذا تفويض نهائي لا رجعة فيه وماجد بن وزير وأولاده غير ملتزمة على ما يترتب عليه',
    en: '7- Authorization for receiving vehicle(s) or customs card(s) is considered final and irrevocable, and Majid Bin Wazir & Sons assumes no liability resulting from it.',
  ),
  ReservationTermItem(
    ar: '8- يتم تحديد أرقام الهيكل/الهياكل في حال توفرها من طرف شركة ماجد بن وزير وأولاده بناء على المواصفات المطلوبة من الضيف',
    en: '8- Chassis number(s), when available, are designated by Majid Bin Wazir & Sons Co. based on the guest requested specifications.',
  ),
  ReservationTermItem(
    ar: '9- لا يسمح للضيف الفرد استلام السيارة "بطاقة جمركية" دون استخراج اللوحات والاستمارة',
    en: '9- Individual guests are not permitted to receive a vehicle with a "Customs Card" without issuing license plates and registration.',
  ),
  ReservationTermItem(
    ar: '10- الرقم الضريبي : 311073142900003',
    en: '10- Tax Identification Number (VAT): 311073142900003',
  ),
  ReservationTermItem(
    ar: '11- السعر شامل ضريبة القيمة المضافة ورسوم كفاءة الوقود إن وجدت',
    en: '11- Price includes Value Added Tax (VAT) and fuel efficiency fees if applicable.',
  ),
];

void showReservationTermsBottomSheet(BuildContext context) {
  final isArabic = context.locale.languageCode == 'ar';
  final cardBgColor = AppColor.cardColor(context, listen: false);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    backgroundColor: cardBgColor,
    builder: (ctx) {
      return SafeArea(
        child: Container(
          constraints: BoxConstraints(maxHeight: 0.8.sh),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.gavel_rounded,
                    color: AppColor.primaryColor(ctx),
                    size: 24.sp,
                  ),
                  Gap(10.w),
                  Expanded(
                    child: Text(
                      isArabic ? 'الشروط والأحكام لحجز السيارة' : 'Reservation Terms & Conditions',
                      style: AppTextStyle.titleMedium(ctx).copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColor.blackTextColor(ctx),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: AppColor.greyColor(ctx)),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const Divider(),
              Gap(10.h),
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: kCarReservationTermsBilingual.length,
                  separatorBuilder: (_, _) => Divider(
                    height: 16.h,
                    color: AppColor.borderColor(ctx).withValues(alpha: 0.3),
                  ),
                  itemBuilder: (ctx, index) {
                    final item = kCarReservationTermsBilingual[index];
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 4.h),
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: AppColor.primaryColor(ctx).withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check_circle_outline_rounded,
                            size: 14.sp,
                            color: AppColor.primaryColor(ctx),
                          ),
                        ),
                        Gap(10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.ar,
                                style: AppTextStyle.bodySmall(ctx).copyWith(
                                  color: AppColor.blackTextColor(ctx),
                                  height: 1.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Gap(4.h),
                              Text(
                                item.en,
                                style: AppTextStyle.bodySmall(ctx).copyWith(
                                  color: AppColor.greyColor(ctx),
                                  height: 1.4,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Gap(16.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor(ctx),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                  onPressed: () => Navigator.pop(ctx),
                  child: Text(
                    isArabic ? 'فهمت وحسناً' : 'I Understand',
                    style: AppTextStyle.bodyMedium(ctx).copyWith(
                      color: AppColor.whiteColor(ctx),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class ReservationTermsCheckboxWidget extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const ReservationTermsCheckboxWidget({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColor.primaryColor(context).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: value
              ? AppColor.primaryColor(context)
              : AppColor.borderColor(context).withValues(alpha: 0.5),
          width: value ? 1.5 : 1.0,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
            value: value,
            activeColor: AppColor.primaryColor(context),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.r),
            ),
            onChanged: onChanged,
          ),
          Expanded(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  isArabic ? 'أوافق على ' : 'I agree to the ',
                  style: AppTextStyle.bodySmall(context).copyWith(
                    color: AppColor.blackTextColor(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () => showReservationTermsBottomSheet(context),
                  child: Text(
                    isArabic ? 'الشروط والأحكام الخاصة بالحجز' : 'Terms & Conditions',
                    style: AppTextStyle.bodySmall(context).copyWith(
                      color: AppColor.primaryColor(context),
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColor.primaryColor(context),
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
