import 'dart:ui';

import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cart/presentation/view/cubit/cart_cubit.dart';
import 'package:car/features/favorites/presentation/view/cubit/favorites_cubit.dart';
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
  final PageController _imagePageController = PageController();
  int _currentImageIndex = 0;

  // Extension for dummy data to show CarSwitch style features
  late List<String> _carImages;

  @override
  void initState() {
    super.initState();
    _carImages = [
      widget.car['image'],
      widget.car['image'], // Placeholder for gallery
      widget.car['image'],
    ];

    _controller = YoutubePlayerController(
      initialVideoId: widget.car['video_id'] ?? 'D7O8J5vVf-M',
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
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _imagePageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: AppColor.primaryColor(context),
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: AppColor.scaffoldColor(context),
          body: Stack(
            children: [
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  _buildSliverAppBar(context),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 140.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCarHeader(context),
                          Gap(24.h),
                          _buildInspectionBadge(context),
                          Gap(32.h),
                          _buildSpecGrid(context),
                          Gap(32.h),
                          _buildInspectionReport(context),
                          Gap(32.h),
                          _buildOverview(context),
                          Gap(32.h),
                          _buildFeaturesGrid(context),
                          Gap(32.h),
                          _buildVideoReview(context, player),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              _buildStickyActionBar(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 380.h,
      pinned: true,
      elevation: 0,
      stretch: true,
      backgroundColor: AppColor.scaffoldColor(context),
      leading: Padding(
        padding: EdgeInsets.all(8.w),
        child: CircleAvatar(
          backgroundColor: Colors.black.withValues(alpha: 0.4),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.all(8.w),
          child: CircleAvatar(
            backgroundColor: Colors.black.withValues(alpha: 0.4),
            child: IconButton(
              icon: const Icon(Icons.share_outlined, color: Colors.white, size: 20),
              onPressed: () {},
            ),
          ),
        ),
        BlocBuilder<FavoritesCubit, FavoritesState>(
          builder: (context, state) {
            final isFav = context.read<FavoritesCubit>().isFavorite(widget.car['name'] ?? '' ?? '');
            return Padding(
              padding: EdgeInsets.all(8.w),
              child: CircleAvatar(
                backgroundColor: Colors.black.withValues(alpha: 0.4),
                child: IconButton(
                  icon: Icon(
                    isFav ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                    color: isFav ? Colors.redAccent : Colors.white,
                    size: 20,
                  ),
                  onPressed: () => context.read<FavoritesCubit>().toggleFavorite(widget.car),
                ),
              ),
            );
          },
        ),
        Gap(12.w),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            PageView.builder(
              controller: _imagePageController,
              onPageChanged: (index) => setState(() => _currentImageIndex = index),
              itemCount: _carImages.length,
              itemBuilder: (context, index) {
                return Hero(
                  tag: index == 0
                      ? 'car_image_${widget.car['name'] ?? ''}'
                      : 'car_image_gallery_$index',
                  child: Container(
                    padding: EdgeInsets.only(top: 80.h, bottom: 40.h),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColor.primaryColor(context).withValues(alpha: 0.15),
                          AppColor.scaffoldColor(context),
                        ],
                      ),
                    ),
                    child: Center(child: Image.asset(_carImages[index], fit: BoxFit.contain)),
                  ),
                );
              },
            ),
            // Page Indicator
            Positioned(
              bottom: 20.h,
              right: 20.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  '${_currentImageIndex + 1} / ${_carImages.length}',
                  style: AppTextStyle.bodySmall(
                    context,
                  ).copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (widget.car['brand'] ?? '').toUpperCase(),
                  style: AppTextStyle.bodySmall(context).copyWith(
                    color: AppColor.primaryColor(context),
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                  ),
                ),
                Gap(4.h),
                Text(
                  widget.car['name'] ?? '',
                  style: AppTextStyle.titleLarge(
                    context,
                  ).copyWith(fontSize: 28.sp, color: Colors.white, fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ],
        ),
        Gap(16.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              widget.car['price'] ?? '0',
              style: AppTextStyle.titleLarge(context).copyWith(
                color: AppColor.primaryColor(context),
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(8.w),
            Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: Text(
                'شامل الضريبة',
                style: AppTextStyle.bodySmall(
                  context,
                ).copyWith(color: Colors.white.withValues(alpha: 0.4)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInspectionBadge(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.primaryColor(context).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.primaryColor(context).withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColor.primaryColor(context),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.verified_user_rounded, color: Colors.white, size: 20),
          ),
          Gap(12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'سيارة موثوقة ومفحوصة',
                  style: AppTextStyle.bodyMedium(
                    context,
                  ).copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  'اجتازت هذه السيارة جميع فحوصات الجودة لدينا (200+ نقطة فحص)',
                  style: AppTextStyle.bodySmall(
                    context,
                  ).copyWith(color: Colors.white.withValues(alpha: 0.6)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecGrid(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'المواصفات الأساسية'),
        Gap(16.h),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 2.2,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
          children: [
            _buildSpecItem(
              context,
              Icons.calendar_today_rounded,
              'سنة الموديل',
              widget.car['year'] ?? 'N/A',
            ),
            _buildSpecItem(context, Icons.speed_rounded, 'الممشى', widget.car['mileage'] ?? '0 كم'),
            _buildSpecItem(
              context,
              Icons.settings_input_component_rounded,
              'ناقل الحركة',
              'أوتوماتيك',
            ),
            _buildSpecItem(context, Icons.ev_station_rounded, 'نوع الوقود', 'بنزين 95'),
            _buildSpecItem(context, Icons.color_lens_rounded, 'اللون الخارجي', 'سماوي ميتاليك'),
            _buildSpecItem(context, Icons.airline_seat_recline_extra_rounded, 'السعة', '5 ركاب'),
          ],
        ),
      ],
    );
  }

  Widget _buildSpecItem(BuildContext context, IconData icon, String title, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: AppColor.secondAppColor(context),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: AppColor.primaryColor(context), size: 18.sp),
          ),
          Gap(12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: AppTextStyle.bodySmall(
                    context,
                  ).copyWith(color: Colors.white.withValues(alpha: 0.4), fontSize: 10.sp),
                ),
                Text(
                  value,
                  style: AppTextStyle.bodyMedium(
                    context,
                  ).copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12.sp),
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

  Widget _buildInspectionReport(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSectionTitle(context, 'تقرير الفحص'),
            Text(
              'ممتاز 4.8/5',
              style: AppTextStyle.bodyMedium(
                context,
              ).copyWith(color: Colors.greenAccent, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Gap(16.h),
        Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: AppColor.secondAppColor(context),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            children: [
              _buildReportRow(context, 'حالة المحرك والناقل', true),
              _buildReportDivider(),
              _buildReportRow(context, 'حالة الهيكل والطلاء', true),
              _buildReportDivider(),
              _buildReportRow(context, 'الحالة الداخلية والنظافة', true),
              _buildReportDivider(),
              _buildReportRow(context, 'الإطارات والمكابح', true),
              Gap(20.h),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColor.primaryColor(context),
                    side: BorderSide(color: AppColor.primaryColor(context)),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: const Text(
                    'تحميل التقرير الكامل (PDF)',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReportRow(BuildContext context, String title, bool isHealthy) {
    return Row(
      children: [
        Icon(
          isHealthy ? Icons.check_circle_rounded : Icons.warning_rounded,
          color: isHealthy ? Colors.greenAccent : Colors.orangeAccent,
          size: 20.sp,
        ),
        Gap(12.w),
        Text(title, style: AppTextStyle.bodyMedium(context).copyWith(color: Colors.white)),
        const Spacer(),
        Text(
          isHealthy ? 'سليم' : 'يحتاج انتباه',
          style: AppTextStyle.bodySmall(
            context,
          ).copyWith(color: Colors.white.withValues(alpha: 0.5)),
        ),
      ],
    );
  }

  Widget _buildReportDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Divider(color: Colors.white.withValues(alpha: 0.05), height: 1),
    );
  }

  Widget _buildOverview(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'نظرة عامة'),
        Gap(12.h),
        Text(
          'تتميز هذه السيارة بحالتها الاستثنائية وصيانتها المنتظمة لدى الوكيل. تم فحصها بدقة لتضمن لك تجربة قيادة آمنة ومريحة. مثالية للاستخدام الشخصي أو للعائلات التي تبحث عن الفخامة والأمان.',
          style: AppTextStyle.bodyMedium(
            context,
          ).copyWith(color: Colors.white.withValues(alpha: 0.6), height: 1.7),
        ),
      ],
    );
  }

  Widget _buildFeaturesGrid(BuildContext context) {
    final List<Map<String, dynamic>> features = [
      {'icon': Icons.bluetooth_rounded, 'label': 'بلوتوث'},
      {'icon': Icons.camera_alt_rounded, 'label': 'كاميرا 360'},
      {'icon': Icons.airline_seat_recline_extra_rounded, 'label': 'جلد'},
      {'icon': Icons.navigation_rounded, 'label': 'خرائط Gps'},
      {'icon': Icons.brightness_high_rounded, 'label': 'فتحة سقف'},
      {'icon': Icons.speed_rounded, 'label': 'مثبت سرعة'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'المميزات الإضافية'),
        Gap(16.h),
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: features.map((f) => _buildFeatureItem(context, f['icon'], f['label'])).toList(),
        ),
      ],
    );
  }

  Widget _buildFeatureItem(BuildContext context, IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColor.secondAppColor(context),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColor.primaryColor(context), size: 18.sp),
          Gap(10.w),
          Text(
            label,
            style: AppTextStyle.bodySmall(
              context,
            ).copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoReview(BuildContext context, Widget player) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'مراجعة بالفيديو'),
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
              ? player
              : Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      YoutubePlayer.getThumbnail(videoId: _controller.initialVideoId),
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Image.asset(widget.car['image'], fit: BoxFit.cover),
                    ),
                    Container(color: Colors.black.withValues(alpha: 0.4)),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          setState(() => _isVideoPlaying = true);
                          _controller.play();
                        },
                        child: CircleAvatar(
                          radius: 35.r,
                          backgroundColor: AppColor.primaryColor(context).withValues(alpha: 0.9),
                          child: Icon(Icons.play_arrow_rounded, color: Colors.white, size: 40.sp),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 16.h,
                      left: 16.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: const Text(
                          '4:25',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }

  Widget _buildStickyActionBar(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 40.h),
            decoration: BoxDecoration(
              color: AppColor.scaffoldColor(context).withValues(alpha: 0.8),
              border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.08))),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      final isInCart = context.read<CartCubit>().isInCart(widget.car['name'] ?? '');
                      return ElevatedButton(
                        onPressed: () {
                          if (isInCart) {
                            context.read<CartCubit>().removeFromCart(widget.car);
                          } else {
                            context.read<CartCubit>().addToCart(widget.car);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isInCart
                              ? Colors.redAccent.withValues(alpha: 0.8)
                              : AppColor.primaryColor(context),
                          padding: EdgeInsets.symmetric(vertical: 18.h),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                          elevation: 10,
                          shadowColor: AppColor.primaryColor(context).withValues(alpha: 0.3),
                        ),
                        child: Text(
                          isInCart ? 'إزالة من السلة' : 'اضافة للسلة',
                          style: AppTextStyle.buttonStyle(
                            context,
                          ).copyWith(fontWeight: FontWeight.w900),
                        ),
                      );
                    },
                  ),
                ),
                Gap(16.w),
                Container(
                  height: 56.h,
                  width: 56.h,
                  decoration: BoxDecoration(
                    color: const Color(0xff25D366),
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff25D366).withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.phone_rounded, color: Colors.white, size: 28),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: AppTextStyle.titleMedium(
        context,
      ).copyWith(color: Colors.white, fontWeight: FontWeight.w800),
    );
  }
}
