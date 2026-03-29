import 'package:animate_do/animate_do.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart' show AppTextStyle;
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
            Gap(32.h),
            _buildSectionTitle(AppLocaleKey.recentTransactions.tr(), context),
            Gap(16.h),
            _buildTransactionsList(context),
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
            color: AppColor.primaryColor(context).withOpacity(0.3),
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
                color: AppColor.blackTextColor(context).withOpacity(0.1),
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

  Widget _buildSectionTitle(String title, BuildContext context) {
    return FadeInRight(
      child: Text(
        title,
        style: TextStyle(
          color: AppColor.blackTextColor(context),
          fontSize: 18.sp,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _buildTransactionsList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      separatorBuilder: (context, index) => Gap(12.h),
      itemBuilder: (context, index) => FadeInUp(
        delay: Duration(milliseconds: index * 50),
        child: _buildTransactionItem(index, context),
      ),
    );
  }

  Widget _buildTransactionItem(int index, BuildContext context) {
    final isPositive = index % 3 != 0;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.blackTextColor(context).withOpacity(0.02),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColor.blackTextColor(context).withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: (isPositive ? Colors.greenAccent : Colors.redAccent).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isPositive ? Icons.add_rounded : Icons.remove_rounded,
              color: isPositive ? Colors.greenAccent : Colors.redAccent,
              size: 20.sp,
            ),
          ),
          Gap(16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isPositive
                      ? AppLocaleKey.bookingPaymentGClass.tr()
                      : AppLocaleKey.maintenanceExpensesLambo.tr(),
                  style: TextStyle(
                    color: AppColor.blackTextColor(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  AppLocaleKey.twoHoursAgo.tr(),
                  style: TextStyle(
                    color: AppColor.blackTextColor(context).withOpacity(0.3),
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${isPositive ? '+' : '-'}${isPositive ? '1,200' : '450'} ${AppLocaleKey.aed.tr()}',
            style: TextStyle(
              color: isPositive ? Colors.greenAccent : Colors.redAccent,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
