import 'dart:ui';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/favorites/presentation/view/cubit/favorites_cubit.dart';
import 'package:car/features/cart/presentation/view/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CarDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> car;

  const CarDetailsScreen({super.key, required this.car});

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  late YoutubePlayerController _controller;
  bool _isVideoPlaying = false;

  @override
  void initState() {
    super.initState();
    // Using a default high-quality car review video ID as a placeholder
    // In a real app, this ID would come from the 'car' data map
    _controller = YoutubePlayerController(
      initialVideoId: widget.car['video_id'] ?? 'D7O8J5vVf-M', // Example: Mercedes G63 Review
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: true,
        enableCaption: true,
      ),
    );
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        // The player forces portrait up on exiting fullscreen. We can override this if needed.
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: AppColor.primaryColor(context),
        progressColors: ProgressBarColors(
          playedColor: AppColor.primaryColor(context),
          handleColor: AppColor.primaryColor(context),
        ),
        onReady: () {
          // _controller.addListener(listener);
        },
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: AppColor.scaffoldColor(context),
          body: Stack(
            children: [
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // Hero Image Header
                  SliverAppBar(
                    expandedHeight: 400.h,
                    pinned: true,
                    backgroundColor: AppColor.scaffoldColor(context),
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black.withOpacity(0.3),
                        padding: EdgeInsets.all(12.w),
                      ),
                    ),
                    actions: [
                      BlocBuilder<FavoritesCubit, FavoritesState>(
                        builder: (context, state) {
                          final isFav = context.read<FavoritesCubit>().isFavorite(widget.car['name']!);
                          return IconButton(
                            icon: Icon(
                              isFav ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                              color: isFav ? Colors.redAccent : Colors.white,
                            ),
                            onPressed: () {
                              context.read<FavoritesCubit>().toggleFavorite(widget.car);
                            },
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.black.withValues(alpha: 0.3),
                              padding: EdgeInsets.all(12.w),
                            ),
                          );
                        },
                      ),
                      Gap(8.w),
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  AppColor.secondAppColor(context).withOpacity(0.5),
                                  AppColor.scaffoldColor(context),
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: Hero(
                              tag: 'car_image_${widget.car['name']}',
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20.w, 60.h, 20.w, 0),
                                child: Image.asset(
                                  widget.car['image'],
                                  fit: BoxFit.contain,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            height: 100.h,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.transparent, AppColor.scaffoldColor(context)],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Content Area
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Brand & Name
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.car['brand'],
                                      style: AppTextStyle.titleMedium(context).copyWith(
                                        color: AppColor.primaryColor(context),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Gap(8.h),
                                    Text(
                                      widget.car['name'],
                                      style: AppTextStyle.titleLarge(context).copyWith(
                                        color: Colors.white,
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.w800,
                                        height: 1.2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Gap(24.h),

                          // Price
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                            decoration: BoxDecoration(
                              color: AppColor.secondAppColor(context),
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(color: Colors.white.withOpacity(0.05)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'السعر الإجمالي',
                                  style: AppTextStyle.bodyMedium(context).copyWith(color: Colors.white.withOpacity(0.7)),
                                ),
                                Text(
                                  widget.car['price'] ?? 'غير متوفر',
                                  style: AppTextStyle.titleLarge(context).copyWith(
                                    color: AppColor.primaryColor(context),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Gap(32.h),

                          // Specs Grid
                          Text(
                            'المواصفات التقنية',
                            style: AppTextStyle.titleMedium(context).copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                          ),
                          Gap(16.h),
                          GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            mainAxisSpacing: 12.h,
                            crossAxisSpacing: 12.w,
                            childAspectRatio: 2.5,
                            padding: EdgeInsets.zero,
                            children: [
                              _buildSpecCard(context, Icons.calendar_month_rounded, 'الموديل', widget.car['year'] ?? 'N/A'),
                              _buildSpecCard(context, Icons.speed_rounded, 'الممشى', widget.car['mileage'] ?? '0 كم'),
                              _buildSpecCard(context, Icons.settings_rounded, 'ناقل الحركة', 'أوتوماتيك'),
                              _buildSpecCard(context, Icons.local_gas_station_rounded, 'المحرك', 'V8 Twin-Turbo'),
                            ],
                          ),
                          Gap(32.h),

                          // Overview
                          Text(
                            'نظرة عامة',
                            style: AppTextStyle.titleMedium(context).copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                          ),
                          Gap(12.h),
                          Text(
                            'تعتبر ${widget.car['name']} من أبرز السيارات الفارهة التي تجمع بين الأداء الرياضي الخارق والراحة المطلقة في المقصورة الداخلية، مع أحدث تقنيات مساعدة السائق ونظام ترفيهي متطور.',
                            style: AppTextStyle.bodyMedium(context).copyWith(
                              color: Colors.white.withOpacity(0.6),
                              height: 1.6,
                            ),
                          ),
                          Gap(32.h),

                          // Features
                          Text(
                            'أهم الميزات',
                            style: AppTextStyle.titleMedium(context).copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                          ),
                          Gap(16.h),
                          Wrap(
                            spacing: 8.w,
                            runSpacing: 12.h,
                            children: [
                              _buildFeatureChip(context, Icons.bluetooth_rounded, 'بلوتوث'),
                              _buildFeatureChip(context, Icons.camera_alt_rounded, 'كاميرا 360'),
                              _buildFeatureChip(context, Icons.sensor_door_rounded, 'بصمة دخول'),
                              _buildFeatureChip(context, Icons.airline_seat_recline_extra_rounded, 'مقاعد جلد'),
                              _buildFeatureChip(context, Icons.ac_unit_rounded, 'تكييف خلفي'),
                              _buildFeatureChip(context, Icons.navigation_rounded, 'نظام خرائط'),
                            ],
                          ),
                          Gap(32.h),

                          // Video Review
                          Text(
                            'فيديو تعريفي',
                            style: AppTextStyle.titleMedium(context).copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                          ),
                          Gap(16.h),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 200.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              color: AppColor.secondAppColor(context),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: _isVideoPlaying
                                ? player
                                : Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Opacity(
                                        opacity: 0.5,
                                        child: Image.network(
                                          YoutubePlayer.getThumbnail(videoId: _controller.initialVideoId),
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) => Image.asset(
                                            widget.car['image'],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Container(color: Colors.black.withOpacity(0.3)),
                                      Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _isVideoPlaying = true;
                                            });
                                            _controller.play();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(16.w),
                                            decoration: BoxDecoration(
                                              color: AppColor.primaryColor(context).withOpacity(0.9),
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColor.primaryColor(context).withOpacity(0.5),
                                                  blurRadius: 20,
                                                  spreadRadius: 2,
                                                ),
                                              ],
                                            ),
                                            child: Icon(Icons.play_arrow_rounded, color: Colors.white, size: 40.sp),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 12.h,
                                        right: 12.w,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(0.7),
                                            borderRadius: BorderRadius.circular(8.r),
                                          ),
                                          child: Text(
                                            'مراجعة حية',
                                            style: AppTextStyle.bodySmall(context).copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                          Gap(120.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Bottom Bar
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 32.h),
                      decoration: BoxDecoration(
                        color: AppColor.scaffoldColor(context).withOpacity(0.85),
                        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: AppColor.secondAppColor(context),
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(color: Colors.white.withOpacity(0.1)),
                            ),
                            child: Icon(Icons.chat_bubble_outline_rounded, color: Colors.white, size: 24.sp),
                          ),
                          Gap(16.w),
                          Expanded(
                            child: BlocBuilder<CartCubit, CartState>(
                              builder: (context, state) {
                                final isInCart = context.read<CartCubit>().isInCart(widget.car['name']);
                                return ElevatedButton(
                                  onPressed: () {
                                    if (isInCart) {
                                      context.read<CartCubit>().removeFromCart(widget.car);
                                    } else {
                                      context.read<CartCubit>().addToCart(widget.car);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isInCart ? Colors.redAccent.withOpacity(0.8) : AppColor.primaryColor(context),
                                    padding: EdgeInsets.symmetric(vertical: 18.h),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                                    elevation: 0,
                                  ),
                                  child: Text(
                                    isInCart ? 'إزالة من السلة' : 'أضف إلى السلة',
                                    style: AppTextStyle.titleMedium(context).copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSpecCard(BuildContext context, IconData icon, String title, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColor.secondAppColor(context).withOpacity(0.5),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.03)),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColor.primaryColor(context), size: 24.sp),
          Gap(12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: AppTextStyle.bodySmall(context).copyWith(color: Colors.white.withOpacity(0.5), fontSize: 10.sp),
                ),
                Gap(2.h),
                Text(
                  value,
                  style: AppTextStyle.bodyMedium(context).copyWith(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12.sp),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChip(BuildContext context, IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColor.secondAppColor(context),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColor.primaryColor(context), size: 16.sp),
          Gap(8.w),
          Text(
            label,
            style: AppTextStyle.bodySmall(context).copyWith(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
