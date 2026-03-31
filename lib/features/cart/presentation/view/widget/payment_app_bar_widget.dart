import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const PaymentAppBarWidget({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.scaffoldColor(context),
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColor.blackTextColor(context)),
        onPressed: () => Navigator.pop(context),
        style: IconButton.styleFrom(
          backgroundColor: AppColor.blackTextColor(context).withOpacity(0.05),
        ),
      ),
      title: Text(
        title,
        style: AppTextStyle.titleMedium(
          context,
        ).copyWith(color: AppColor.blackTextColor(context), fontWeight: FontWeight.bold),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16.w),
          child: Icon(Icons.lock_rounded, color: AppColor.primaryColor(context), size: 22.sp),
        ),
      ],
    );
  }
}
