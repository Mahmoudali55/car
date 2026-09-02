import 'package:animate_do/animate_do.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/features/agent/data/model/customer_profile_model.dart';
import 'package:car/features/profile/presentation/screen/widget/info_tile_widget.dart';
import 'package:car/features/profile/presentation/screen/widget/section_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PersonalDetailsSectionWidget extends StatelessWidget {
  const PersonalDetailsSectionWidget({
    super.key,
    required this.profile,
    required TextEditingController nameController,
    required TextEditingController phoneController,
  }) : _nameController = nameController,
       _phoneController = phoneController;

  final CustomerProfileModel? profile;
  final TextEditingController _nameController;
  final TextEditingController _phoneController;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: SectionWidget(
        title: AppLocaleKey.personalDetails.tr(),
        children: [
          InfoTileWidget(
            icon: Icons.person_outline_rounded,
            label: AppLocaleKey.fullName.tr(),
            value: (profile?.displayName.isNotEmpty ?? false)
                ? profile!.displayName
                : (_nameController.text.isEmpty ? '---' : _nameController.text),
          ),

          InfoTileWidget(
            icon: Icons.phone_android_rounded,
            label: AppLocaleKey.mobileNumber.tr(),
            value: (profile?.formattedPhone.isNotEmpty ?? false)
                ? profile!.formattedPhone
                : (_phoneController.text.isEmpty ? '---' : _phoneController.text),
          ),
          InfoTileWidget(
            icon: Icons.location_on_outlined,
            label: AppLocaleKey.city.tr(),
            value: (profile?.cityName != null && profile!.cityName!.isNotEmpty)
                ? profile?.cityName ?? ""
                : '---',
          ),
          if (profile?.address != null && profile!.address!.isNotEmpty)
            InfoTileWidget(
              icon: Icons.home_outlined,
              label: AppLocaleKey.address.tr(),
              value: profile?.address ?? "",
            ),
          if (profile?.custTaxNo != null && profile!.custTaxNo!.isNotEmpty)
            InfoTileWidget(
              icon: Icons.receipt_long_outlined,
              label: AppLocaleKey.taxNumber.tr(),
              value: profile?.custTaxNo ?? "",
            ),
        ],
      ),
    );
  }
}
