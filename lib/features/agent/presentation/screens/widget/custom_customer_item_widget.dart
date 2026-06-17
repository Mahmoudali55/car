import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/agent/data/model/customer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomCustomerItemWidget extends StatelessWidget {
  const CustomCustomerItemWidget({
    super.key,
    required this.customerName,
    required this.phone,
    required this.customer,
  });

  final String customerName;
  final String phone;
  final CustomerModel customer;

  Future<void> _makeCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  Future<void> _launchWhatsApp(String phoneNumber) async {
    final Uri whatsappUri = Uri.parse("https://wa.me/$phoneNumber");
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColor.borderColor(context).withOpacity(.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(18.w),
        child: Column(
          children: [
            Row(
              children: [
                /// Avatar
                Container(
                  width: 58.w,
                  height: 58.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColor.blueColor(context),
                        AppColor.blueColor(context).withOpacity(.7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  child: Center(
                    child: Text(
                      customerName.isNotEmpty ? customerName[0].toUpperCase() : '?',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 22.sp,
                      ),
                    ),
                  ),
                ),

                Gap(14.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        customerName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w800),
                      ),

                      Gap(6.h),

                      Row(
                        children: [
                          Icon(
                            Icons.phone_rounded,
                            size: 15.sp,
                            color: AppColor.greyColor(context),
                          ),
                          Gap(5.w),
                          Text(
                            phone,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: AppColor.greyColor(context),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: AppColor.blueColor(context).withOpacity(.08),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Text(
                    "عميل",
                    style: TextStyle(
                      color: AppColor.blueColor(context),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),

            if (customer.address?.isNotEmpty ?? false) ...[
              Gap(16.h),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: AppColor.scaffoldColor(context),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.location_on_outlined, color: Colors.redAccent, size: 18.sp),
                    Gap(8.w),
                    Expanded(
                      child: Text(
                        customer.address!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            Gap(16.h),

            Divider(height: 1, color: AppColor.borderColor(context).withOpacity(.2)),

            Gap(14.h),

            Row(
              children: [
                Expanded(
                  child: _actionButton(
                    context,
                    Icons.call_rounded,
                    "اتصال",
                    onTap: () => _makeCall(phone),
                  ),
                ),
                Gap(10.w),
                Expanded(
                  child: _actionButton(
                    context,
                    Icons.chat_rounded,
                    "واتساب",
                    onTap: () => _launchWhatsApp(phone),
                  ),
                ),
                Gap(10.w),
                Expanded(
                  child: _actionButton(
                    context,
                    Icons.person_outline,
                    "التفاصيل",
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RoutesName.agentCustomerDetailsScreen,
                        arguments: customer,
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionButton(BuildContext context, IconData icon, String title, {VoidCallback? onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(14.r),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColor.blueColor(context).withOpacity(.06),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18.sp, color: AppColor.blueColor(context)),
            Gap(6.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: AppColor.blueColor(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
