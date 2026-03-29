import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/offers/presentation/screen/widget/filter_chips_widget.dart';
import 'package:car/features/offers/presentation/screen/widget/header_widget.dart';
import 'package:car/features/offers/presentation/screen/widget/offers_featured_slider_widget.dart';
import 'package:car/features/offers/presentation/screen/widget/premium_offer_card_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  final int _selectedFilterIndex = 0;
  final List<String> _filters = ['الكل', 'فاخرة', 'رياضية', 'SUV', 'سيدان'];

  final List<Map<String, dynamic>> _offers = [
    {
      'title': 'عرض خاص على G-Class G63',
      'name': 'G-Class G63',
      'brand': 'Mercedes-Benz',
      'category': 'فاخرة',
      'discount': '10%',
      'oldPrice': '850,000  ر.س       ',
      'price': '765,000  ر.س       ',
      'expiresIn': 'ينتهي غداً',
      'image': 'assets/images/cars/mercedes-benz.png',
      'year': '2024',
      'mileage': '0 كم',
      'engine': '4.0L V8',
      'video_id': 'D7O8J5vVf-M',
      'isFavorite': true,
    },
    {
      'title': 'خصم حصري BMW M5',
      'name': 'M5 Competition',
      'brand': 'BMW',
      'category': 'رياضية',
      'discount': '15%',
      'oldPrice': '520,000  ر.س       ',
      'price': '442,000  ر.س       ',
      'expiresIn': '3 أيام',
      'image': 'assets/images/cars/bmw.png',
      'year': '2023',
      'mileage': '5,000 كم',
      'engine': '4.4L V8',
      'video_id': 'D7O8J5vVf-M',
      'isFavorite': false,
    },
    {
      'title': 'تمويل مرن Land Cruiser',
      'name': 'Land Cruiser 300',
      'brand': 'Toyota',
      'category': 'SUV',
      'discount': '5%',
      'oldPrice': '350,000  ر.س       ',
      'price': '332,500  ر.س       ',
      'expiresIn': '5 أيام',
      'image': 'assets/images/cars/toyota.png',
      'year': '2024',
      'mileage': '0 كم',
      'engine': '3.5L V6',
      'video_id': 'D7O8J5vVf-M',
      'isFavorite': false,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(child: HeaderWidget()),
          const SliverToBoxAdapter(child: OffersFeaturedSlider()),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FilterChipsWidget(selectedFilterIndex: _selectedFilterIndex, filters: _filters),
                  Gap(24.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocaleKey.specialOffers.tr(),
                          style: AppTextStyle.titleMedium(context).copyWith(
                            color: AppColor.blackTextColor(context),
                            fontWeight: FontWeight.w900,
                            fontSize: 20.sp,
                          ),
                        ),
                        Text(
                          '${_offers.length} ${AppLocaleKey.offers.tr()}',
                          style: AppTextStyle.bodySmall(
                            context,
                          ).copyWith(color: AppColor.primaryColor(context)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Offers Grid/List
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: EdgeInsets.only(bottom: 20.h, left: 10.w, right: 10.w),
                child: PremiumOfferCardWidget(offer: _offers[index]),
              ),
              childCount: _offers.length,
            ),
          ),
        ],
      ),
    );
  }
}
