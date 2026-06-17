import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/agent/presentation/cubit/agent_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLeadsHeaderWidget extends StatelessWidget {
  const CustomLeadsHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: AppColor.appBarColor(context),
      elevation: 0,
      expandedHeight: 100.h,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppLocaleKey.agentLeadsPotential.tr(),
                  textAlign: TextAlign.center,
                  style: AppTextStyle.titleLarge(context).copyWith(
                    color: AppColor.blackTextColor(context),
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 12.h),
          child: CustomFormField(
            hintText: AppLocaleKey.agentSearchByName.tr(),
            radius: 12.r,
            prefixIcon: Icon(Icons.search_rounded, size: 20.sp, color: AppColor.hintColor(context)),
            onChanged: (v) => context.read<AgentCubit>().getCustomer(v),
          ),
        ),
      ),
    );
  }
}
