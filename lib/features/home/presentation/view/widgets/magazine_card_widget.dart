import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/utils/navigator_methods.dart';
import 'package:car/features/home/presentation/cubit/home_cubit.dart';
import 'package:car/features/home/presentation/view/widgets/card_footer_widget.dart';
import 'package:car/features/home/presentation/view/widgets/card_image_widget.dart';
import 'package:car/features/home/presentation/view/widgets/card_top_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MagazineCardWidget extends StatelessWidget {
  const MagazineCardWidget({super.key, required this.car, this.heroTag});

  final Map<String, dynamic> car;
  final String? heroTag;

  void _navigateToDetails(BuildContext context) {
    final offers = context.read<HomeCubit>().state.normalFinancingStatus.data ?? const [];
    NavigatorMethods.pushNamed(
      context,
      RoutesName.carDetailsScreen,
      arguments: {'car': car, 'heroTag': heroTag, 'offers': offers},
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDetails(context),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.secondAppColor(context),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColor.borderColor(context).withValues(alpha: 0.5)),
          boxShadow: [
            BoxShadow(
              color: AppColor.blackColor(context).withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CardImage(car: car, heroTag: heroTag),
                CardTopBar(car: car),
              ],
            ),
            CardFooter(car: car),
          ],
        ),
      ),
    );
  }
}
