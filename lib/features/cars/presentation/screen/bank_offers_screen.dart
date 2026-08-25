import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/cars/presentation/widget/bank_offer_card_widget.dart';
import 'package:car/features/cars/presentation/widget/bank_offer_fliter_section_widget.dart';
import 'package:car/features/cars/presentation/widget/bank_offers_list_widget.dart';
import 'package:car/features/cars/presentation/widget/bank_offers_widgets.dart';
import 'package:car/features/home/data/model/brand_cars_data_model.dart';
import 'package:car/features/home/data/model/financing_ad_model.dart';
import 'package:car/features/home/presentation/cubit/home_cubit.dart';
import 'package:car/features/services/presentation/screen/financing_screen.dart' as car_services;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BankOffersScreen extends StatefulWidget {
  final GetBrandCarsDataModel car;

  const BankOffersScreen({super.key, required this.car});

  @override
  State<BankOffersScreen> createState() => _BankOffersScreenState();
}

class _BankOffersScreenState extends State<BankOffersScreen> {
  late num _carPrice;
  double _downPayment = 0;
  int _durationYears = 5;
  SortOption _currentSort = SortOption.lowestMargin;

  final TextEditingController _downPaymentController = TextEditingController();

  final List<BankOffer> _fallbackBanks = [
    BankOffer(
      nameKey: AppLocaleKey.bankAlrajhi,
      logoText: 'AR',
      apr: 3.5,
      brandColor: const Color(0xFF133261),
    ),
    BankOffer(
      nameKey: AppLocaleKey.bankSnb,
      logoText: 'SNB',
      apr: 2.9,
      brandColor: const Color(0xFF00755F),
    ),
    BankOffer(
      nameKey: AppLocaleKey.bankRiyad,
      logoText: 'RB',
      apr: 3.2,
      brandColor: const Color(0xFFCE1126),
    ),
    BankOffer(
      nameKey: AppLocaleKey.bankAlinma,
      logoText: 'INM',
      apr: 3.0,
      brandColor: const Color(0xFF886A34),
    ),
    BankOffer(
      nameKey: AppLocaleKey.bankSab,
      logoText: 'SAB',
      apr: 3.4,
      brandColor: const Color(0xFFD61A0C),
    ),
  ];

  @override
  void initState() {
    super.initState();
    final cashPrice =
        num.tryParse(widget.car.price?.toString().replaceAll(',', '') ?? '150000') ?? 150000;
    final vatPercentage = double.tryParse(HiveMethods.getVatNumber()?.toString() ?? '') ?? 0;
    _carPrice = cashPrice * (1 + vatPercentage / 100);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeCubit>().getNormalFinancing();
    });
  }

  @override
  void dispose() {
    _downPaymentController.dispose();
    super.dispose();
  }

  List<BankOffer> get _sortedOffers {
    final apiOffers = context.read<HomeCubit>().state.normalFinancingStatus.data;
    final offers = apiOffers == null || apiOffers.isEmpty
        ? List<BankOffer>.from(_fallbackBanks)
        : apiOffers.map(_toBankOffer).toList();

    offers.sort((a, b) {
      if (_currentSort == SortOption.lowestMargin) {
        return a.apr.compareTo(b.apr);
      } else if (_currentSort == SortOption.highestMargin) {
        return b.apr.compareTo(a.apr);
      } else if (_currentSort == SortOption.lowestInstallment) {
        final calcA = a.calculate(_carPrice, _downPayment, _durationYears);
        final calcB = b.calculate(_carPrice, _downPayment, _durationYears);
        return calcA['monthlyInstallment']!.compareTo(calcB['monthlyInstallment']!);
      }
      return 0;
    });

    return offers;
  }

  BankOffer _toBankOffer(FinancingAdModel ad) {
    return BankOffer(
      nameKey: ad.bankName ?? ad.programName ?? ad.bankOrProvider ?? 'Bank',
      logoText: (ad.bankName ?? ad.programName ?? 'BK').substring(0, 1),
      apr: ad.interestRate ?? 0,
      brandColor: AppColor.primaryColor(context),
      firstInstallmentPct: ad.firstInstallmentPct ?? 0,
      lastInstallmentPct: ad.lastInstallmentPct ?? 0,
      adminFeesPct: ad.adminFeesPct ?? 0,
      imageUrl: ad.displayBankImageUrl,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: AppBar(
        title: Text(
          AppLocaleKey.bankOffers.tr(),
          style: TextStyle(color: AppColor.blackTextColor(context), fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColor.appBarColor(context),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColor.blackTextColor(context)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) =>
            previous.normalFinancingStatus != current.normalFinancingStatus,
        builder: (context, state) => CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: BankOfferCalculatorCard(
                carPrice: _carPrice,
                downPayment: _downPayment,
                durationYears: _durationYears,
                downPaymentController: _downPaymentController,
                onDownPaymentChanged: (value) {
                  setState(() {
                    _downPayment = double.tryParse(value) ?? 0;
                  });
                },
                onDurationChanged: (value) {
                  setState(() {
                    _durationYears = value.toInt();
                  });
                },
              ),
            ),
            SliverToBoxAdapter(
              child: BankOfferFilterSection(
                currentSort: _currentSort,
                onSortChanged: (option) {
                  setState(() {
                    _currentSort = option;
                  });
                },
              ),
            ),
            BankOffersList(
              sortedOffers: _sortedOffers,
              carPrice: _carPrice,
              downPayment: _downPayment,
              durationYears: _durationYears,
              onOfferTap: (offer) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => car_services.FinancingScreen(
                      car: widget.car,
                      initialCarPrice: _carPrice.toDouble(),
                      initialPriceIncludesVat: true,
                      initialDuration: _durationYears,
                      bankNameKey: offer.nameKey,
                      initialDownPayment: _carPrice.toDouble() * offer.firstInstallmentPct / 100,
                      initialLastPayment: _carPrice.toDouble() * offer.lastInstallmentPct / 100,
                      offer: FinancingAdModel(
                        bankOrProvider: offer.nameKey,
                        bankName: offer.nameKey,
                        firstInstallmentPct: offer.firstInstallmentPct,
                        lastInstallmentPct: offer.lastInstallmentPct,
                        adminFeesPct: offer.adminFeesPct,
                        interestRate: offer.apr,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
