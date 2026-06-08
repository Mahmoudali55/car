import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

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
