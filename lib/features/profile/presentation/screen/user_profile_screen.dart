import 'package:animate_do/animate_do.dart';
import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/admin/presentation/screen/widgets/logout_button_widget.dart';
import 'package:car/features/auth/presentation/view/cubit/auth_cubit.dart';
import 'package:car/features/profile/presentation/screen/widget/action_tile_widget.dart';
import 'package:car/features/profile/presentation/screen/widget/info_tile_widget.dart';
import 'package:car/features/profile/presentation/screen/widget/section_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool _isEditingName = false;
  bool _isEditingPhone = false;

  late TextEditingController _nameController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: HiveMethods.getUserName() ?? '');
    _phoneController = TextEditingController(text: HiveMethods.getSavedMobile());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveName() {
    HiveMethods.updateUserName(_nameController.text);
    setState(() {
      _isEditingName = false;
    });
  }

  void _savePhone() {
    HiveMethods.updateSavedMobile(_phoneController.text);
    setState(() {
      _isEditingPhone = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColor.scaffoldColor(context),
          appBar: CustomAppBar(
            context,
            title: Text(
              AppLocaleKey.profile.tr(),
              style: AppTextStyle.bodyLarge(context).copyWith(
                color: AppColor.appBarTextColor(context),
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInUp(
                        child: SectionWidget(
                          title: AppLocaleKey.personalDetails.tr(),
                          children: [
                            if (_isEditingName)
                              Padding(
                                padding: EdgeInsets.all(16.w),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.person_outline_rounded,
                                      color: AppColor.primaryColor(context),
                                      size: 22.sp,
                                    ),
                                    Gap(16.w),
                                    Expanded(
                                      child: TextField(
                                        controller: _nameController,
                                        autofocus: true,
                                        style: AppTextStyle.bodyMedium(context),
                                        decoration: InputDecoration(
                                          labelText: AppLocaleKey.fullName.tr(),
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: _saveName,
                                      child: Text(
                                        AppLocaleKey.save.tr(),
                                        style: AppTextStyle.bodySmall(
                                          context,
                                          color: AppColor.primaryColor(context),
                                        ).copyWith(decoration: TextDecoration.underline),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            else
                              InfoTileWidget(
                                icon: Icons.person_outline_rounded,
                                label: AppLocaleKey.fullName.tr(),
                                value: _nameController.text.isEmpty ? '---' : _nameController.text,
                                trailing: Text(
                                  AppLocaleKey.edit.tr(),
                                  style: AppTextStyle.bodySmall(
                                    context,
                                    color: AppColor.primaryColor(context),
                                  ).copyWith(decoration: TextDecoration.underline),
                                ),
                                onTrailingTap: () {
                                  setState(() {
                                    _isEditingName = true;
                                  });
                                },
                              ),
                            InfoTileWidget(
                              icon: Icons.email_outlined,
                              label: AppLocaleKey.email.tr(),
                              value: '---',
                            ),
                            if (_isEditingPhone)
                              Padding(
                                padding: EdgeInsets.all(16.w),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.phone_android_rounded,
                                      color: AppColor.primaryColor(context),
                                      size: 22.sp,
                                    ),
                                    Gap(16.w),
                                    Expanded(
                                      child: TextField(
                                        controller: _phoneController,
                                        autofocus: true,
                                        keyboardType: TextInputType.phone,
                                        style: AppTextStyle.bodyMedium(context),
                                        decoration: InputDecoration(
                                          labelText: AppLocaleKey.mobileNumber.tr(),
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: _savePhone,
                                      child: Text(
                                        AppLocaleKey.save.tr(),
                                        style: AppTextStyle.bodySmall(
                                          context,
                                          color: AppColor.primaryColor(context),
                                        ).copyWith(decoration: TextDecoration.underline),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            else
                              InfoTileWidget(
                                icon: Icons.phone_android_rounded,
                                label: AppLocaleKey.mobileNumber.tr(),
                                value: _phoneController.text.isEmpty
                                    ? '---'
                                    : _phoneController.text,
                                trailing: Text(
                                  AppLocaleKey.edit.tr(),
                                  style: AppTextStyle.bodySmall(
                                    context,
                                    color: AppColor.primaryColor(context),
                                  ).copyWith(decoration: TextDecoration.underline),
                                ),
                                onTrailingTap: () {
                                  setState(() {
                                    _isEditingPhone = true;
                                  });
                                },
                              ),
                            InfoTileWidget(
                              icon: Icons.location_on_outlined,
                              label: AppLocaleKey.city.tr(),
                              value: '---',
                            ),
                          ],
                        ),
                      ),
                      Gap(24.h),
                      FadeInUp(
                        delay: const Duration(milliseconds: 100),
                        child: SectionWidget(
                          title: AppLocaleKey.accountSettings.tr(),
                          children: [
                            ActionTileWidget(
                              icon: Icons.local_shipping_outlined,
                              label: AppLocaleKey.trackOrder.tr(),
                              onTap: () =>
                                  Navigator.pushNamed(context, RoutesName.trackOrderScreen),
                            ),
                            ActionTileWidget(
                              icon: Icons.history_rounded,
                              label: AppLocaleKey.myHistory.tr(),
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      Gap(40.h),
                      FadeInUp(
                        delay: const Duration(milliseconds: 200),
                        child: const LogoutButtonWidget(),
                      ),
                      Gap(50.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
