import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cart/presentation/view/cubit/cart_cubit.dart';
import 'package:car/features/notifications/presentation/view/cubit/notifications_cubit.dart';
import 'package:car/features/notifications/presentation/view/cubit/notifications_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileIconWidget extends StatelessWidget {
  const ProfileIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (HiveMethods.isGuest()) {
          Navigator.pushNamed(context, RoutesName.loginScreen);
        } else {
          Navigator.pushNamed(context, RoutesName.profileScreen);
        }
      },
      icon: Icon(Icons.person, color: AppColor.primaryColor(context)),
    );
  }
}

class SearchIconWidget extends StatelessWidget {
  const SearchIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColor.greyColor(context).withValues(alpha: 0.1),
      child: IconButton(
        onPressed: () {},
        icon: Icon(Icons.search, color: AppColor.blackTextColor(context)),
      ),
    );
  }
}

class NotificationIconWidget extends StatelessWidget {
  const NotificationIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        final int unreadCount = state is NotificationsLoaded ? state.unreadCount : 0;
        return Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              backgroundColor: AppColor.greyColor(context).withValues(alpha: 0.1),
              child: IconButton(
                onPressed: () => Navigator.pushNamed(context, RoutesName.notificationsScreen),
                icon: Icon(
                  Icons.notifications_none_rounded,
                  color: AppColor.blackTextColor(context),
                ),
              ),
            ),
            if (unreadCount > 0)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    unreadCount.toString(),
                    style: AppTextStyle.titleMedium(context).copyWith(
                      color: AppColor.whiteColor(context),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class CartIconWidget extends StatelessWidget {
  const CartIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              backgroundColor: AppColor.greyColor(context).withValues(alpha: 0.1),
              child: IconButton(
                onPressed: () => Navigator.pushNamed(context, RoutesName.cartScreen),
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: AppColor.blackTextColor(context),
                ),
              ),
            ),
            if (state.items.isNotEmpty)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    state.items.length.toString(),
                    style: TextStyle(
                      color: AppColor.whiteColor(context),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class TranslateIconWidget extends StatefulWidget {
  const TranslateIconWidget({super.key});

  @override
  State<TranslateIconWidget> createState() => _TranslateIconWidgetState();
}

class _TranslateIconWidgetState extends State<TranslateIconWidget> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColor.greyColor(context).withValues(alpha: 0.1),
      child: IconButton(
        onPressed: () async {
          final newLocale =
              context.locale.languageCode == 'ar' ? const Locale('en') : const Locale('ar');
          await context.setLocale(newLocale);
          HiveMethods.updateLang(newLocale);
          if (mounted) setState(() {});
        },
        icon: Icon(
          Icons.translate_rounded,
          color: AppColor.blackTextColor(context),
          size: 20.sp,
        ),
      ),
    );
  }
}
