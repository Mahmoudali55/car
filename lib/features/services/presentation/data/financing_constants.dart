import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/features/services/presentation/models/financing_models.dart';
import 'package:flutter/material.dart';

final kBrands = [
  'Mercedes',
  'BMW',
  'Toyota',
  'Tesla',
  'Audi',
  'Lexus',
  'Porsche',
];

final kModels = <String, List<String>>{
  'Mercedes': ['S-Class', 'G-Wagon', 'E-Class', 'GLE'],
  'BMW': ['X5', '7-Series', '5-Series', 'M4'],
  'Toyota': [
    'Raize',
    'Urban Cruiser',
    'Veloz',
    'Hilux',
    'Fortuner',
    'Yaris',
    'Corolla',
    'Highlander',
    'Innova',
    'Camry',
    'Land Cruiser',
    'Crown',
  ],
  'Tesla': ['Model S', 'Model X', 'Model 3', 'Model Y'],
  'Audi': ['A8', 'Q8', 'A6', 'RS7'],
  'Lexus': ['LX 600', 'LS 500', 'RX 350', 'ES 350'],
  'Porsche': ['911 Turbo', 'Taycan', 'Cayenne', 'Panamera'],
};

final kBanks = <BankOffer>[
  BankOffer(
    nameKey: AppLocaleKey.bankAlrajhi,
    logoText: 'AR',
    baseApr: 3.5,
    brandColor: const Color(0xFF133261),
  ),
  BankOffer(
    nameKey: AppLocaleKey.bankSnb,
    logoText: 'SNB',
    baseApr: 2.9,
    brandColor: const Color(0xFF00755F),
    supportedBrands: ['Mercedes', 'BMW', 'Audi', 'Porsche', 'Toyota'],
    campaigns: [
      BankCampaign(brand: 'Toyota', model: 'Raize', year: 2024, rate: 2.40),
      BankCampaign(brand: 'Toyota', model: 'Urban Cruiser', year: 2025, rate: 2.40),
      BankCampaign(brand: 'Toyota', model: 'Veloz', year: 2025, rate: 2.40),
      BankCampaign(brand: 'Toyota', model: 'Hilux', year: 2025, rate: 2.40),
      BankCampaign(brand: 'Toyota', model: 'Fortuner', year: 2025, rate: 2.40),
      BankCampaign(brand: 'Toyota', model: 'Raize', year: 2026, rate: 2.80),
      BankCampaign(brand: 'Toyota', model: 'Urban Cruiser', year: 2026, rate: 2.80),
      BankCampaign(brand: 'Toyota', model: 'Hilux', year: 2026, rate: 2.80),
      BankCampaign(brand: 'Toyota', model: 'Yaris', year: 2026, rate: 2.99),
      BankCampaign(brand: 'Toyota', model: 'Corolla', year: 2026, rate: 2.99),
      BankCampaign(brand: 'Toyota', model: 'Corolla', year: 2025, rate: 3.40),
      BankCampaign(brand: 'Toyota', model: 'Highlander', year: 2025, rate: 3.40),
      BankCampaign(brand: 'Toyota', model: 'Innova', year: 2026, rate: 3.40),
      BankCampaign(brand: 'Toyota', model: 'Camry', year: 2026, rate: 3.40),
      BankCampaign(brand: 'Toyota', model: 'Fortuner', year: 2026, rate: 3.40),
      BankCampaign(brand: 'Toyota', model: 'Land Cruiser', year: 2026, rate: 3.20),
      BankCampaign(brand: 'Toyota', model: 'Crown', year: 2026, rate: 3.80),
    ],
  ),
  BankOffer(
    nameKey: AppLocaleKey.bankRiyad,
    logoText: 'RB',
    baseApr: 3.2,
    brandColor: const Color(0xFFCE1126),
    supportedBrands: ['Toyota', 'Lexus', 'Nissan'],
  ),
  BankOffer(
    nameKey: AppLocaleKey.bankAlinma,
    logoText: 'INM',
    baseApr: 3.0,
    brandColor: const Color(0xFF886A34),
  ),
];
