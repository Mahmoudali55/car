import 'package:animate_do/animate_do.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart' show AppTextStyle;
import 'package:car/features/admin/presentation/screen/widgets/market_trends_chart_widget.dart';
import 'package:car/features/admin/presentation/screen/widgets/transactions_list_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class RevenueReportScreen extends StatelessWidget {
  const RevenueReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Navigator.canPop(context)
            ? IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColor.blackTextColor(context),
                ),
              )
            : null,
        title: Text(
          AppLocaleKey.financialReports.tr(),
          style: AppTextStyle.titleMedium(context).copyWith(
            color: AppColor.blackTextColor(context),
            fontWeight: FontWeight.w900,
            fontSize: 20.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInDown(child: _buildMainBalanceCard(context)),
            Gap(24.h),
            FadeInUp(
              delay: const Duration(milliseconds: 100),
              child: _buildSecondaryMetrics(context),
            ),
            Gap(32.h),
            _buildSectionTitle(AppLocaleKey.adminMarketAnalysis.tr(), context),
            Gap(16.h),
            const MarketTrendsChartWidget(),
            Gap(32.h),
            _buildSectionTitle(AppLocaleKey.recentTransactions.tr(), context),
            Gap(16.h),
            const TransactionsListWidget(),
            Gap(40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildMainBalanceCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColor.primaryColor(context), const Color(0xFF1E3A8A)],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor(context).withValues(alpha: (0.3)),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocaleKey.totalNetProfit.tr(),
            style: TextStyle(
              color: AppColor.whiteColor(context),
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Gap(8.h),
          Text(
            '154,300.50 ${AppLocaleKey.aed.tr()}',
            style: TextStyle(
              color: AppColor.whiteColor(context),
              fontSize: 28.sp,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
          Gap(24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBalanceDetail(
                AppLocaleKey.payments.tr(),
                '189,000 ${AppLocaleKey.aed.tr()}',
                Icons.arrow_upward_rounded,
                context,
              ),
              Container(
                width: 1,
                height: 40,
                color: AppColor.blackTextColor(context).withValues(alpha: 0.1),
              ),
              _buildBalanceDetail(
                AppLocaleKey.expenses.tr(),
                '34,700 ${AppLocaleKey.aed.tr()}',
                Icons.arrow_downward_rounded,
                context,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceDetail(String label, String value, IconData icon, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: AppColor.whiteColor(context), size: 14.sp),
            Gap(4.w),
            Text(
              label,
              style: TextStyle(color: AppColor.whiteColor(context), fontSize: 11.sp),
            ),
          ],
        ),
        Gap(4.h),
        Text(
          value,
          style: TextStyle(color: AppColor.whiteColor(context), fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildSecondaryMetrics(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildSmallAnalyticalCard(
            context,
            AppLocaleKey.adminMostViewed.tr(),
            '1.2k',
            Icons.visibility_rounded,
            AppColor.blueColor(context),
          ),
        ),
        Gap(16.w),
        Expanded(
          child: _buildSmallAnalyticalCard(
            context,
            AppLocaleKey.adminTimeToSell.tr(),
            '12 ${AppLocaleKey.day.tr()}',
            Icons.timer_rounded,
            AppColor.orangeColor(context),
          ),
        ),
      ],
    );
  }

  Widget _buildSmallAnalyticalCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.blackTextColor(context).withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: color, size: 18.sp),
          ),
          Gap(12.h),
          Text(
            value,
            style: AppTextStyle.bodyLarge(
              context,
            ).copyWith(color: AppColor.blackTextColor(context), fontWeight: FontWeight.w900),
          ),
          Text(
            label,
            style: AppTextStyle.bodySmall(context).copyWith(
              color: AppColor.blackTextColor(context).withValues(alpha: 0.4),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, BuildContext context) {
    return Text(
      title,
      style: AppTextStyle.titleMedium(context).copyWith(
        color: AppColor.blackTextColor(context),
        fontWeight: FontWeight.bold,
        fontSize: 18.sp,
      ),
    );
  }
}
