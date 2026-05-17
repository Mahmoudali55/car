import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/extension/context_extension.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ComingSoonScreen extends StatelessWidget {
  final String title;

  const ComingSoonScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: CustomAppBar(
        context,
        elevation: 0,
        centerTitle: true,
        title: Text(
          title,
          style: AppTextStyle.titleMedium(context).copyWith(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColor.blackTextColor(context)),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction_rounded, size: 80, color: AppColor.primaryColor(context)),
            const Gap(20),
            Text(
              context.apiTr(ar: 'قريباً', en: 'Coming Soon'),
              style: AppTextStyle.titleLarge(
                context,
              ).copyWith(fontWeight: FontWeight.bold, color: AppColor.blackTextColor(context)),
            ),
            const Gap(10),
            Text(
              context.apiTr(
                ar: 'نحن نعمل على هذه الميزة. يرجى التحقق مرة أخرى لاحقاً!',
                en: 'We are working on this feature. Please check back later!',
              ),
              textAlign: TextAlign.center,
              style: AppTextStyle.bodyMedium(
                context,
              ).copyWith(color: AppColor.blackTextColor(context).withValues(alpha: 0.6)),
            ),
          ],
        ),
      ),
    );
  }
}
