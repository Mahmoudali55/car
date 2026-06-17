import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/agent/presentation/cubit/agent_cubit.dart';
import 'package:car/features/agent/presentation/cubit/agent_state.dart';
import 'package:car/features/agent/presentation/screens/widget/custom_customer_empty_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/custom_customer_item_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/custom_leads_header_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AgentLeadsScreen extends StatefulWidget {
  const AgentLeadsScreen({super.key});
  @override
  State<AgentLeadsScreen> createState() => _AgentLeadsScreenState();
}

class _AgentLeadsScreenState extends State<AgentLeadsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AgentCubit>().getCustomer(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBarColor(context),
      body: NestedScrollView(
        headerSliverBuilder: (_, _) => [const CustomLeadsHeaderWidget()],
        body: BlocBuilder<AgentCubit, AgentState>(
          builder: (context, state) {
            if (state.customersStatus.isLoading) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(AppColor.blueColor(context)),
                ),
              );
            }
            if (state.customersStatus.isFailure) {
              return Center(
                child: Text(
                  state.customersStatus.error ?? AppLocaleKey.agentNoMatchesFound.tr(),
                  style: AppTextStyle.bodyMedium(
                    context,
                  ).copyWith(color: AppColor.hintColor(context), fontWeight: FontWeight.w700),
                ),
              );
            }
            final customers = state.customersStatus.data ?? [];
            if (customers.isEmpty) {
              return const CustomCustomerEmptyWidget();
            }
            return ListView.builder(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 40.h),
              itemCount: customers.length,
              itemBuilder: (_, index) {
                final customer = customers[index];
                final customerName = context.locale.languageCode == 'ar'
                    ? customer.customerName ?? customer.customerNameEng ?? '—'
                    : customer.customerNameEng ?? customer.customerName ?? '—';
                final phone =
                    customer.tel1 ?? customer.tel2 ?? AppLocaleKey.agentNoMatchesFound.tr();
                return CustomCustomerItemWidget(
                  customerName: customerName,
                  phone: phone,
                  customer: customer,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
