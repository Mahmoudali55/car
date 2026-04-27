import 'package:car/core/custom_widgets/custom_loading/custom_loading.dart';
import 'package:car/features/favorites/presentation/view/cubit/favorites_cubit.dart';
import 'package:car/features/favorites/presentation/view/screen/widget/empty_state_widget.dart';
import 'package:car/features/favorites/presentation/view/screen/widget/favorite_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesLoaded) {
          if (state.favorites.isEmpty) {
            return const EmptyStateWidget();
          }
          return ListView.separated(
            padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 100.h),
            itemCount: state.favorites.length,
            separatorBuilder: (context, index) => Gap(16.h),
            itemBuilder: (context, index) {
              final car = state.favorites[index];
              return FavoriteItemWidget(car: car);
            },
          );
          ;
        }
        return const Center(child: CustomLoading());
      },
    );
  }
}
