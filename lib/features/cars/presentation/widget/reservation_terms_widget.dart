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
    ar: '2- في حال الحجز يكون هاجد  بن وزير وأولاده غير ملزم بتثبيت سعر السيارة أو وقت التسليم',
    en: '2- Upon reservation, Majid Bin Wazir & Sons is not obligated to lock in the car price or delivery time.',
  ),
  ReservationTermItem(
    ar: '3- مدة التسليم هي سبعة ايام عمل رسمية تبدأ من اليوم التالي لإنتهاء فترة الحجز المذكورة بنموذج الحجز ولسداد الضيف كامل مبلغ السيارة نقدأ ويضاف يومين في حالة السداد بشيك او حوالة',
    en: '3- Delivery duration is seven official working days starting the day after the reservation period ends as specified in the form and upon full cash payment; two extra days are added for check or bank transfer payments.',
  ),
  ReservationTermItem(
    ar: '4- يستثني من مدة التسليم / عدم توافر لوحات و استمارة لدى إدارة المرور، ايقاف خدمات الضيف، وجود مخالفات مرورية على الضيف، أو رفض إدارة المرور إستخراج لوحات واستمارة لسبب يعود للضيف ووجود الضيف تحت طائلة قانونية للدولة، وعدم توقيع الضيف على نموذج هاجد  بن وزير وأولاده لإستخراج اللوحات والإستمارة',
    en: '4- Exceptions to delivery time include: unavailability of license plates/registration at Traffic Dept, suspension of guest services, traffic violations on guest, Traffic Dept rejection for guest-related reasons, legal restrictions on guest, or guest failing to sign Majid Bin Wazir & Sons forms.',
  ),
  ReservationTermItem(
    ar: '5- يلتزم هاجد  بن وزير وأولاده بدفع مبلغ 150.00 مائة وخمسون ريال للضيف عن كل يوم تأخير في حالة عدم الالتزام بموعد التسليم ويستثنى منها ما ذكر في البند رقم 4 أعلاه',
    en: '5- Majid Bin Wazir & Sons is committed to paying SAR 150.00 to the guest for each day of delay in case of failure to meet delivery deadline, excluding reasons mentioned in Item 4 above.',
  ),
  ReservationTermItem(
    ar: '6- مدة الاتفاقية (5) أيام فقط ، وبعد هذه المدة تلغى.',
    en: '6- The agreement duration is (5) days only, after which it will be cancelled.',
  ),
  ReservationTermItem(
    ar: '7- يشترط مطابقة وجه المرأة المنقبة على صورة بطاقة الأحوال عند شراءها مركبة جديدة بإسمها، وذلك من قبل موظف/ة الصندوق',
    en: '7- Face matching against National ID photo is required for niqab-wearing women purchasing a new vehicle under their name, verified by cashier staff.',
  ),
  ReservationTermItem(
    ar: '8- في حال تفويض استلام المركبة / المركبات أو البطاقة الجمركية / البطاقات الجمركية يعتبر هذا تفويض نهائي لا رجعة فيه وهاجد  بن وزير وأولاده غير مسؤولة على ما يترتب عليه',
    en: '8- Authorization for receiving vehicle(s) or customs card(s) is considered final and irrevocable, and Majid Bin Wazir & Sons assumes no liability resulting from it.',
  ),
  ReservationTermItem(
    ar: '9- لا يسمح للضيف الفرد استلام السيارة "بطاقة جمركية" دون استخراج اللوحات والاستمارة',
    en: '9- Individual guests are not permitted to receive a vehicle with a "Customs Card" without issuing license plates and registration.',
  ),
  ReservationTermItem(
    ar: '10- قد تختلف المواصفات المذكورة بسبب خطأ مطبعي ويلتزم بالمواصفات المستوردة حينها للسوق السعودي.',
    en: '10- Listed specifications may differ due to typographical errors, and specifications imported at that time for the Saudi market shall apply.',
  ),
  ReservationTermItem(
    ar: '11- لمبيعات السيارات للشيكات المرتجعة من البنك سيتم إلغاء حجز المركبة و ليس للضيف المطالبة بالمركبة',
    en: '11- For car sales with bounced bank checks, the vehicle reservation will be cancelled, and the guest has no right to claim the vehicle.',
  ),
  ReservationTermItem(
    ar: '12- لمبيعات السيارات في حال عدم السداد الكامل خلال فترة أقصاها (5) أيام من تاريخ أول سند يتم إلغاء حجز المركبة و ليس للضيف الحق في المطالبة بالمركبة أو المبلغ المدفوع ويحق لنا بيع المركبة بدون موافقة الضيف - ويستثنى من هذا الشرط السيارات التي لا يتوفر لها رقم هيكل ويتم احتساب مدة (5) ايام ابتداءً من تاريخ توفر هيكل للسيارة',
    en: '12- For car sales, in case of non-full payment within a maximum of (5) days from the date of the first receipt, the reservation is cancelled, and the guest has no right to claim the vehicle or paid amount; we reserve the right to sell the vehicle without guest approval. Cars without a chassis number are exempt until a chassis number becomes available.',
  ),
  ReservationTermItem(
    ar: '13- لمبيعات السيارات لعملاء البنوك فقط تعتبر الاتفاقية ملغاة في حال عدم استلام صورة التعميد من البنك خلال يومان من تاريخ توريد دفعة التعاقد',
    en: '13- For bank clients car sales, the agreement is considered void if a copy of the bank approval (taameed) is not received within two days from contract deposit payment.',
  ),
  ReservationTermItem(
    ar: '14- يحق لشركة هاجد  بن وزير وأولاده احتساب رسوم وقوف لمركبة الضيف المتأخر في استلام سيارته بواقع 50 ريالاً في اليوم عن كل يوم بعد مرور ثلاثة أيام عمل من تاريخ استخراج اللوحات والنموذج بعد إخطار الضيف بالهاتف من خلال موظف خدمة الضيوف بالمنشأة أو من خلال إخطارات التطبيق الإلكترونية لشركة هاجد  بن وزير وأولاده ، دون المساس بحق المنشأة في اللجوء إلى السلطات الرسمية والقضائية للحصول على تعويض عادل',
    en: '14- Majid Bin Wazir & Sons Co. reserves the right to charge parking fees of SAR 50 per day for vehicles delayed in pickup after three working days from license plate issuance, following notification via phone or app, without prejudice to legal rights.',
  ),
  ReservationTermItem(
    ar: '15- يتم تحديد ارقام الهيكل/ الهياكل في حال توفرها من طرف شركة هاجد  بن وزير وأولاده بناء على المواصفات المطلوبة من الضيف.',
    en: '15- Chassis number(s), when available, are designated by Majid Bin Wazir & Sons Co. based on the guest requested specifications.',
  ),
  ReservationTermItem(
    ar: '16- الرقم الضريبي : 311073142900003',
    en: '16- Tax Identification Number (VAT): 311073142900003',
  ),
  ReservationTermItem(
    ar: '17- السعر شامل ضريبة القيمة المضافة ورسوم كفاءة الوقود إن وجدت',
    en: '17- Price includes Value Added Tax (VAT) and fuel efficiency fees if applicable.',
  ),
];

void showReservationTermsBottomSheet(BuildContext context) {
  final isArabic = context.locale.languageCode == 'ar';
  final cardBgColor = AppColor.cardColor(context, listen: false);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
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
                  Icon(Icons.gavel_rounded, color: AppColor.primaryColor(ctx), size: 24.sp),
                  Gap(10.w),
                  Expanded(
                    child: Text(
                      isArabic ? 'الشروط والأحكام' : 'Terms & Conditions',
                      style: AppTextStyle.titleMedium(
                        ctx,
                      ).copyWith(fontWeight: FontWeight.bold, color: AppColor.blackTextColor(ctx)),
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                  onPressed: () => Navigator.pop(ctx),
                  child: Text(
                    isArabic ? 'فهمت وحسناً' : 'I Understand',
                    style: AppTextStyle.bodyMedium(
                      ctx,
                    ).copyWith(color: AppColor.whiteColor(ctx), fontWeight: FontWeight.bold),
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

  const ReservationTermsCheckboxWidget({super.key, required this.value, required this.onChanged});

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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
            onChanged: onChanged,
          ),
          Expanded(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  isArabic ? 'أوافق على ' : 'I agree to the ',
                  style: AppTextStyle.bodySmall(
                    context,
                  ).copyWith(color: AppColor.blackTextColor(context), fontWeight: FontWeight.w600),
                ),
                GestureDetector(
                  onTap: () => showReservationTermsBottomSheet(context),
                  child: Text(
                    isArabic ? 'الشروط والأحكام' : 'Terms & Conditions',
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
