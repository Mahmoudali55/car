import 'package:animate_do/animate_do.dart';
import 'package:car/features/admin/presentation/screen/widgets/ad_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FeaturedAdsListWidget extends StatelessWidget {
  const FeaturedAdsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(20.w),
      itemCount: 4,
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, index) => Gap(20.h),
      itemBuilder: (context, index) => FadeInUp(
        delay: Duration(milliseconds: index * 40),
        child: AdCardWidget(index: index),
      ),
    );
  }
}
