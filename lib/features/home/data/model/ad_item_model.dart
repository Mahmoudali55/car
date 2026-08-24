import 'package:car/features/home/data/model/financing_ad_model.dart';
import 'package:flutter/material.dart';

class AdItem {
  final int? programId;
  final String title;
  final String subtitle;
  final String tag;
  final String price;
  final String image;
  final Color accentColor;
  final List<Color> bgColors;
  final FinancingAdModel? rawModel;

  const AdItem({
    this.programId,
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.price,
    required this.image,
    required this.accentColor,
    required this.bgColors,
    this.rawModel,
  });

  factory AdItem.fromFinancingAd(FinancingAdModel model, int index) {
    const List<Color> accents = [
      Color(0xFFFFD700), // Gold
      Color(0xFF4FC3F7), // Light Blue
      Color(0xFFFF6B6B), // Coral
      Color(0xFF6C5CE7), // Purple
      Color(0xFF00B894), // Emerald
    ];

    const List<List<Color>> bgGradients = [
      [Color(0xFF1A1A1A), Color(0xFF3A3A3A)],
      [Color(0xFF0D1B2A), Color(0xFF1A3550)],
      [Color(0xFF1A0A0A), Color(0xFF3A1515)],
      [Color(0xFF190B28), Color(0xFF321450)],
      [Color(0xFF0A1F1B), Color(0xFF163E36)],
    ];

    final accent = accents[index % accents.length];
    final bg = bgGradients[index % bgGradients.length];

    final title = model.programName ?? model.itemName ?? model.modelName ?? 'حملة تمويلية خاصة';

    final List<String> details = [];
    if (model.interestRate != null) {
      details.add('فائدة ${model.interestRate}%');
    }
    if (model.firstInstallmentPct != null) {
      details.add('دفعة أولى ${model.firstInstallmentPct}%');
    }
    if (model.lastInstallmentPct != null && model.lastInstallmentPct! > 0) {
      details.add('دفعة أخيرة ${model.lastInstallmentPct}%');
    }
    final subtitle = details.isNotEmpty
        ? details.join(' | ')
        : (model.itemName ?? model.modelName ?? 'عروض السيارات التمويلية');

    final tag = (model.interestRate != null && model.interestRate == 0)
        ? 'بدون فائدة 0%'
        : (model.programName != null && model.programName!.contains('الانماء')
            ? 'بنك الانماء'
            : 'عرض تمويلي');

    final priceStr = (model.price != null && model.price! > 0)
        ? '${model.price!.toStringAsFixed(0)} ر.س'
        : 'تمويل حصري';

    return AdItem(
      programId: model.programId,
      title: title,
      subtitle: subtitle,
      tag: tag,
      price: priceStr,
      image: model.displayPicUrl,
      accentColor: accent,
      bgColors: bg,
      rawModel: model,
    );
  }
}
