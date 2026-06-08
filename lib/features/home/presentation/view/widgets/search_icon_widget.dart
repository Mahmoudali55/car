import 'package:car/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SearchIconWidget extends StatelessWidget {
  const SearchIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColor.greyColor(context).withValues(alpha: (0.1)),
      child: IconButton(
        onPressed: () {},
        icon: Icon(Icons.search, color: AppColor.blackTextColor(context)),
      ),
    );
  }
}
