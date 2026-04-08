import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/admin/presentation/screen/widgets/fAQ_item_widget.dart';
import 'package:car/features/admin/presentation/screen/widgets/support_hero_widget.dart';
import 'package:car/features/admin/presentation/screen/widgets/support_section_widget.dart';
import 'package:car/features/admin/presentation/screen/widgets/support_tile_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AdminSupportScreen extends StatelessWidget {
  const AdminSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: CustomAppBar(context, title: Text(AppLocaleKey.supportCenter.tr())),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SupportHeroWidget(),
            Gap(32.h),
            SupportSectionWidget(
              title: AppLocaleKey.adminGuides.tr(),
              items: [
                SupportTileWidget(
                  icon: Icons.menu_book_rounded,
                  title: AppLocaleKey.dashboardOverview.tr(),
                  subtitle: AppLocaleKey.dashboardOverviewDesc.tr(),
                  onTap: () {},
                ),
                SupportTileWidget(
                  icon: Icons.manage_accounts_rounded,
                  title: AppLocaleKey.userManagementGuide.tr(),
                  subtitle: AppLocaleKey.userManagementGuideDesc.tr(),
                  onTap: () {},
                ),
                SupportTileWidget(
                  icon: Icons.inventory_rounded,
                  title: AppLocaleKey.inventoryControl.tr(),
                  subtitle: AppLocaleKey.inventoryControlDesc.tr(),
                  onTap: () {},
                ),
              ],
            ),
            Gap(32.h),
            SupportSectionWidget(
              title: AppLocaleKey.commonQuestions.tr(),
              items: [
                FaqItemWidget(
                  answer: AppLocaleKey.faqSellersRequest.tr(),
                  question: AppLocaleKey.faqSellersRequestAns.tr(),
                ),
                FaqItemWidget(
                  answer: AppLocaleKey.faqAdminPassword.tr(),
                  question: AppLocaleKey.faqAdminPasswordAns.tr(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
