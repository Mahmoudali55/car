import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/admin/presentation/screen/widgets/logout_button_widget.dart';
import 'package:car/features/agent/presentation/agent_shell.dart' as car_agent;
import 'package:car/features/auth/presentation/view/cubit/auth_cubit.dart';
import 'package:car/features/profile/presentation/screen/widget/action_tile_widget.dart';
import 'package:car/features/profile/presentation/screen/widget/info_tile_widget.dart';
import 'package:car/features/profile/presentation/screen/widget/profile_header_widget.dart';
import 'package:car/features/profile/presentation/screen/widget/section_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

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
              style: TextStyle(
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
                ProfileHeaderWidget(user: '---'),
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInUp(
                        child: SectionWidget(title: AppLocaleKey.personalDetails.tr(),children:  [
                          InfoTileWidget(

                           icon:  Icons.person_outline_rounded,
                          label:  AppLocaleKey.fullName.tr(),
                          value:  ''
                          ),
                          InfoTileWidget(
                            icon:
                            Icons.email_outlined,
                           label:  AppLocaleKey.email.tr(),
                           value: '---',
                          ),
                          InfoTileWidget(
                            icon:
                            Icons.phone_android_rounded,
                           label:  AppLocaleKey.mobileNumber.tr(),
                          value:  '---',
                          ),
                        ]),
                      ),
                      Gap(24.h),
                      FadeInUp(
                        delay: const Duration(milliseconds: 100),
                        child: SectionWidget(title:  AppLocaleKey.accountSettings.tr(),children:  [
                          ActionTileWidget(
                           icon: Icons.edit_note_rounded,
                          label: AppLocaleKey.editProfile.tr(),
                          onTap:  () {},
                          ),
                          ActionTileWidget(
                          icon:
                            Icons.lock_outline_rounded,
                          label:   AppLocaleKey.changePassword.tr(),
                           onTap: () {},
                          ),
                          ActionTileWidget(
                           icon:
                            Icons.local_shipping_outlined,
                           label:  AppLocaleKey.trackOrder.tr(),
                          onTap:  () => Navigator.pushNamed(context, RoutesName.trackOrderScreen),
                          ),
                          ActionTileWidget(
                              icon:
                            Icons.history_rounded,
                          label:   AppLocaleKey.myHistory.tr(),
                           onTap:  () {},
                          ),
                          ActionTileWidget(
                           icon: Icons.admin_panel_settings_rounded,
                           label: 'لوحة المناديب',
                           onTap: () {
                             Navigator.push(
                               context,
                               MaterialPageRoute(builder: (_) => const car_agent.AgentShell()),
                             );
                           },
                          ),
                        ]),
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
