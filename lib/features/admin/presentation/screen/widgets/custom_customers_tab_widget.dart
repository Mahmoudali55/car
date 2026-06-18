import 'package:animate_do/animate_do.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/features/admin/presentation/cubit/admin_cubit.dart';
import 'package:car/features/admin/presentation/cubit/admin_state.dart';
import 'package:car/features/admin/presentation/screen/widgets/custom_empty_widget.dart';
import 'package:car/features/admin/presentation/screen/widgets/custom_error_widget.dart';
import 'package:car/features/admin/presentation/screen/widgets/custom_initial_search_widget.dart';
import 'package:car/features/admin/presentation/screen/widgets/custom_search_bar_widget.dart';
import 'package:car/features/admin/presentation/screen/widgets/customer_card_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomCustomersTabWidget extends StatelessWidget {
  const CustomCustomersTabWidget({
    super.key,
    required TextEditingController customersSearchController,
  }) : _customersSearchController = customersSearchController;

  final TextEditingController _customersSearchController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSearchBarWidget(
          controller: _customersSearchController,
          hintText: '${AppLocaleKey.search.tr()} ${AppLocaleKey.customers.tr()}...',
          onSearch: (value) {
            context.read<AdminCubit>().searchCustomers(value);
          },
        ),
        Expanded(
          child: BlocBuilder<AdminCubit, AdminState>(
            buildWhen: (previous, current) =>
                previous.searchCustomersStatus != current.searchCustomersStatus,
            builder: (context, state) {
              final status = state.searchCustomersStatus;
              if (status.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (status.isFailure) {
                return CustomErrorWidget(error: status.error ?? '');
              }
              if (status.isSuccess && status.data != null) {
                final customers = status.data!;
                if (customers.isEmpty) {
                  return CustomEmptyWidget();
                }
                return ListView.separated(
                  padding: EdgeInsets.all(20.w),
                  itemCount: customers.length,
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) => Gap(16.h),
                  itemBuilder: (context, index) => FadeInUp(
                    delay: Duration(milliseconds: index * 40),
                    child: CustomerCardWidget(
                      customer: customers[index],
                      roleColor: Colors.blueAccent,
                      roleLabel: AppLocaleKey.customers.tr(),
                    ),
                  ),
                );
              }
              return const CustomInitialSearchWidget();
            },
          ),
        ),
      ],
    );
  }
}
