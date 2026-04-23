import 'package:car/core/localization/app_locale_keys.dart';

class BrandModel {
  final String name;
  final String logo;
  final String localeKey;

  const BrandModel({required this.name, required this.logo, required this.localeKey});

  static List<BrandModel> get brands => [
    const BrandModel(
      name: 'All',
      logo: '', // Empty for "All" option or a special icon
      localeKey: AppLocaleKey.all,
    ),
    const BrandModel(
      name: 'Mercedes-Benz',
      logo: 'assets/images/car.jpeg',
      localeKey: AppLocaleKey.mercedes,
    ),
    const BrandModel(name: 'BMW', logo: 'assets/images/car.jpeg', localeKey: AppLocaleKey.bmw),
    const BrandModel(name: 'Toyota', logo: '', localeKey: AppLocaleKey.toyota),
    const BrandModel(name: 'Tesla', logo: 'assets/images/car.jpeg', localeKey: AppLocaleKey.tesla),
    const BrandModel(name: 'Audi', logo: 'assets/images/car.jpeg', localeKey: AppLocaleKey.audi),
  ];
}
