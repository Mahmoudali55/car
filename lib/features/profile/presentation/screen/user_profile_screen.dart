import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/auth/presentation/view/cubit/auth_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:animate_do/animate_do.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final user = state.loginStatus.data?.user;

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
                _buildProfileHeader(context, user),
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInUp(
                        child: _buildSection(
                          context,
                          AppLocaleKey.personalDetails.tr(),
                          [
                            _buildInfoTile(
                              context,
                              Icons.person_outline_rounded,
                              AppLocaleKey.fullName.tr(),
                              user != null ? '${user.firstName} ${user.lastName}' : '---',
                            ),
                            _buildInfoTile(
                              context,
                              Icons.email_outlined,
                              AppLocaleKey.email.tr(),
                              user?.email ?? '---',
                            ),
                            _buildInfoTile(
                              context,
                              Icons.phone_android_rounded,
                              AppLocaleKey.mobileNumber.tr(),
                              user?.mobile ?? '---',
                            ),
                          ],
                        ),
                      ),
                      Gap(24.h),
                      FadeInUp(
                        delay: const Duration(milliseconds: 100),
                        child: _buildSection(
                          context,
                          AppLocaleKey.accountSettings.tr(),
                          [
                            _buildActionTile(
                              context,
                              Icons.edit_note_rounded,
                              AppLocaleKey.editProfile.tr(),
                              () {},
                            ),
                            _buildActionTile(
                              context,
                              Icons.lock_outline_rounded,
                              AppLocaleKey.changePassword.tr(),
                              () {},
                            ),
                            _buildActionTile(
                              context,
                              Icons.history_rounded,
                              AppLocaleKey.myHistory.tr(),
                              () {},
                            ),
                          ],
                        ),
                      ),
                      Gap(40.h),
                      FadeInUp(
                        delay: const Duration(milliseconds: 200),
                        child: _buildLogoutButton(context),
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

  Widget _buildProfileHeader(BuildContext context, dynamic user) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 30.h),
      decoration: BoxDecoration(
        color: AppColor.appBarColor(context),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32.r)),
        boxShadow: [
          BoxShadow(
            color: AppColor.blackTextColor(context).withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColor.primaryColor(context), width: 2),
                ),
                child: CircleAvatar(
                  radius: 50.r,
                  backgroundColor: AppColor.greyColor(context).withValues(alpha: 0.1),
                  child: Icon(
                    Icons.person_rounded,
                    size: 60.sp,
                    color: AppColor.primaryColor(context),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor(context),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColor.whiteColor(context), width: 2),
                ),
                child: Icon(Icons.camera_alt_rounded, color: Colors.white, size: 16.sp),
              ),
            ],
          ),
          Gap(16.h),
          Text(
            user != null ? '${user.firstName} ${user.lastName}' : '---',
            style: TextStyle(
              color: AppColor.blackTextColor(context),
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(4.h),
          Text(
            user?.email ?? '---',
            style: TextStyle(
              color: AppColor.greyColor(context),
              fontSize: 14.sp,
            ),
          ),
          if (user != null) ...[
            Gap(12.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColor.primaryColor(context).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                '${AppLocaleKey.memberSince.tr()} ${user.createdAt}',
                style: TextStyle(
                  color: AppColor.primaryColor(context),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.w, bottom: 12.h),
          child: Text(
            title,
            style: TextStyle(
              color: AppColor.blackTextColor(context).withValues(alpha: 0.6),
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColor.cardColor(context),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: AppColor.dividerColor(context).withValues(alpha: 0.5)),
          ),
          child: Column(
            children: List.generate(children.length, (index) {
              return Column(
                children: [
                  children[index],
                  if (index != children.length - 1)
                    Divider(
                      height: 1,
                      indent: 50.w,
                      endIndent: 20.w,
                      color: AppColor.dividerColor(context).withValues(alpha: 0.3),
                    ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoTile(BuildContext context, IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Icon(icon, color: AppColor.primaryColor(context), size: 22.sp),
          Gap(16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(color: AppColor.greyColor(context), fontSize: 12.sp),
                ),
                Text(
                  value,
                  style: TextStyle(
                    color: AppColor.blackTextColor(context),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Icon(icon, color: AppColor.blackTextColor(context).withValues(alpha: 0.7), size: 22.sp),
            Gap(16.w),
            Text(
              label,
              style: TextStyle(
                color: AppColor.blackTextColor(context),
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColor.greyColor(context).withValues(alpha: 0.5),
              size: 14.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => context.read<AuthCubit>().logout(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.withValues(alpha: 0.1),
          foregroundColor: Colors.red,
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout_rounded, size: 20.sp),
            Gap(10.w),
            Text(
              AppLocaleKey.logout.tr(),
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
