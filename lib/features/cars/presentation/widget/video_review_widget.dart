import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/cars/presentation/widget/section_title_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoReviewWidget extends StatefulWidget {
  final Map<String, dynamic> car;
  final YoutubePlayerController controller;
  final Widget player;

  const VideoReviewWidget({
    super.key,
    required this.car,
    required this.controller,
    required this.player,
  });

  @override
  State<VideoReviewWidget> createState() => _VideoReviewWidgetState();
}

class _VideoReviewWidgetState extends State<VideoReviewWidget> {
  bool _isVideoPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitleWidget(title: AppLocaleKey.watchVideo.tr()),
        Gap(16.h),
        Container(
          height: 220.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: AppColor.primaryColor(context).withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: _isVideoPlaying
              ? widget.player
              : Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      YoutubePlayer.getThumbnail(videoId: widget.controller.initialVideoId),
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Image.asset(widget.car['image'], fit: BoxFit.cover),
                    ),
                    Container(color: AppColor.blackTextColor(context).withValues(alpha: 0.4)),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          setState(() => _isVideoPlaying = true);
                          widget.controller.play();
                        },
                        child: CircleAvatar(
                          radius: 35.r,
                          backgroundColor: AppColor.primaryColor(context).withValues(alpha: 0.9),
                          child: Icon(
                            Icons.play_arrow_rounded,
                            color: AppColor.blackTextColor(context),
                            size: 40.sp,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 16.h,
                      left: 16.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: AppColor.blackTextColor(context).withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          '4:25',
                          style: TextStyle(color: AppColor.blackTextColor(context), fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
