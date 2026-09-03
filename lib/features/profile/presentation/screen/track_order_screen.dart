import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/services/services_locator.dart';
import 'package:car/features/home/presentation/cubit/home_cubit.dart';
import 'package:car/features/profile/presentation/screen/widget/track_order_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key, this.selectedOrderId});

  final String? selectedOrderId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<HomeCubit>()..getCustLoanApplications(HiveMethods.getUserCode() ?? ''),
      child: TrackOrderView(selectedOrderId: selectedOrderId),
    );
  }
}
