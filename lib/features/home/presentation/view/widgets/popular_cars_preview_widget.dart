import 'package:car/core/network/contants.dart';
import 'package:car/features/home/data/model/brand_cars_data_model.dart';
import 'package:car/features/home/presentation/cubit/home_cubit.dart';
import 'package:car/features/home/presentation/view/widgets/magazine_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopularCarsPreviewWidget extends StatelessWidget {
  const PopularCarsPreviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final status = state.brandCarsStatus;
        if (status.isLoading) {
          return SizedBox(
            height: 200.h,
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (status.isSuccess && status.data != null) {
          final cars = status.data as List<GetBrandCarsDataModel>;
          if (cars.isEmpty) return const SizedBox.shrink();

          // Show only first 3
          final previewCars = cars.take(3).toList();

          final mappedCars = previewCars.map((car) {
            return {
              'name': car.itemName,
              'groupCode': car.groupCode.toString(),
              'itemCode': car.itemCode.toString(),
              'image': "${Constants.baseImage}${car.carImage}",
              'extraImages': car.extraImages
                  .map((e) => "${Constants.baseImage}${e.replaceAll('../../Img/Emp/', '')}")
                  .toList(),
              'brand': car.groupName,
              'price': '${car.price ?? "0"}',
              'year': car.makeYear.toString(),
              'mileage': '${car.kilometerReading ?? "0"} كم',
              'engine': '${car.cylinder} Cyl',
              'video_id': 'D7O8J5vVf-M',
              'isFavorite': false,
              'carStatus': car.carStatus,
              'carStatusText': car.carStatusText,
            };
          }).toList();

          return Column(
            children: mappedCars.map((car) {
              return Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: MagazineCardWidget(car: car),
              );
            }).toList(),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
