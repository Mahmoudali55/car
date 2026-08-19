import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/agent/data/model/customer_model.dart';
import 'package:car/features/agent/presentation/cubit/agent_cubit.dart';
import 'package:car/features/agent/presentation/screens/widget/customer_dropdown_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/icon_btn_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AgentAddLeadScreen extends StatefulWidget {
  const AgentAddLeadScreen({super.key});

  @override
  State<AgentAddLeadScreen> createState() => _AgentAddLeadScreenState();
}

class _AgentAddLeadScreenState extends State<AgentAddLeadScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController interestedCarController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();
  final TextEditingController searchCustomerController = TextEditingController();

  CustomerModel? selectedCustomer;
  bool isCustomerDropdownOpen = false;

  @override
  void initState() {
    super.initState();
    context.read<AgentCubit>().getCustomer(null);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    interestedCarController.dispose();
    budgetController.dispose();
    searchCustomerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: CustomAppBar(
        context,
        elevation: 0,
        leading: IconBtn(
          icon: Icons.arrow_back_ios_new_rounded,
          onTap: () => Navigator.pop(context),
        ),
        title: Text(
          AppLocaleKey.agentAddNewCustomer.tr(),
          style: AppTextStyle.titleLarge(context).copyWith(
            color: AppColor.blackTextColor(context),
            fontWeight: FontWeight.w900,
            fontSize: 18.sp,
          ),
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
                AppLocaleKey.agentAddLeadDesc.tr(),
                style: AppTextStyle.bodyMedium(
                  context,
                ).copyWith(color: AppColor.greyColor(context), fontWeight: FontWeight.w500),
              ),
              Gap(24.h),
              Text(
                AppLocaleKey.agentSearchCustomer.tr(),
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
                    nameController.text = customer.customerName ?? '';
                    phoneController.text = customer.tel1 ?? '';
                  });
                },
                onSearch: (value) {
                  context.read<AgentCubit>().getCustomer(value);
                },
                context: context,
              ),
              Gap(20.h),
              CustomFormField(
                controller: nameController,
                title: AppLocaleKey.agentFullCustomerName.tr(),
                hintText: AppLocaleKey.agentEnterTripleName.tr(),
                prefixIcon: const Icon(Icons.person_outline_rounded),
              ),
              Gap(20.h),
              CustomFormField(
                controller: phoneController,
                title: AppLocaleKey.agentPhoneNumberLabel.tr(),
                hintText: '05xxxxxxxx',
                prefixIcon: const Icon(Icons.phone_android_rounded),
                keyboardType: TextInputType.phone,
              ),
              Gap(20.h),
              CustomFormField(
                controller: emailController,
                title: AppLocaleKey.agentEmailLabel.tr(),
                hintText: 'example@mail.com',
                prefixIcon: const Icon(Icons.email_outlined),
                keyboardType: TextInputType.emailAddress,
              ),
              Gap(20.h),
              CustomFormField(
                controller: interestedCarController,
                title: AppLocaleKey.agentInterestedCar.tr(),
                hintText: AppLocaleKey.agentCarExample.tr(),
                prefixIcon: const Icon(Icons.directions_car_outlined),
              ),
              Gap(20.h),
              CustomFormField(
                controller: budgetController,
                title: AppLocaleKey.agentExpectedBudget.tr(),
                hintText: AppLocaleKey.agentEnterEstimatedValue.tr(),
                prefixIcon: const Icon(Icons.payments_outlined),
                keyboardType: TextInputType.number,
              ),
              Gap(40.h),
              CustomButton(
                onPressed: () => Navigator.pop(context),
                radius: 12.r,
                child: Text(
                  AppLocaleKey.agentSaveCustomerAndStart.tr(),
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
