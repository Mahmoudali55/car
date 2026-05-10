// ─── ad_card_text_content.dart ───────────────────────────────────

import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/home/data/model/ad_item_model.dart';
import 'package:car/features/home/presentation/view/widgets/ad_explore_button.dart';
import 'package:car/features/home/presentation/view/widgets/ad_tag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AdCardTextContent extends StatelessWidget {
  final AdItem ad;
  const AdCardTextContent({super.key, required this.ad});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AdTagWidget(tag: ad.tag, accentColor: ad.accentColor),
        Gap(10.h),
        _buildTitle(context),
        Gap(4.h),
        _buildSubtitle(context),
        const Spacer(),
        _buildPrice(context),
        Gap(10.h),
        AdExploreButton(ad: ad),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      ad.title,
      style: AppTextStyle.bodyMedium(
        context,
      ).copyWith(color: AppColor.whiteColor(context), fontWeight: FontWeight.w800, height: 1.25),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    return Text(
      ad.subtitle,
      style: AppTextStyle.bodySmall(
        context,
      ).copyWith(color: AppColor.whiteColor(context).withValues(alpha: 0.55)),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildPrice(BuildContext context) {
    return Text(
      ad.price,
      style: AppTextStyle.bodyMedium(
        context,
      ).copyWith(color: ad.accentColor, fontWeight: FontWeight.w800, letterSpacing: 0.3),
    );
  }
}
