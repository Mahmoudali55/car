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
    ar: '1- المبلغ المدفوع لا يُرد للضيف تحت أي ظرف من الظروف في حال الإلغاء.',
    en: '1- The paid amount is non-refundable to the guest under any circumstances in case of cancellation.',
  ),
  ReservationTermItem(
    ar: '2- عند الحجز، تكون شركة هاجد بن وزير وأولاده ملزمة بتثبيت سعر السيارة طوال فترة الحجز، وهي (24) ساعة، أو حتى وقت التسليم.',
    en: '2- Upon reservation, Majid Bin Wazir & Sons is obligated to lock in the car price throughout the reservation period, which is (24) hours, or until the delivery time.',
  ),
  ReservationTermItem(
    ar: '3- مدة التسليم ثلاثة أيام عمل رسمية، تبدأ من اليوم التالي لسداد الضيف كامل مبلغ السيارة نقداً، ويُضاف يومان في حال السداد بشيك أو حوالة.',
    en: '3- Delivery duration is three official working days, starting the day after the guest pays the full car amount in cash; two extra days are added for payment by check or bank transfer.',
  ),
  ReservationTermItem(
    ar: '4- يُستثنى من مدة التسليم: عدم توافر اللوحات والاستمارة لدى إدارة المرور، إيقاف خدمات الضيف، وجود مخالفات مرورية على الضيف، رفض إدارة المرور استخراج اللوحات والاستمارة لسبب يعود للضيف، وجود الضيف تحت طائلة قانونية للدولة، أو عدم توقيع الضيف على نموذج شركة هاجد بن وزير وأولاده لاستخراج اللوحات والاستمارة.',
    en: '4- Exceptions to the delivery period include: unavailability of plates/registration at the Traffic Department, suspension of the guest\'s services, traffic violations against the guest, the Traffic Department refusing to issue plates/registration for a reason attributable to the guest, the guest being under legal restriction by the state, or the guest failing to sign Majid Bin Wazir & Sons\' form for issuing plates and registration.',
  ),
  ReservationTermItem(
    ar: '5- تلتزم شركة هاجد بن وزير وأولاده بدفع مبلغ (150) مائة وخمسين ريالاً للضيف عن كل يوم تأخير في حال عدم الالتزام بموعد التسليم، ويُستثنى من ذلك ما ورد في البند رقم (4) أعلاه.',
    en: '5- Majid Bin Wazir & Sons is committed to paying the guest SAR 150 (one hundred fifty riyals) for each day of delay in failing to meet the delivery deadline, excluding the cases mentioned in Item (4) above.',
  ),
  ReservationTermItem(
    ar: '6- مدة الاتفاقية (3) أيام فقط، وبعد انقضاء هذه المدة تُعد ملغاة.',
    en: '6- The agreement is valid for (3) days only, after which it is considered cancelled.',
  ),
  ReservationTermItem(
    ar: '7- يُشترط مطابقة وجه المرأة المنتقبة مع صورة بطاقة الهوية الوطنية عند شرائها مركبة جديدة باسمها، ويتم ذلك من قبل موظف/ة الصندوق.',
    en: '7- Face matching against the National ID photo is required for a niqab-wearing woman purchasing a new vehicle under her name, verified by the cashier staff.',
  ),
  ReservationTermItem(
    ar: '8- في حال تفويض استلام المركبة/المركبات أو البطاقة الجمركية/البطاقات الجمركية، يُعد هذا التفويض نهائياً لا رجعة فيه، ولا تتحمل شركة هاجد بن وزير وأولاده أي مسؤولية عما يترتب عليه.',
    en: '8- Authorization to receive the vehicle(s) or customs card(s) is considered final and irrevocable, and Majid Bin Wazir & Sons bears no liability for any resulting consequences.',
  ),
  ReservationTermItem(
    ar: '9- لا يُسمح للضيف الفرد باستلام السيارة ببطاقة جمركية دون استخراج اللوحات والاستمارة.',
    en: '9- Individual guests are not permitted to receive the vehicle with a "Customs Card" without issuing the license plates and registration.',
  ),
  ReservationTermItem(
    ar: '10- قد تختلف المواصفات المذكورة بسبب خطأ مطبعي، ويُعتمد حينها على المواصفات الفعلية المستوردة للسوق السعودي.',
    en: '10- Listed specifications may differ due to a typographical error, in which case the actual specifications imported for the Saudi market shall apply.',
  ),
  ReservationTermItem(
    ar: '11- في مبيعات السيارات، في حال ارتجاع الشيك من البنك، يُلغى حجز المركبة، ولا يحق للضيف المطالبة بها.',
    en: '11- For car sales, in the event a check is returned by the bank, the vehicle reservation is cancelled, and the guest has no right to claim the vehicle.',
  ),
  ReservationTermItem(
    ar: '12- في مبيعات السيارات، في حال عدم السداد الكامل خلال مدة أقصاها (5) أيام من تاريخ أول سند، يُلغى حجز المركبة، ولا يحق للضيف المطالبة بالمركبة أو بالمبلغ المدفوع، ويحق للشركة بيع المركبة دون موافقة الضيف. ويُستثنى من هذا الشرط السيارات التي لا يتوفر لها رقم هيكل، حيث تُحتسب مدة الخمسة أيام ابتداءً من تاريخ توفر رقم الهيكل.',
    en: '12- For car sales, if full payment is not made within a maximum of (5) days from the date of the first receipt, the reservation is cancelled and the guest has no right to claim the vehicle or the amount paid; the company reserves the right to sell the vehicle without the guest\'s approval. Cars without a chassis number are exempt from this condition, with the (5)-day period counted from the date a chassis number becomes available.',
  ),
  ReservationTermItem(
    ar: '13- في مبيعات السيارات لعملاء البنوك فقط، تُعد الاتفاقية ملغاة في حال عدم استلام صورة خطاب التعميد من البنك خلال ثلاثة أيام من تاريخ توريد دفعة التعاقد.',
    en: '13- For bank-client car sales only, the agreement is considered void if a copy of the bank approval letter (ta\'meed) is not received within three days from the date the contract deposit is paid.',
  ),
  ReservationTermItem(
    ar: '14- يحق لشركة هاجد بن وزير وأولاده احتساب رسوم وقوف على مركبة الضيف المتأخر في استلامها بواقع (50) ريالاً عن كل يوم، بعد مرور ثلاثة أيام عمل من تاريخ استخراج اللوحات والاستمارة، وذلك بعد إخطار الضيف هاتفياً من قبل موظف خدمة الضيوف أو عبر إشعارات التطبيق الإلكتروني للشركة، دون الإخلال بحق الشركة في اللجوء إلى الجهات الرسمية والقضائية للحصول على تعويض عادل.',
    en: '14- Majid Bin Wazir & Sons reserves the right to charge a parking fee of SAR 50 per day on a guest\'s vehicle delayed in pickup, starting three working days after the plates and registration are issued, following phone notification from a guest services employee or via the company\'s app notifications, without prejudice to the company\'s right to resort to official and judicial authorities for fair compensation.',
  ),
  ReservationTermItem(
    ar: '15- يتم تحديد رقم/أرقام الهيكل، في حال توفرها، من قبل شركة هاجد بن وزير وأولاده بناءً على المواصفات التي يطلبها الضيف.',
    en: '15- Chassis number(s), when available, are assigned by Majid Bin Wazir & Sons based on the specifications requested by the guest.',
  ),
  ReservationTermItem(
    ar: '16- الرقم الضريبي: 311073142900003',
    en: '16- Tax Identification Number (VAT): 311073142900003',
  ),
  ReservationTermItem(
    ar: '17- السعر شامل ضريبة القيمة المضافة ورسوم كفاءة استهلاك الوقود إن وجدت.',
    en: '17- The price includes Value Added Tax (VAT) and fuel efficiency fees, if applicable.',
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
