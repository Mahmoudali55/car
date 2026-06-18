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

class CustomSuppliersTabWidget extends StatelessWidget {
  const CustomSuppliersTabWidget({
    super.key,
    required TextEditingController suppliersSearchController,
  }) : _suppliersSearchController = suppliersSearchController;

  final TextEditingController _suppliersSearchController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSearchBarWidget(
          controller: _suppliersSearchController,
          hintText: '${AppLocaleKey.search.tr()} ${AppLocaleKey.suppliers.tr()}...',
          onSearch: (value) {
            context.read<AdminCubit>().searchSuppliers(value);
          },
        ),
        Expanded(
          child: BlocBuilder<AdminCubit, AdminState>(
            buildWhen: (previous, current) =>
                previous.searchSuppliersStatus != current.searchSuppliersStatus,
            builder: (context, state) {
              final status = state.searchSuppliersStatus;
              if (status.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (status.isFailure) {
                return CustomErrorWidget(error: status.error ?? '');
              }
              if (status.isSuccess && status.data != null) {
                final suppliers = status.data!;
                if (suppliers.isEmpty) {
                  return CustomEmptyWidget();
                }
                return ListView.separated(
                  padding: EdgeInsets.all(20.w),
                  itemCount: suppliers.length,
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) => Gap(16.h),
                  itemBuilder: (context, index) => FadeInUp(
                    delay: Duration(milliseconds: index * 40),
                    child: CustomerCardWidget(
                      customer: suppliers[index],
                      roleColor: Colors.orangeAccent,
                      roleLabel: AppLocaleKey.suppliers.tr(),
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
