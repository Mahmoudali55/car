import 'package:car/core/custom_widgets/custom_loading/custom_loading.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/services/services_locator.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/home/data/model/customer_loan_application_model.dart';
import 'package:car/features/home/data/repository/home_repo.dart';
import 'package:car/features/home/presentation/cubit/home_cubit.dart';
import 'package:car/features/profile/presentation/screen/widget/empty_View.dart';
import 'package:car/features/profile/presentation/screen/widget/error_view.dart';
import 'package:car/features/profile/presentation/screen/widget/loan_application_card_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AdminLoanApplicationsScreen extends StatefulWidget {
  const AdminLoanApplicationsScreen({super.key});

  @override
  State<AdminLoanApplicationsScreen> createState() =>
      _AdminLoanApplicationsScreenState();
}

class _AdminLoanApplicationsScreenState
    extends State<AdminLoanApplicationsScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedStatusFilter = -1; // -1 = all, 0 = pending, 1 = approved, 2 = rejected

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(sl<HomeRepo>())..getCustLoanApplications(''),
      child: Scaffold(
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
            AppLocaleKey.loanApplications.tr(),
            style: AppTextStyle.titleMedium(context).copyWith(
              color: AppColor.blackTextColor(context),
              fontWeight: FontWeight.w900,
              fontSize: 20.sp,
            ),
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
                onRetry: () =>
                    context.read<HomeCubit>().getCustLoanApplications(''),
              );
            }

            // ignore: unnecessary_cast
            final allApplications = status.data as List<CustomerLoanApplicationModel>;

            if (allApplications.isEmpty) {
              return EmptyView(
                onRetry: () =>
                    context.read<HomeCubit>().getCustLoanApplications(''),
              );
            }

            return Column(
              children: [
                _buildSearchBar(context),
                _buildFilterChips(context, allApplications),
                Expanded(
                  child: _buildList(context, allApplications),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: TextField(
        controller: _searchController,
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          hintText: AppLocaleKey.searchCarHint.tr(),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: AppColor.greyColor(context),
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear_rounded),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {});
                  },
                )
              : null,
          filled: true,
          fillColor: AppColor.cardColor(context),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        ),
      ),
    );
  }

  Widget _buildFilterChips(
    BuildContext context,
    List<CustomerLoanApplicationModel> all,
  ) {
    final filters = [
      (-1, AppLocaleKey.all.tr(), all.length),
      (
        0,
        AppLocaleKey.loanPending.tr(),
        all.where((e) => e.applicationStatus == 0).length,
      ),
      (
        1,
        AppLocaleKey.loanApproved.tr(),
        all.where((e) => e.applicationStatus == 1).length,
      ),
      (
        2,
        AppLocaleKey.loanRejected.tr(),
        all.where((e) => e.applicationStatus == 2).length,
      ),
    ];

    return SizedBox(
      height: 44.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: filters.length,
        separatorBuilder: (context2, index2) => Gap(8.w),
        itemBuilder: (context, i) {
          final (value, label, count) = filters[i];
          final isSelected = _selectedStatusFilter == value;
          return ChoiceChip(
            label: Text('$label ($count)'),
            selected: isSelected,
            onSelected: (_) => setState(() => _selectedStatusFilter = value),
            selectedColor: AppColor.primaryColor(context),
            labelStyle: AppTextStyle.bodySmall(context).copyWith(
              color: isSelected
                  ? Colors.white
                  : AppColor.blackTextColor(context),
              fontWeight:
                  isSelected ? FontWeight.bold : FontWeight.normal,
            ),
            backgroundColor: AppColor.cardColor(context),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            side: BorderSide(color: AppColor.borderColor(context)),
          );
        },
      ),
    );
  }

  Widget _buildList(
    BuildContext context,
    List<CustomerLoanApplicationModel> all,
  ) {
    final query = _searchController.text.trim().toLowerCase();

    final filtered = all.where((app) {
      final matchStatus = _selectedStatusFilter == -1 ||
          app.applicationStatus == _selectedStatusFilter;
      final matchSearch = query.isEmpty ||
          app.carName.toLowerCase().contains(query) ||
          (app.customerName?.toLowerCase().contains(query) ?? false) ||
          app.idNo.toLowerCase().contains(query) ||
          app.applicationID.toString().contains(query);
      return matchStatus && matchSearch;
    }).toList();

    if (filtered.isEmpty) {
      return Center(
        child: Text(
          AppLocaleKey.noData.tr(),
          style: AppTextStyle.bodyMedium(context),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () =>
          context.read<HomeCubit>().getCustLoanApplications(''),
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        itemCount: filtered.length,
        separatorBuilder: (context2, index2) => Gap(14.h),
        itemBuilder: (ctx, i) => LoanApplicationCard(application: filtered[i]),
      ),
    );
  }
}
