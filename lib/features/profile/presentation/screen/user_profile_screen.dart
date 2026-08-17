import 'package:animate_do/animate_do.dart';
import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/custom_widgets/custom_loading/custom_loading.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/admin/presentation/screen/widgets/logout_button_widget.dart';
import 'package:car/features/agent/data/model/customer_profile_model.dart';
import 'package:car/features/agent/presentation/cubit/agent_cubit.dart';
import 'package:car/features/agent/presentation/cubit/agent_state.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final code = HiveMethods.getcode();
      final userCode = (code != null && code.isNotEmpty)
          ? code
          : (HiveMethods.getUserCode() ?? '1');
      context.read<AgentCubit>().getCustomerProfile(userCode);
    });
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
    final isArabic = context.locale.languageCode == 'ar';

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        return BlocBuilder<AgentCubit, AgentState>(
          builder: (context, agentState) {
            final profileStatus = agentState.customerProfileStatus;
            final CustomerProfileModel? profile = profileStatus.data;

            if (profile != null && profile.customerName != null && profile.customerName!.isNotEmpty) {
              if (_nameController.text.isEmpty) {
                _nameController.text = profile.customerName!;
              }
            }
            if (profile != null && profile.tel1 != null && profile.tel1!.isNotEmpty) {
              if (_phoneController.text.isEmpty) {
                _phoneController.text = profile.tel1!;
              }
            }

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
                          if (profileStatus.isLoading)
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              child: const Center(child: CustomLoading()),
                            ),

                          // Profile Header Banner
                          if (profile != null)
                            FadeInDown(
                              duration: const Duration(milliseconds: 500),
                              child: Container(
                                margin: EdgeInsets.only(bottom: 20.h),
                                padding: EdgeInsets.all(20.w),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColor.primaryColor(context),
                                      AppColor.primaryColor(context).withValues(alpha: 0.8),
                                    ],
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                  ),
                                  borderRadius: BorderRadius.circular(20.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColor.primaryColor(context).withValues(alpha: 0.2),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 54.w,
                                      height: 54.w,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(alpha: 0.2),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.person_rounded,
                                        color: Colors.white,
                                        size: 30.sp,
                                      ),
                                    ),
                                    Gap(16.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            profile.displayName.isNotEmpty
                                                ? profile.displayName
                                                : (_nameController.text.isNotEmpty
                                                    ? _nameController.text
                                                    : (isArabic ? 'عميل' : 'Customer')),
                                            style: AppTextStyle.titleMedium(context).copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          if (profile.customerTypeName != null &&
                                              profile.customerTypeName!.isNotEmpty) ...[
                                            Gap(4.h),
                                            Text(
                                              profile.customerTypeName!,
                                              style: AppTextStyle.bodySmall(context).copyWith(
                                                color: Colors.white.withValues(alpha: 0.85),
                                              ),
                                            ),
                                          ],
                                          if (profile.customerNo != null) ...[
                                            Gap(2.h),
                                            Text(
                                              '${isArabic ? "رقم العميل:" : "Customer ID:"} #${profile.customerNo}',
                                              style: AppTextStyle.bodySmall(context).copyWith(
                                                color: Colors.white.withValues(alpha: 0.7),
                                                fontSize: 11.sp,
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          // Personal Details Section
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
                                    value: (profile?.displayName.isNotEmpty ?? false)
                                        ? profile!.displayName
                                        : (_nameController.text.isEmpty
                                            ? '---'
                                            : _nameController.text),
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
                                    value: (profile?.formattedPhone.isNotEmpty ?? false)
                                        ? profile!.formattedPhone
                                        : (_phoneController.text.isEmpty
                                            ? '---'
                                            : _phoneController.text),
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
                                  value: (profile?.cityName != null && profile!.cityName!.isNotEmpty)
                                      ? profile.cityName!
                                      : '---',
                                ),
                                if (profile?.address != null && profile!.address!.isNotEmpty)
                                  InfoTileWidget(
                                    icon: Icons.home_outlined,
                                    label: isArabic ? 'العنوان' : 'Address',
                                    value: profile.address!,
                                  ),
                                if (profile?.custTaxNo != null && profile!.custTaxNo!.isNotEmpty)
                                  InfoTileWidget(
                                    icon: Icons.receipt_long_outlined,
                                    label: isArabic ? 'الرقم الضريبي' : 'Tax Number',
                                    value: profile.custTaxNo!,
                                  ),
                              ],
                            ),
                          ),

                          // Financial Summary (if balance or credit limit present)
                          if (profile != null && (profile.balance != null || profile.creditLimit != null)) ...[
                            Gap(24.h),
                            FadeInUp(
                              delay: const Duration(milliseconds: 80),
                              child: SectionWidget(
                                title: isArabic ? 'الملخص المالي' : 'Financial Summary',
                                children: [
                                  if (profile.balance != null)
                                    InfoTileWidget(
                                      icon: Icons.account_balance_wallet_outlined,
                                      label: isArabic ? 'الرصيد الحالي' : 'Current Balance',
                                      value: '${profile.formattedBalance} ${AppLocaleKey.sar.tr()}',
                                    ),
                                  if (profile.creditLimit != null)
                                    InfoTileWidget(
                                      icon: Icons.credit_score_outlined,
                                      label: isArabic ? 'الحد الائتماني' : 'Credit Limit',
                                      value: '${profile.creditLimit} ${AppLocaleKey.sar.tr()}',
                                    ),
                                ],
                              ),
                            ),
                          ],

                          Gap(24.h),
                          FadeInUp(
                            delay: const Duration(milliseconds: 100),
                            child: SectionWidget(
                              title: AppLocaleKey.accountSettings.tr(),
                              children: [
                                ActionTileWidget(
                                  icon: Icons.local_shipping_outlined,
                                  label: AppLocaleKey.trackOrder.tr(),
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    RoutesName.trackOrderScreen,
                                    arguments: 'ORD-1001',
                                  ),
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
      },
    );
  }
}
