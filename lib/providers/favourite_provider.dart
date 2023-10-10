import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';


class FavoriteMealsNotifier extends StateNotifier<List<Meal>>{
  FavoriteMealsNotifier() : super([]);
  // we cannot manipulate the favorite list i.e. favorite.add etc
  // so we have to create state list again

  bool updateFavoriteList(Meal meal){
    final isFavorite = state.contains(meal);
    if(isFavorite)
      {
        state = state.where((m) => m.id != meal.id).toList();
        // if meal is present in the state list then include every meals m in the list
        // the meal we are checking i.e. m stays in the list
        // if m.id does not match with meal.id that means meal is not in the list
        return false;
      }
    else
      {
        state = [...state, meal];
        // adding of the meal in the list
        return true;
      }
  }
}
// the class that'll be needed with the StateNotifierProvider
// should be named in such a way that the name should end with 'Notifier'

final favoriteProvider = StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});