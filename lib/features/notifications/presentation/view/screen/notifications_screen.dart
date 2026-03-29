import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/notifications/presentation/view/cubit/notifications_cubit.dart';
import 'package:car/features/notifications/presentation/view/cubit/notifications_state.dart';
import 'package:car/features/notifications/presentation/view/widget/notification_item_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: CustomAppBar(
        context,
        title: Text(
          AppLocaleKey.notifications.tr(),
          style: AppTextStyle.titleMedium(
            context,
          ).copyWith(color: AppColor.blackTextColor(context), fontWeight: FontWeight.bold),
        ),
        actions: [
          BlocBuilder<NotificationsCubit, NotificationsState>(
            builder: (context, state) {
              if (state is NotificationsLoaded && state.unreadCount > 0) {
                return TextButton(
                  onPressed: () => context.read<NotificationsCubit>().markAllAsRead(),
                  child: Text(
                    AppLocaleKey.markAllAsRead.tr(),
                    style: AppTextStyle.bodySmall(
                      context,
                    ).copyWith(color: AppColor.primaryColor(context), fontWeight: FontWeight.bold),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          if (state is NotificationsLoaded) {
            if (state.notifications.isEmpty) {
              return _buildEmptyState(context);
            }
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              physics: const BouncingScrollPhysics(),
              itemCount: state.notifications.length,
              itemBuilder: (context, index) {
                final notification = state.notifications[index];
                return NotificationItemWidget(
                  notification: notification,
                  onTap: () => context.read<NotificationsCubit>().markAsRead(notification['id']),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(30.w),
            decoration: BoxDecoration(
              color: AppColor.secondAppColor(context),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_off_outlined,
              color: AppColor.blackTextColor(context).withOpacity(0.2),
              size: 60.sp,
            ),
          ),
          Gap(24.h),
          Text(
            'لا توجد تنبيهات حالياً',
            style: AppTextStyle.titleMedium(
              context,
            ).copyWith(color: AppColor.blackTextColor(context), fontWeight: FontWeight.bold),
          ),
          Gap(12.h),
          Text(
            'سنقوم بتنبيهك عند وجود عروض جديدة\nأو تحديثات على طلباتك.',
            style: AppTextStyle.bodyMedium(
              context,
            ).copyWith(color: AppColor.blackTextColor(context).withOpacity(0.4), height: 1.5),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
