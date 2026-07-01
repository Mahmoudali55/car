import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/admin/presentation/cubit/admin_cubit.dart';
import 'package:car/features/admin/presentation/screen/widgets/custom_representatives_tab_widget.dart';
import 'package:car/features/admin/presentation/screen/widgets/custom_suppliers_tab_widget.dart';
import 'package:car/features/admin/presentation/screen/widgets/custom_tab_bar_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ManageUsersScreen extends StatefulWidget {
  const ManageUsersScreen({super.key});

  @override
  State<ManageUsersScreen> createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _representativesSearchController = TextEditingController();
  // final TextEditingController _customersSearchController = TextEditingController();
  final TextEditingController _suppliersSearchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<AdminCubit>().searchRepresentatives('');
        // context.read<AdminCubit>().searchCustomers('');
        context.read<AdminCubit>().searchSuppliers('');
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _representativesSearchController.dispose();
    //  _customersSearchController.dispose();
    _suppliersSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: CustomAppBar(
        context,
        appBarColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColor.blackTextColor(context)),
        ),
        title: Text(
          AppLocaleKey.adminUserManagement.tr(),
          style: AppTextStyle.titleMedium(context).copyWith(
            color: AppColor.blackTextColor(context),
            fontWeight: FontWeight.w900,
            fontSize: 18.sp,
          ),
        ),
      ),
      body: Column(
        children: [
          CustomTabBarWidget(tabController: _tabController),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                CustomRepresentativesTabWidget(
                  representativesSearchController: _representativesSearchController,
                ),
                CustomSuppliersTabWidget(suppliersSearchController: _suppliersSearchController),
                // CustomCustomersTabWidget(customersSearchController: _customersSearchController),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
