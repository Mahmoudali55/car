import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/custom_widgets/custom_loading/custom_loading.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/home/data/model/customer_loan_application_model.dart';
import 'package:car/features/home/presentation/cubit/home_cubit.dart';
import 'package:car/features/profile/presentation/screen/widget/empty_View.dart';
import 'package:car/features/profile/presentation/screen/widget/error_view.dart';
import 'package:car/features/profile/presentation/screen/widget/loan_application_card_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class TrackOrderView extends StatelessWidget {
  const TrackOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: CustomAppBar(
        context,
        title: Text(
          AppLocaleKey.loanApplications.tr(),
          style: AppTextStyle.titleMedium(context).copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (prev, curr) =>
            prev.custLoanApplicationsStatus != curr.custLoanApplicationsStatus,
        builder: (context, state) {
          final status = state.custLoanApplicationsStatus;

          if (status.isLoading || status.isInitial) {
            return const Center(child: CustomLoading());
          }

          if (status.isFailure) {
            return ErrorView(
              message: status.error ?? AppLocaleKey.somethingWentWrong.tr(),
              onRetry: () => context.read<HomeCubit>().getCustLoanApplications(
                HiveMethods.getUserCode() ?? '',
              ),
            );
          }

          final applications = status.data ?? <CustomerLoanApplicationModel>[];

          if (applications.isEmpty) {
            return EmptyView(
              onRetry: () => context.read<HomeCubit>().getCustLoanApplications(
                HiveMethods.getUserCode() ?? '',
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () =>
                context.read<HomeCubit>().getCustLoanApplications(HiveMethods.getUserCode() ?? ''),
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              itemCount: applications.length,
              separatorBuilder: (_, __) => Gap(14.h),
              itemBuilder: (ctx, i) => LoanApplicationCard(application: applications[i]),
            ),
          );
        },
      ),
    );
  }
}
