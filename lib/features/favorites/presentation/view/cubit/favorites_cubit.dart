import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<Map<String, dynamic>> favorites;
  FavoritesLoaded(this.favorites);
}

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial()) {
    loadFavorites();
  }

  void loadFavorites() {
    final favoritesData = HiveMethods.getFavorites();
    final List<Map<String, dynamic>> favorites = favoritesData
        .map((e) => Map<String, dynamic>.from(e as Map))
        .toList();
    emit(FavoritesLoaded(favorites));
  }

  void toggleFavorite(Map<String, dynamic> car) {
    final currentState = state;
    if (currentState is FavoritesLoaded) {
      final List<Map<String, dynamic>> currentFavorites = List.from(
        currentState.favorites,
      );

      final index = currentFavorites.indexWhere(
        (element) => element['name'] == car['name'],
      );

      if (index != -1) {
        currentFavorites.removeAt(index);
      } else {
        currentFavorites.add(car);
      }

      HiveMethods.updateFavorites(currentFavorites);
      emit(FavoritesLoaded(currentFavorites));
    }
  }

  bool isFavorite(String carName) {
    final currentState = state;
    if (currentState is FavoritesLoaded) {
      return currentState.favorites.any(
        (element) => element['name'] == carName,
      );
    }
    return false;
  }
}
