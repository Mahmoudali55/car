import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/home/presentation/view/widgets/magazine_card_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class _BrandInfo {
  final String country, countryAr, founded, descEn, descAr;
  final List<String> categories, popularModels;
  final Color accentColor;
  const _BrandInfo({
    required this.country,
    required this.countryAr,
    required this.founded,
    required this.descEn,
    required this.descAr,
    required this.categories,
    required this.popularModels,
    required this.accentColor,
  });
}

class BrandCarsScreen extends StatelessWidget {
  final String brandNameEn, brandNameAr, brandImage;
  const BrandCarsScreen({
    super.key,
    required this.brandNameEn,
    required this.brandNameAr,
    required this.brandImage,
  });

  static final Map<String, _BrandInfo> _brandInfoMap = {
    'Mercedes-Benz': _BrandInfo(
      country: 'Germany',
      countryAr: 'ألمانيا',
      founded: '1926',
      descEn:
          'The best or nothing. Pioneer in luxury automobiles combining elegant engineering with cutting-edge technology.',
      descAr: 'الأفضل أو لا شيء. رائدة في السيارات الفاخرة بهندسة أنيقة مع تقنية متطورة.',
      categories: ['Sedan', 'SUV', 'Coupe', 'AMG', 'EV'],
      popularModels: ['S-Class', 'G63 AMG', 'GLS 600', 'EQS', 'C-Class'],
      accentColor: const Color(0xFF1B1B1B),
    ),
    'BMW': _BrandInfo(
      country: 'Germany',
      countryAr: 'ألمانيا',
      founded: '1916',
      descEn:
          'The ultimate driving machine. Unparalleled blend of performance, luxury and innovation.',
      descAr: 'ماكينة القيادة المثلى. توليفة لا مثيل لها من الأداء والفخامة والابتكار.',
      categories: ['Sedan', 'SUV', 'M Series', 'Gran Coupé', 'EV'],
      popularModels: ['7 Series', 'X7', 'M5', 'M8', 'iX'],
      accentColor: const Color(0xFF0653B2),
    ),
    'Toyota': _BrandInfo(
      country: 'Japan',
      countryAr: 'اليابان',
      founded: '1937',
      descEn:
          "Let's go places. World's largest automaker known for reliability, value, and hybrid innovation.",
      descAr: 'أكبر شركات السيارات في العالم. اشتهرت بالموثوقية والقيمة وتقنية الهجين المتطورة.',
      categories: ['SUV', 'Pickup', 'Sedan', 'Hybrid', 'Sport'],
      popularModels: ['Land Cruiser', 'Camry', 'Fortuner', 'Prado', 'Tundra'],
      accentColor: const Color(0xFFEB0A1E),
    ),
    'Tesla': _BrandInfo(
      country: 'USA',
      countryAr: 'أمريكا',
      founded: '2003',
      descEn:
          "Accelerating the world's transition to sustainable energy. Leading the EV revolution.",
      descAr: 'تقود الثورة الكهربائية وتسريع التحول العالمي إلى الطاقة المستدامة.',
      categories: ['Electric Sedan', 'Electric SUV', 'Full Self-Drive', 'Performance'],
      popularModels: ['Model S Plaid', 'Model 3', 'Model X', 'Model Y'],
      accentColor: const Color(0xFFCC0000),
    ),
    'Audi': _BrandInfo(
      country: 'Germany',
      countryAr: 'ألمانيا',
      founded: '1909',
      descEn:
          'Vorsprung durch Technik. Sporty performance with sophisticated luxury and innovation.',
      descAr: 'التقدم عبر التقنية. أداء رياضي مع فخامة راقية وابتكار متواصل.',
      categories: ['Sedan', 'SUV', 'RS Series', 'e-tron EV', 'Coupe'],
      popularModels: ['Q8 RS', 'A8 L', 'RS7', 'e-tron GT', 'R8'],
      accentColor: const Color(0xFF333333),
    ),
    'Nissan': _BrandInfo(
      country: 'Japan',
      countryAr: 'اليابان',
      founded: '1933',
      descEn: 'Innovation that excites. Bold performance and practical luxury for every driver.',
      descAr: 'ابتكار مثير. أداء جريء وفخامة عملية لكل سائق من المتحمس لليومي.',
      categories: ['SUV', 'Pickup', 'Sports', 'EV', 'Crossover'],
      popularModels: ['Patrol', 'GT-R', 'Armada', 'Frontier', 'Leaf'],
      accentColor: const Color(0xFFC3002F),
    ),
    'Ford': _BrandInfo(
      country: 'USA',
      countryAr: 'أمريكا',
      founded: '1903',
      descEn:
          'Built Ford tough. Iconic American automaker behind legendary Mustang, Raptor, and F-150.',
      descAr: 'مبني بقوة فورد. المصنّع الأمريكي الأيقوني خلف موستانج وراباتور وF-150.',
      categories: ['Pickup', 'SUV', 'Muscle', 'EV', 'Commercial'],
      popularModels: ['Raptor R', 'Mustang', 'Bronco', 'Explorer', 'F-150'],
      accentColor: const Color(0xFF003499),
    ),
    'Hyundai': _BrandInfo(
      country: 'South Korea',
      countryAr: 'كوريا الجنوبية',
      founded: '1967',
      descEn:
          'Progress for humanity. Leading the EV future with bold design and cutting-edge safety.',
      descAr: 'التقدم للإنسانية. تقود مستقبل الكهربائيات بتصميم جريء وأمان متطور.',
      categories: ['Sedan', 'SUV', 'EV IONIQ', 'N-Line Sport', 'Hybrid'],
      popularModels: ['IONIQ 6', 'Palisade', 'Tucson N', 'Sonata', 'IONIQ 5'],
      accentColor: const Color(0xFF002C5F),
    ),
    'Lamborghini': _BrandInfo(
      country: 'Italy',
      countryAr: 'إيطاليا',
      founded: '1963',
      descEn: "Expect the unexpected. The world's most dramatic supercars with Italian passion.",
      descAr: 'توقع غير المتوقع. أكثر سيارات الشوارع درامية بتصميم إيطالي مذهل وقوة خام.',
      categories: ['Supercar', 'GT', 'Huracán', 'Urus SUV', 'Hybrid'],
      popularModels: ['Revuelto', 'Urus Performante', 'Huracán STO'],
      accentColor: const Color(0xFFDB9B00),
    ),
    'Porsche': _BrandInfo(
      country: 'Germany',
      countryAr: 'ألمانيا',
      founded: '1931',
      descEn:
          'There is no substitute. Precision sports cars delivering unmatched driving dynamics.',
      descAr: 'لا يوجد بديل. سيارات رياضية دقيقة بديناميكيات قيادة لا مثيل لها في العالم.',
      categories: ['Sports Car', 'GT3 / GT4', 'SUV', 'EV Taycan', 'Classic'],
      popularModels: ['911 GT3', 'Cayenne Turbo', 'Taycan', 'Panamera'],
      accentColor: const Color(0xFFAA0000),
    ),
    'McLaren': _BrandInfo(
      country: 'UK',
      countryAr: 'المملكة المتحدة',
      founded: '1963',
      descEn: 'Pure, exhilarating driving. Lightweight supercars from Formula 1 racing DNA.',
      descAr: 'قيادة خالصة ومبهجة. سيارات سوبر خفيفة مستمدة من جينات الفورمولا 1.',
      categories: ['Supercar', 'GT', 'Track Cars', 'MSO Bespoke'],
      popularModels: ['750S', '720S', 'Artura', 'Senna'],
      accentColor: const Color(0xFFFF8000),
    ),
    'Bugatti': _BrandInfo(
      country: 'France',
      countryAr: 'فرنسا',
      founded: '1909',
      descEn: 'Art, forme, technique. The absolute pinnacle of automotive engineering.',
      descAr: 'فن، شكل، تقنية. القمة المطلقة في هندسة السيارات وأسرع الهايبر كار في الوجود.',
      categories: ['Hypercar', 'Limited Edition', 'Open Top'],
      popularModels: ['Chiron', 'Mistral', 'Veyron', 'Divo'],
      accentColor: const Color(0xFF0B3D8C),
    ),
    'Jaguar': _BrandInfo(
      country: 'UK',
      countryAr: 'المملكة المتحدة',
      founded: '1922',
      descEn: 'The art of performance. British refinement meets thrilling performance.',
      descAr: 'فن الأداء. الرقي البريطاني يلتقي بالأداء المثير في كل موديل جاغوار.',
      categories: ['Sports Car', 'Luxury Sedan', 'SUV', 'F-Type', 'EV'],
      popularModels: ['F-Type R', 'XF', 'F-Pace SVR', 'I-Pace'],
      accentColor: const Color(0xFF005A2B),
    ),
    'Mazda': _BrandInfo(
      country: 'Japan',
      countryAr: 'اليابان',
      founded: '1920',
      descEn: 'Jinba Ittai — oneness of car and driver. Premium design with Japanese reliability.',
      descAr: 'وحدة السيارة والسائق. تصميم فاخر مع الموثوقية اليابانية الأصيلة.',
      categories: ['SUV', 'Sedan', 'CX Series', 'Hybrid', 'Rotary'],
      popularModels: ['CX-90', 'CX-50', 'CX-5', 'Mazda 3', 'MX-5'],
      accentColor: const Color(0xFF7B262B),
    ),
    'Kia': _BrandInfo(
      country: 'South Korea',
      countryAr: 'كوريا الجنوبية',
      founded: '1944',
      descEn: 'Movement that inspires. Global design powerhouse with award-winning EVs.',
      descAr: 'حركة ملهمة. تحولت إلى مصنع تصميم عالمي بسيارات كهربائية حائزة على جوائز.',
      categories: ['EV', 'SUV', 'Sport', 'Family', 'GT Line'],
      popularModels: ['EV9', 'EV6', 'Sorento', 'Stinger', 'Carnival'],
      accentColor: const Color(0xFF05141F),
    ),
    'Volkswagen': _BrandInfo(
      country: 'Germany',
      countryAr: 'ألمانيا',
      founded: '1937',
      descEn: "Das Auto. Wide range from practical hatchbacks to refined luxury SUVs and EVs.",
      descAr: 'سيارة الشعب — مجموعة واسعة من الهاتشباك العملية إلى سيارات SUV وكهربائيات فاخرة.',
      categories: ['Hatchback', 'SUV', 'Sedan', 'EV', 'R Performance'],
      popularModels: ['Touareg R', 'Golf R', 'ID.4', 'Arteon', 'Tiguan R'],
      accentColor: const Color(0xFF001B62),
    ),
  };

  static final List<Map<String, dynamic>> _allCars = [
    {
      'name': 'Mercedes G63 AMG',
      'brand': 'Mercedes-Benz',
      'image': 'assets/images/cars/mercedes-benz.png',
      'price': '850,000 ر.س',
      'year': '2024',
      'mileage': '0 كم',
      'engine': '4.0L V8',
      'video_id': 'D7O8J5vVf-M',
    },
    {
      'name': 'Mercedes S580',
      'brand': 'Mercedes-Benz',
      'image': 'assets/images/cars/mercedes-benz.png',
      'price': '650,000 ر.س',
      'year': '2025',
      'mileage': '0 كم',
      'engine': '4.0L V8',
      'video_id': 'D7O8J5vVf-M',
    },
    {
      'name': 'BMW 7 Series',
      'brand': 'BMW',
      'image': 'assets/images/cars/bmw.png',
      'price': '450,000 ر.س',
      'year': '2024',
      'mileage': '0 كم',
      'engine': '3.0L I6',
      'video_id': 'D7O8J5vVf-M',
    },
    {
      'name': 'BMW X7 M60i',
      'brand': 'BMW',
      'image': 'assets/images/cars/bmw.png',
      'price': '520,000 ر.س',
      'year': '2025',
      'mileage': '0 كم',
      'engine': '4.4L V8',
      'video_id': 'D7O8J5vVf-M',
    },
    {
      'name': 'Toyota Land Cruiser 300',
      'brand': 'Toyota',
      'image': 'assets/images/cars/toyota.png',
      'price': '380,000 ر.س',
      'year': '2025',
      'mileage': '0 كم',
      'engine': '3.5L V6',
      'video_id': 'D7O8J5vVf-M',
    },
    {
      'name': 'Toyota Camry 3.5',
      'brand': 'Toyota',
      'image': 'assets/images/cars/toyota.png',
      'price': '145,000 ر.س',
      'year': '2025',
      'mileage': '0 كم',
      'engine': '3.5L V6',
      'video_id': 'D7O8J5vVf-M',
    },
    {
      'name': 'Tesla Model S Plaid',
      'brand': 'Tesla',
      'image': 'assets/images/cars/tesla.png',
      'price': '550,000 ر.س',
      'year': '2024',
      'mileage': '0 كم',
      'engine': 'Electric',
      'video_id': 'D7O8J5vVf-M',
    },
    {
      'name': 'Tesla Model 3',
      'brand': 'Tesla',
      'image': 'assets/images/cars/tesla.png',
      'price': '220,000 ر.س',
      'year': '2024',
      'mileage': '0 كم',
      'engine': 'Electric',
      'video_id': 'D7O8J5vVf-M',
    },
    {
      'name': 'Audi Q8 RS',
      'brand': 'Audi',
      'image': 'assets/images/cars/audi.png',
      'price': '480,000 ر.س',
      'year': '2025',
      'mileage': '0 كم',
      'engine': '4.0L V8',
      'video_id': 'D7O8J5vVf-M',
    },
    {
      'name': 'Audi A8 L',
      'brand': 'Audi',
      'image': 'assets/images/cars/audi.png',
      'price': '400,000 ر.س',
      'year': '2025',
      'mileage': '0 كم',
      'engine': '3.0L V6',
      'video_id': 'D7O8J5vVf-M',
    },
    {
      'name': 'Nissan Patrol Platinum',
      'brand': 'Nissan',
      'image': 'assets/images/cars/nissan.png',
      'price': '248,000 ر.س',
      'year': '2025',
      'mileage': '0 كم',
      'engine': '5.6L V8',
      'video_id': 'D7O8J5vVf-M',
    },
    {
      'name': 'Nissan GT-R Nismo',
      'brand': 'Nissan',
      'image': 'assets/images/cars/nissan.png',
      'price': '750,000 ر.س',
      'year': '2024',
      'mileage': '0 كم',
      'engine': '3.8L V6 TB',
      'video_id': 'D7O8J5vVf-M',
    },
    {
      'name': 'Ford Raptor R',
      'brand': 'Ford',
      'image': 'assets/images/cars/ford.png',
      'price': '320,000 ر.س',
      'year': '2025',
      'mileage': '0 كم',
      'engine': '5.2L V8',
      'video_id': 'D7O8J5vVf-M',
    },
    {
      'name': 'Hyundai IONIQ 6',
      'brand': 'Hyundai',
      'image': 'assets/images/cars/hyundai.png',
      'price': '195,000 ر.س',
      'year': '2024',
      'mileage': '0 كم',
      'engine': 'Electric',
      'video_id': 'D7O8J5vVf-M',
    },
    {
      'name': 'Lamborghini Revuelto',
      'brand': 'Lamborghini',
      'image': 'assets/images/cars/lamborghini.png',
      'price': '2,500,000 ر.س',
      'year': '2024',
      'mileage': '0 كم',
      'engine': '6.5L V12',
      'video_id': 'D7O8J5vVf-M',
    },
    {
      'name': 'Porsche 911 GT3',
      'brand': 'Porsche',
      'image': 'assets/images/cars/porsche.png',
      'price': '950,000 ر.س',
      'year': '2024',
      'mileage': '0 كم',
      'engine': '4.0L F6',
      'video_id': 'D7O8J5vVf-M',
    },
    {
      'name': 'McLaren 750S',
      'brand': 'McLaren',
      'image': 'assets/images/cars/mclaren.png',
      'price': '1,100,000 ر.س',
      'year': '2024',
      'mileage': '0 كم',
      'engine': '4.0L V8',
      'video_id': 'D7O8J5vVf-M',
    },
    {
      'name': 'Bugatti Chiron',
      'brand': 'Bugatti',
      'image': 'assets/images/cars/bugatti.png',
      'price': '12,000,000 ر.س',
      'year': '2024',
      'mileage': '0 كم',
      'engine': '8.0L W16',
      'video_id': 'D7O8J5vVf-M',
    },
    {
      'name': 'Jaguar F-Type R',
      'brand': 'Jaguar',
      'image': 'assets/images/cars/jaguar.png',
      'price': '480,000 ر.س',
      'year': '2024',
      'mileage': '0 كم',
      'engine': '5.0L V8',
      'video_id': 'D7O8J5vVf-M',
    },
    {
      'name': 'Mazda CX-90 Turbo S',
      'brand': 'Mazda',
      'image': 'assets/images/cars/mazda.png',
      'price': '185,000 ر.س',
      'year': '2025',
      'mileage': '0 كم',
      'engine': '3.3L I6 TB',
      'video_id': 'D7O8J5vVf-M',
    },
    {
      'name': 'Kia EV9 GT-Line',
      'brand': 'Kia',
      'image': 'assets/images/cars/kia.png',
      'price': '215,000 ر.س',
      'year': '2025',
      'mileage': '0 كم',
      'engine': 'Electric',
      'video_id': 'D7O8J5vVf-M',
    },
    {
      'name': 'Volkswagen Touareg R',
      'brand': 'Volkswagen',
      'image': 'assets/images/cars/volkswagen.png',
      'price': '290,000 ر.س',
      'year': '2025',
      'mileage': '0 كم',
      'engine': '2.9L V6',
      'video_id': 'D7O8J5vVf-M',
    },
  ];

  List<Map<String, dynamic>> get _brandCars => _allCars.where((car) {
    final brand = (car['brand'] as String).toLowerCase();
    return brand.contains(brandNameEn.toLowerCase()) || brandNameEn.toLowerCase().contains(brand);
  }).toList();

  _BrandInfo? get _info {
    for (final key in _brandInfoMap.keys) {
      if (brandNameEn.toLowerCase().contains(key.toLowerCase()) ||
          key.toLowerCase().contains(brandNameEn.toLowerCase())) {
        return _brandInfoMap[key];
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final cars = _brandCars;
    final info = _info;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final displayName = isAr ? brandNameAr : brandNameEn;
    final accent = info?.accentColor ?? AppColor.primaryColor(context);

    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── HERO APP BAR ──────────────────────────────────────────────────
          SliverAppBar(
            expandedHeight: 280.h,
            pinned: true,
            stretch: true,
            backgroundColor: AppColor.scaffoldColor(context),
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: EdgeInsets.all(8.w),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.whiteColor(context).withValues(alpha: 0.85),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 8),
                  ],
                ),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColor.blackTextColor(context),
                    size: 18.sp,
                  ),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.zoomBackground, StretchMode.blurBackground],
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Gradient background
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          accent.withValues(alpha: 0.18),
                          accent.withValues(alpha: 0.06),
                          AppColor.scaffoldColor(context),
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                  // Decorative huge faded brand name
                  Positioned(
                    bottom: 60.h,
                    left: isAr ? null : -20,
                    right: isAr ? -20 : null,
                    child: Text(
                      brandNameEn.toUpperCase(),
                      style: TextStyle(
                        color: accent.withValues(alpha: 0.055),
                        fontSize: 60.sp,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 6,
                        height: 1,
                      ),
                    ),
                  ),
                  // Decorative circle
                  Positioned(
                    top: -40.h,
                    right: isAr ? null : -40.w,
                    left: isAr ? -40.w : null,
                    child: Container(
                      width: 180.w,
                      height: 180.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: accent.withValues(alpha: 0.07),
                      ),
                    ),
                  ),
                  // Center content
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Gap(50.h),
                      // Logo in elegant circle
                      Container(
                        width: 96.w,
                        height: 96.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.whiteColor(context),
                          border: Border.all(color: accent.withValues(alpha: 0.2), width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: accent.withValues(alpha: 0.2),
                              blurRadius: 24,
                              offset: const Offset(0, 8),
                            ),
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.06),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(20.w),
                        child: Image.asset(
                          brandImage,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) =>
                              Icon(Icons.directions_car_rounded, color: accent, size: 44.sp),
                        ),
                      ),
                      Gap(14.h),
                      Text(
                        displayName,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 26.sp,
                          color: AppColor.blackTextColor(context),
                          letterSpacing: 0.5,
                        ),
                      ),
                      if (info != null) ...[
                        Gap(4.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.location_on_rounded, size: 12.sp, color: accent),
                            Gap(3.w),
                            Text(
                              isAr ? info.countryAr : info.country,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: accent,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '  ·  ',
                              style: TextStyle(color: Colors.grey[400], fontSize: 12.sp),
                            ),
                            Text(
                              'Since ${info.founded}',
                              style: TextStyle(fontSize: 12.sp, color: Colors.grey[500]),
                            ),
                          ],
                        ),
                      ],
                      Gap(16.h),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ── BRAND INFO SECTION ────────────────────────────────────────────
          if (info != null)
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Stats ribbon
                    Container(
                      margin: EdgeInsets.only(bottom: 20.h),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [accent.withValues(alpha: 0.07), accent.withValues(alpha: 0.03)],
                        ),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: accent.withValues(alpha: 0.12)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: _Stat(
                              icon: Icons.public_rounded,
                              value: isAr ? info.countryAr : info.country,
                              label: isAr ? 'المنشأ' : 'Origin',
                              accent: accent,
                            ),
                          ),
                          Container(width: 1, height: 40.h, color: accent.withValues(alpha: 0.12)),
                          Expanded(
                            child: _Stat(
                              icon: Icons.calendar_today_rounded,
                              value: info.founded,
                              label: isAr ? 'تأسست' : 'Founded',
                              accent: accent,
                            ),
                          ),
                          Container(width: 1, height: 40.h, color: accent.withValues(alpha: 0.12)),
                          Expanded(
                            child: _Stat(
                              icon: Icons.directions_car_rounded,
                              value: '${cars.length}+',
                              label: isAr ? 'موديلات' : 'Models',
                              accent: accent,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Description
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: accent.withValues(alpha: 0.18)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 3.w,
                                height: 18.h,
                                decoration: BoxDecoration(
                                  color: accent,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              Gap(8.w),
                              Text(
                                isAr ? 'نبذة عن الماركة' : 'About the Brand',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                              ),
                            ],
                          ),
                          Gap(10.h),
                          Text(
                            isAr ? info.descAr : info.descEn,
                            style: TextStyle(
                              color: AppColor.blackTextColor(context).withValues(alpha: 0.75),
                              fontSize: 13.sp,
                              height: 1.7,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(16.h),

                    // Categories
                    _SectionHeader(title: isAr ? 'الفئات المتاحة' : 'Categories', accent: accent),
                    Gap(10.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: info.categories
                          .map(
                            (cat) => Container(
                              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    accent.withValues(alpha: 0.12),
                                    accent.withValues(alpha: 0.06),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(30.r),
                                border: Border.all(color: accent.withValues(alpha: 0.3)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 6.w,
                                    height: 6.w,
                                    decoration: BoxDecoration(
                                      color: accent,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Gap(6.w),
                                  Text(
                                    cat,
                                    style: TextStyle(
                                      color: accent,
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    Gap(20.h),

                    // Popular models
                    _SectionHeader(
                      title: isAr ? 'أشهر الموديلات' : 'Popular Models',
                      accent: accent,
                    ),
                    Gap(10.h),
                    SizedBox(
                      height: 40.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: info.popularModels.length,
                        separatorBuilder: (_, __) => Gap(8.w),
                        itemBuilder: (_, i) => Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                accent.withValues(alpha: 0.14),
                                accent.withValues(alpha: 0.07),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: accent.withValues(alpha: 0.3)),
                          ),
                          child: Text(
                            info.popularModels[i],
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColor.blackTextColor(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Gap(24.h),
                    // Divider with cars label
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey.withValues(alpha: 0.2))),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Text(
                            '${cars.length} ${isAr ? "سيارة" : "Cars"}',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.grey.withValues(alpha: 0.2))),
                      ],
                    ),
                    Gap(8.h),
                  ],
                ),
              ),
            ),

          // ── CAR LIST ──────────────────────────────────────────────────────
          if (cars.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80.w,
                      height: 80.w,
                      decoration: BoxDecoration(color: Colors.grey[100], shape: BoxShape.circle),
                      child: Icon(Icons.car_crash_rounded, size: 40.sp, color: Colors.grey[300]),
                    ),
                    Gap(16.h),
                    Text(
                      AppLocaleKey.noCarsForBrand.tr(),
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gap(8.h),
                    Text(
                      AppLocaleKey.comingSoon.tr(),
                      style: TextStyle(color: Colors.grey[400], fontSize: 13.sp),
                    ),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 50.h),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 24.h),
                    child: MagazineCardWidget(car: cars[index]),
                  ),
                  childCount: cars.length,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ── Helper Widgets ─────────────────────────────────────────────────────────────
class _Stat extends StatelessWidget {
  final IconData icon;
  final String value, label;
  final Color accent;
  const _Stat({required this.icon, required this.value, required this.label, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: accent, size: 18.sp),
        Gap(4.h),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 13.sp,
            color: AppColor.blackTextColor(context),
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 10.sp, color: Colors.grey[500]),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final Color accent;
  const _SectionHeader({required this.title, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3.w,
          height: 16.h,
          decoration: BoxDecoration(color: accent, borderRadius: BorderRadius.circular(2)),
        ),
        Gap(8.w),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
        ),
      ],
    );
  }
}
