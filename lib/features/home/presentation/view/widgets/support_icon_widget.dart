import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/home/presentation/view/widgets/contact_bottom_sheet_widget.dart';
import 'package:car/features/home/presentation/view/widgets/contact_button_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportIconWidget extends StatelessWidget {
  const SupportIconWidget({super.key});

 

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 25.r,
        backgroundColor: AppColor.primaryColor(context),
        child: IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) => const ContactBottomSheetWidget(),
            );
          },
          icon: Icon(
            Icons.headset_mic_rounded,
            color: Colors.white,
            size: 24.sp,
          ),
        ),
      ),
    );
  }

 

  
}
