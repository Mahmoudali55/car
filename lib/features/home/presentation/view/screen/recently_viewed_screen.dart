import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/home/presentation/view/widgets/app_header_popular_widget.dart';
import 'package:car/features/home/presentation/view/widgets/empty_state_widget.dart';
import 'package:car/features/home/presentation/view/widgets/magazine_card_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RecentlyViewedScreen extends StatefulWidget {
  const RecentlyViewedScreen({super.key});

  @override
  State<RecentlyViewedScreen> createState() => _RecentlyViewedScreenState();
}

class _RecentlyViewedScreenState extends State<RecentlyViewedScreen> {
  int _currentPage = 0;
  final int _itemsPerPage = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: ValueListenableBuilder(
            valueListenable: Hive.box('app').listenable(keys: ['recentlyViewed']),
            builder: (context, box, _) {
              final list = box.get('recentlyViewed', defaultValue: []) as List<dynamic>;

              if (list.isEmpty) {
                return CustomScrollView(
                  slivers: [
                    AppHeader(title: AppLocaleKey.recentlyViewed.tr()),
                    const SliverFillRemaining(child: EmptyState(isBrandSelected: false)),
                  ],
                );
              }

              final totalPages = (list.length / _itemsPerPage).ceil();
              if (_currentPage >= totalPages && totalPages > 0) {
                _currentPage = totalPages - 1;
              }

              final startIndex = _currentPage * _itemsPerPage;
              final endIndex = (startIndex + _itemsPerPage < list.length)
                  ? startIndex + _itemsPerPage
                  : list.length;
              final displayList = list.sublist(startIndex, endIndex);

              return CustomScrollView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                slivers: [
                  AppHeader(title: AppLocaleKey.recentlyViewed.tr()),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final Map<String, dynamic> car = Map<String, dynamic>.from(
                          displayList[index],
                        );
                        return Padding(
                          padding: EdgeInsets.only(bottom: 24.h),
                          child: MagazineCardWidget(
                            car: car,
                            heroTag:
                                "recently_viewed_screen_car_image_${car["itemCode"] ?? car["name"]}_${startIndex + index}",
                          ),
                        );
                      }, childCount: displayList.length),
                    ),
                  ),
                  if (totalPages > 1)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(totalPages, (index) {
                            final bool isSelected = _currentPage == index;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _currentPage = index;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: EdgeInsets.symmetric(horizontal: 6.w),
                                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColor.primaryColor(context)
                                      : AppColor.cardColor(context),
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColor.primaryColor(context)
                                        : AppColor.dividerColor(context),
                                  ),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: AppColor.primaryColor(
                                              context,
                                            ).withValues(alpha: 0.3),
                                            blurRadius: 8,
                                            offset: const Offset(0, 4),
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Text(
                                  (index + 1).toString(),
                                  style: AppTextStyle.bodyMedium(context).copyWith(
                                    color: isSelected
                                        ? AppColor.whiteColor(context)
                                        : AppColor.blackTextColor(context),
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  SliverToBoxAdapter(child: Gap(60.h)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
