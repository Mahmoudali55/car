import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/features/home/presentation/cubit/home_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomHeaderAllBrandWidget extends StatelessWidget {
  const CustomHeaderAllBrandWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
      child: StatefulBuilder(
        builder: (context, setInnerState) {
          return CustomFormField(
            radius: 16.r,
            onChanged: (val) {
              setInnerState(() {
                context.read<HomeCubit>().updateSearchQuery(val);
              });
            },
            prefixIcon: const Icon(Icons.search),
            hintText: AppLocaleKey.searchForBrand.tr(),
          );
        },
      ),
    );
  }
}
