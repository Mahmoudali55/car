import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/agent/data/model/customer_model.dart';
import 'package:car/features/agent/presentation/cubit/agent_cubit.dart';
import 'package:car/features/agent/presentation/cubit/agent_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomerDropdown extends StatelessWidget {
  final CustomerModel? selected;
  final bool isOpen;
  final TextEditingController searchController;
  final VoidCallback onToggle;
  final ValueChanged<CustomerModel> onSelect;
  final ValueChanged<String> onSearch;
  final BuildContext context;

  const CustomerDropdown({
    required this.selected,
    required this.isOpen,
    required this.searchController,
    required this.onToggle,
    required this.onSelect,
    required this.onSearch,
    required this.context,
  });

  @override
  Widget build(BuildContext ctx) {
    final primary = AppColor.primaryColor(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Selector button
        GestureDetector(
          onTap: onToggle,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: AppColor.scaffoldColor(context),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(
                color: isOpen ? primary : AppColor.borderColor(context).withValues(alpha: 0.3),
                width: isOpen ? 1.5 : 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.person_rounded,
                  size: 18.sp,
                  color: selected != null ? primary : AppColor.hintColor(context),
                ),
                Gap(10.w),
                Expanded(
                  child: Text(
                    selected?.customerName ?? AppLocaleKey.select_client.tr(),
                    style: AppTextStyle.bodyMedium(context).copyWith(
                      color: selected != null
                          ? AppColor.blackTextColor(context)
                          : AppColor.hintColor(context),
                      fontWeight: selected != null ? FontWeight.w700 : FontWeight.normal,
                    ),
                  ),
                ),
                Icon(
                  isOpen ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                  color: AppColor.hintColor(context),
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),

        // Dropdown panel
        if (isOpen)
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: EdgeInsets.only(top: 6.h),
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColor.cardColor(context),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: primary.withValues(alpha: 0.2)),
              boxShadow: [
                BoxShadow(
                  color: AppColor.blackColor(context).withValues(alpha: 0.06),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                // Search inside dropdown
                CustomFormField(
                  controller: searchController,
                  hintText: AppLocaleKey.search_agent_hint.tr(),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    size: 18.sp,
                    color: AppColor.hintColor(context),
                  ),
                  onChanged: onSearch,
                  validator: (v) => null,
                ),
                Gap(10.h),
                // List of customers
                BlocBuilder<AgentCubit, AgentState>(
                  buildWhen: (p, c) => p.customersStatus != c.customersStatus,
                  builder: (context, state) {
                    if (state.customersStatus.isLoading) {
                      return Padding(
                        padding: EdgeInsets.all(16.h),
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(primary),
                            strokeWidth: 2,
                          ),
                        ),
                      );
                    }
                    final customers = state.customersStatus.data ?? [];
                    if (customers.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Center(
                          child: Text(
                            AppLocaleKey.no_customers.tr(),
                            style: AppTextStyle.bodySmall(
                              context,
                            ).copyWith(color: AppColor.hintColor(context)),
                          ),
                        ),
                      );
                    }
                    return SizedBox(
                      height: 200.h,
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: customers.length,
                        separatorBuilder: (_, __) => Divider(
                          height: 1,
                          color: AppColor.borderColor(context).withValues(alpha: 0.15),
                        ),
                        itemBuilder: (context, i) {
                          final c = customers[i];
                          final isSelected = c.customerNo == selected?.customerNo;
                          return GestureDetector(
                            onTap: () => onSelect(c),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? primary.withValues(alpha: 0.08)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    isSelected
                                        ? Icons.check_circle_rounded
                                        : Icons.person_outline_rounded,
                                    size: 18.sp,
                                    color: isSelected ? primary : AppColor.hintColor(context),
                                  ),
                                  Gap(10.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          c.customerName ?? '',
                                          style: AppTextStyle.bodySmall(context).copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: isSelected
                                                ? primary
                                                : AppColor.blackTextColor(context),
                                          ),
                                        ),
                                        if (c.tel1 != null && c.tel1!.isNotEmpty)
                                          Text(
                                            c.tel1!,
                                            style: AppTextStyle.bodySmall(context).copyWith(
                                              color: AppColor.greyColor(context),
                                              fontSize: 11.sp,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }
}
