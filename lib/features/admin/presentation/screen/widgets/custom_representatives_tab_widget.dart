import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/custom_loading/custom_loading.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/admin/presentation/cubit/admin_cubit.dart';
import 'package:car/features/admin/presentation/cubit/admin_state.dart';
import 'package:car/features/admin/presentation/screen/widgets/custom_empty_widget.dart';
import 'package:car/features/admin/presentation/screen/widgets/custom_error_widget.dart';
import 'package:car/features/admin/presentation/screen/widgets/custom_initial_search_widget.dart';
import 'package:car/features/admin/presentation/screen/widgets/custom_representative_card_widget.dart';
import 'package:car/features/admin/presentation/screen/widgets/custom_search_bar_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomRepresentativesTabWidget extends StatelessWidget {
  const CustomRepresentativesTabWidget({
    super.key,
    required TextEditingController representativesSearchController,
  }) : _representativesSearchController = representativesSearchController;

  final TextEditingController _representativesSearchController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSearchBarWidget(
          controller: _representativesSearchController,
          hintText: '${AppLocaleKey.search.tr()} ${AppLocaleKey.employees.tr()}...',
          onSearch: (value) {
            context.read<AdminCubit>().searchRepresentatives(value);
          },
        ),
        Expanded(
          child: BlocBuilder<AdminCubit, AdminState>(
            buildWhen: (previous, current) =>
                previous.searchRepresentativesStatus != current.searchRepresentativesStatus,
            builder: (context, state) {
              final status = state.searchRepresentativesStatus;
              if (status.isLoading) {
                return const Center(child: CustomLoading());
              }
              if (status.isFailure) {
                return CustomErrorWidget(error: status.error ?? '');
              }
              if (status.isSuccess && status.data != null) {
                final representatives = status.data!;
                if (representatives.isEmpty) {
                  return const CustomEmptyWidget();
                }
                return ListView.separated(
                  padding: EdgeInsets.all(20.w),
                  itemCount: representatives.length,
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) => Gap(16.h),
                  itemBuilder: (context, index) => FadeInUp(
                    delay: Duration(milliseconds: index * 40),
                    child: CustomRepresentativeCardWidget(
                      roleColor: AppColor.primaryColor(context),
                      rep: representatives[index],
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
