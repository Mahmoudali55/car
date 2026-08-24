import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/agent/data/model/customer_model.dart';
import 'package:car/features/agent/presentation/cubit/agent_cubit.dart';
import 'package:car/features/agent/presentation/screens/widget/customer_dropdown_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/icon_btn_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/note_tag_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AgentAddNoteScreen extends StatefulWidget {
  const AgentAddNoteScreen({super.key});
  @override
  State<AgentAddNoteScreen> createState() => _AgentAddNoteScreenState();
}

class _AgentAddNoteScreenState extends State<AgentAddNoteScreen> {
  final TextEditingController searchCustomerController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  CustomerModel? selectedCustomer;
  bool isCustomerDropdownOpen = false;

  @override
  void initState() {
    super.initState();
    context.read<AgentCubit>().getCustomer(null);
  }

  @override
  void dispose() {
    searchCustomerController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.w),
          child: IconBtn(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          AppLocaleKey.agentAddProfessionalNote.tr(),
          style: AppTextStyle.bodyLarge(
            context,
          ).copyWith(color: AppColor.blackTextColor(context), fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocaleKey.agentAddNoteDesc.tr(),
                style: AppTextStyle.bodyMedium(
                  context,
                ).copyWith(color: AppColor.greyColor(context), fontWeight: FontWeight.w500),
              ),
              Gap(24.h),
              Text(
                AppLocaleKey.agentTargetCustomer.tr(),
                style: AppTextStyle.formTitleStyle(context),
              ),
              Gap(5.h),
              CustomerDropdown(
                selected: selectedCustomer,
                isOpen: isCustomerDropdownOpen,
                searchController: searchCustomerController,
                onToggle: () {
                  setState(() {
                    isCustomerDropdownOpen = !isCustomerDropdownOpen;
                  });
                },
                onSelect: (customer) {
                  setState(() {
                    selectedCustomer = customer;
                    isCustomerDropdownOpen = false;
                  });
                },
                onSearch: (value) {
                  context.read<AgentCubit>().getCustomer(value);
                },
                context: context,
              ),
              Gap(20.h),
              CustomFormField(
                controller: noteController,
                radius: 12.r,
                title: AppLocaleKey.agentNoteText.tr(),
                hintText: AppLocaleKey.agentWriteNoteHint.tr(),
                prefixIcon: const Icon(Icons.edit_note_rounded),
                maxLines: 6,
              ),
              Gap(24.h),
              Text(
                AppLocaleKey.agentNoteClassification.tr(),
                style: AppTextStyle.bodySmall(context).copyWith(
                  color: AppColor.blackTextColor(context),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Gap(12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 5.w,
                children: [
                  Expanded(
                    child: NoteTag(
                      label: AppLocaleKey.agentFollowUp.tr(),
                      color: AppColor.blueColor(context),
                      isSelected: true,
                    ),
                  ),
                  Expanded(
                    child: NoteTag(
                      label: AppLocaleKey.agentGeneral.tr(),
                      color: AppColor.greyColor(context),
                    ),
                  ),
                  Expanded(
                    child: NoteTag(
                      label: AppLocaleKey.agentVeryImportant.tr(),
                      color: AppColor.redColor(context),
                    ),
                  ),
                ],
              ),
              Gap(30.h),
              CustomButton(
                radius: 12.r,
                onPressed: () => Navigator.pop(context),
                child: Text(
                  AppLocaleKey.agentSaveNote.tr(),
                  style: AppTextStyle.bodyMedium(
                    context,
                  ).copyWith(fontWeight: FontWeight.w900, color: AppColor.whiteColor(context)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
