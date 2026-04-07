import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/admin/presentation/screen/widgets/Image_upload_widget.dart';
import 'package:car/features/admin/presentation/screen/widgets/color_selection_widget.dart';
import 'package:car/features/admin/presentation/screen/widgets/features_selection_widget.dart';
import 'package:car/features/admin/presentation/screen/widgets/glass_dropdown_widget.dart';
import 'package:car/features/admin/presentation/screen/widgets/glass_field_widget.dart';
import 'package:car/features/cars/presentation/widget/section_title_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({super.key});

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  final List<String> selectedImages = [];
  String? selectedBrand;
  String? selectedCategory;
  final List<String> selectedOptions = [];
  final List<Color> selectedColors = [];

  final List<String> brands = ['Mercedes', 'BMW', 'Audi', 'Ferrari', 'Bentley', 'Toyota'];
  final List<String> categories = ['SUV', 'Sedan', 'Coupe', 'Sport', 'Luxury'];
  final List<String> features = [
    'Sunroof',
    'Leather Seats',
    'Navigation',
    'Bluetooth',
    'Backup Camera',
    'Apple CarPlay',
  ];
  final List<Color> availableColors = [
    Colors.black,
    Colors.white,
    Colors.grey,
    Colors.red,
    Colors.blue,
    Colors.brown,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: CustomAppBar(
        context,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColor.blackTextColor(context)),
        ),
        title: Text(
          AppLocaleKey.addLuxuryCar.tr(),
          style: AppTextStyle.titleMedium(context).copyWith(
            color: AppColor.blackTextColor(context),
            fontWeight: FontWeight.w900,
            fontSize: 18.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitleWidget(title: AppLocaleKey.carImages.tr()),
            Gap(16.h),
            ImageUploadWidget(),
            Gap(32.h),
            SectionTitleWidget(title: AppLocaleKey.basicInfo.tr()),
            Gap(16.h),
            GlassFieldWidget(hint: AppLocaleKey.carNameModel.tr(), maxLines: 1),
            Gap(16.h),
            Row(
              children: [
                Expanded(
                  child: GlassDropdownWidget(
                    hint: AppLocaleKey.brand.tr(),
                    items: brands,
                    value: selectedBrand,
                    onChanged: (v) => setState(() => selectedBrand = v),
                  ),
                ),
                Gap(16.w),
                Expanded(
                  child: GlassDropdownWidget(
                    hint: AppLocaleKey.category.tr(),
                    items: categories,
                    value: selectedCategory,
                    onChanged: (v) => setState(() => selectedCategory = v),
                  ),
                ),
              ],
            ),
            Gap(16.h),
            Row(
              children: [
                Expanded(
                  child: GlassFieldWidget(
                    hint: '${AppLocaleKey.price.tr()} (${AppLocaleKey.aed.tr()})',

                    keyboardType: TextInputType.number,
                    maxLines: 1,
                  ),
                ),
                Gap(16.w),
                Expanded(
                  child: GlassFieldWidget(
                    hint: AppLocaleKey.manufacturingYear.tr(),
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            Gap(16.h),
            GlassFieldWidget(hint: AppLocaleKey.carDescriptionDetail.tr(), maxLines: 4),
            Gap(32.h),
            SectionTitleWidget(title: AppLocaleKey.technicalSpecs.tr()),
            Gap(16.h),
            Row(
              children: [
                Expanded(
                  child: GlassFieldWidget(
                    hint: AppLocaleKey.engine.tr(),
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                  ),
                ),
                Gap(16.w),
                Expanded(
                  child: GlassFieldWidget(
                    hint: AppLocaleKey.mileage.tr(),
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            Gap(32.h),
            SectionTitleWidget(title: AppLocaleKey.colors.tr()),
            Gap(16.h),
            ColorSelectionWidget(availableColors: availableColors, selectedColors: selectedColors),
            Gap(32.h),
            SectionTitleWidget(title: AppLocaleKey.specifications.tr()),
            Gap(16.h),
            FeaturesSelectionWidget(features: features, selectedOptions: selectedOptions),
            Gap(40.h),
            CustomButton(text: AppLocaleKey.confirmAddCar.tr(), onPressed: () {}),
            Gap(40.h),
          ],
        ),
      ),
    );
  }
}
