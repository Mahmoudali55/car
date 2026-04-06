import 'package:car/core/localization/app_locale_keys.dart';

class BrandModel {
  final String name;
  final String logo;
  final String localeKey;

  const BrandModel({
    required this.name,
    required this.logo,
    required this.localeKey,
  });

  static List<BrandModel> get brands => [
    const BrandModel(
      name: 'All',
      logo: '', // Empty for "All" option or a special icon
      localeKey: AppLocaleKey.all,
    ),
    const BrandModel(
      name: 'Mercedes-Benz',
      logo: 'assets/images/cars/mercedes-benz.png',
      localeKey: AppLocaleKey.mercedes,
    ),
    const BrandModel(
      name: 'BMW',
      logo: 'assets/images/cars/bmw.png',
      localeKey: AppLocaleKey.bmw,
    ),
    const BrandModel(
      name: 'Toyota',
      logo: 'assets/images/cars/toyota.png',
      localeKey: AppLocaleKey.toyota,
    ),
    const BrandModel(
      name: 'Tesla',
      logo: 'assets/images/cars/tesla.png',
      localeKey: AppLocaleKey.tesla,
    ),
    const BrandModel(
      name: 'Audi',
      logo: 'assets/images/cars/audi.png',
      localeKey: AppLocaleKey.audi,
    ),
  ];
}
