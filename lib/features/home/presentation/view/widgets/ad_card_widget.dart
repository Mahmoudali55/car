// ─── ad_card_widget.dart ─────────────────────────────────────────

import 'package:car/features/home/data/model/ad_item_model.dart';
import 'package:car/features/home/presentation/view/widgets/ad_card_background.dart';
import 'package:car/features/home/presentation/view/widgets/ad_card_image.dart';
import 'package:car/features/home/presentation/view/widgets/ad_card_text_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AdCardWidget extends StatelessWidget {
  final AdItem ad;

  const AdCardWidget({super.key, required this.ad});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        gradient: LinearGradient(
          colors: ad.bgColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: ad.bgColors.first.withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          AdCardBackground(accentColor: ad.accentColor),
          Padding(
            padding: EdgeInsets.fromLTRB(18.w, 16.h, 12.w, 16.h),
            child: Row(
              children: [
                Expanded(flex: 55, child: AdCardTextContent(ad: ad)),
                Gap(8.w),
                Expanded(flex: 45, child: AdCardImage(ad: ad)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
