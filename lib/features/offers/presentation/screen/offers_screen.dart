import 'package:car/core/images/app_images.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/home/data/model/financing_ad_model.dart';
import 'package:car/features/home/presentation/cubit/home_cubit.dart';
import 'package:car/features/offers/presentation/screen/widget/custom_special_offers_widget.dart';
import 'package:car/features/offers/presentation/screen/widget/header_widget.dart';
import 'package:car/features/offers/presentation/screen/widget/offers_featured_slider_widget.dart';
import 'package:car/features/offers/presentation/screen/widget/premium_offer_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OffersScreen extends StatefulWidget {
  final int? programId;
  final String? programName;

  const OffersScreen({
    super.key,
    this.programId,
    this.programName,
  });

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  final int _selectedFilterIndex = 0;
  final List<String> _filters = ['الكل', 'فاخرة', 'رياضية', 'SUV', 'سيدان'];

  static final List<Map<String, dynamic>> _fallbackOffers = [
    {
      'title': 'عرض خاص على G-Class G63',
      'name': 'G-Class G63',
      'brand': 'Mercedes-Benz',
      'category': 'فاخرة',
      'discount': '10%',
      'oldPrice': '850,000  ر.س       ',
      'price': '765,000  ر.س       ',
      'expiresIn': 'ينتهي غداً',
      'image': AppImages.assetsImagesCamry,
      'year': '2024',
      'mileage': '0 كم',
      'engine': '4.0L V8',
      'video_id': 'D7O8J5vVf-M',
      'isFavorite': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final state = context.read<HomeCubit>().state;
        if (widget.programId != null) {
          context.read<HomeCubit>().getFinancingAds(
                code: widget.programId.toString(),
              );
        } else if (state.financingAdsStatus.isInitial) {
          context.read<HomeCubit>().getFinancingAds();
        }
      }
    });
  }

  Map<String, dynamic> _adToOfferMap(FinancingAdModel ad) {
    final images = ad.allCarImages;
    final mainImage = images.isNotEmpty ? images.first : ad.displayPicUrl;

    return {
      'title': ad.programName ?? ad.itemName ?? ad.modelName ?? 'عرض تمويلي مميز',
      'name': ad.itemName ?? ad.modelName ?? ad.programName ?? 'سيارة العرض',
      'brand': ad.programName ?? 'عرض تمويلي',
      'category': ad.interestRate != null ? 'فائدة ${ad.interestRate}%' : 'عرض خاص',
      'discount': ad.interestRate != null ? '${ad.interestRate}%' : 'خاص',
      'oldPrice': (ad.price != null && ad.price! > 0)
          ? '${(ad.price! * 1.05).toStringAsFixed(0)}  ر.س       '
          : '',
      'price': (ad.price != null && ad.price! > 0)
          ? '${ad.price!.toStringAsFixed(0)}  ر.س       '
          : 'سعر خاص',
      'expiresIn': (ad.endDate != null && ad.endDate!.isNotEmpty)
          ? 'حتى ${ad.endDate}'
          : 'لفترة محدودة',
      'image': mainImage,
      'extraImages': images,
      'year': (ad.makeYear ?? ad.modelYear ?? 2025).toString(),
      'mileage': (ad.kilometerReading != null && ad.kilometerReading!.isNotEmpty)
          ? '${ad.kilometerReading} كم'
          : '0 كم',
      'engine': (ad.cylinder != null && ad.cylinder.toString().isNotEmpty)
          ? '${ad.cylinder} Cyl'
          : 'V4',
      'video_id': 'D7O8J5vVf-M',
      'isFavorite': false,
      'carData': ad.toCarDataModel(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final List<FinancingAdModel>? programCars =
              state.programCarsStatus.isSuccess ? state.programCarsStatus.data : null;
          final List<FinancingAdModel>? allAds =
              state.financingAdsStatus.isSuccess ? state.financingAdsStatus.data : null;

          final bool isLoading =
              state.programCarsStatus.isLoading || state.financingAdsStatus.isLoading;

          final List<FinancingAdModel> activeAds = (programCars != null && programCars.isNotEmpty)
              ? programCars
              : (allAds ?? []);

          final List<Map<String, dynamic>> offersList = activeAds.isNotEmpty
              ? activeAds.map(_adToOfferMap).toList()
              : _fallbackOffers;

          if (isLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          final bool isFilteredByProgram = programCars != null && programCars.isNotEmpty;

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              const SliverToBoxAdapter(child: HeaderWidget()),
              if (!isFilteredByProgram)
                const SliverToBoxAdapter(child: OffersFeaturedSlider()),
              if (isFilteredByProgram)
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor(context).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: AppColor.primaryColor(context).withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'نتائج التصفية: ${programCars.first.programName ?? 'عرض التمويل'}',
                            style: AppTextStyle.bodyMedium(context).copyWith(
                              color: AppColor.primaryColor(context),
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            context.read<HomeCubit>().getFinancingAds();
                          },
                          child: Container(
                            padding: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor(context),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              SliverToBoxAdapter(
                child: CustomSpecialOffersWidget(
                  selectedFilterIndex: _selectedFilterIndex,
                  filters: _filters,
                  offers: offersList,
                ),
              ),
              if (offersList.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'لا تتوفر عروض حالياً',
                      style: AppTextStyle.bodyMedium(context).copyWith(
                        color: AppColor.blackTextColor(context).withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                      padding:
                          EdgeInsets.only(bottom: 20.h, left: 10.w, right: 10.w),
                      child: PremiumOfferCardWidget(offer: offersList[index]),
                    ),
                    childCount: offersList.length,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
