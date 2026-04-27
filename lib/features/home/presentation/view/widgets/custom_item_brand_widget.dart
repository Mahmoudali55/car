import 'package:car/core/custom_widgets/custom_image/custom_network_image.dart';
import 'package:car/core/network/contants.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/home/data/model/cars_models_response.dart';
import 'package:car/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomItemBrandWidget extends StatelessWidget {
  const CustomItemBrandWidget({super.key, required this.brand});

  final CarModel brand;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<HomeCubit>().getBrandCars(brand.groupCode.toString());
        Navigator.pushNamed(context, RoutesName.popularCarsScreen);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.grey.withOpacity(0.15)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Image
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: CustomNetworkImage(
                      imageUrl:
                          "${Constants.baseImage}${brand.picturePath.replaceAll('../../Img/Emp/', '')}",
                      fit: BoxFit.contain,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
            ),

            // Name
            Padding(
              padding: EdgeInsets.fromLTRB(8.w, 0, 8.w, 10.h),
              child: Text(
                brand.groupName,
                textAlign: TextAlign.center,
                style: AppTextStyle.bodyMedium(context).copyWith(fontWeight: FontWeight.w600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
