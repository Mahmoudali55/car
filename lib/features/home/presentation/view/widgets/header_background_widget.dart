import 'package:car/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class HeaderBackground extends StatelessWidget {
  const HeaderBackground({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColor.primaryColor(context).withValues(alpha: (0.1)),
            AppColor.scaffoldColor(context),
          ],
        ),
      ),
    );
  }
}
