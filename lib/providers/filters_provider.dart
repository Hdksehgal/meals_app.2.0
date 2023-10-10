import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';

enum Filters { glutenFree, lactoseFree, veg, vegan }

class FilterNotifier extends StateNotifier<Map<Filters, bool>> {
  FilterNotifier()
      : super({
          Filters.vegan: false,
          Filters.veg: false,
          Filters.lactoseFree: false,
          Filters.glutenFree: false,
        });

  void filterUpdateAll(Map<Filters, bool> chosenfilters)
  {
    state = chosenfilters;
  }

  void filterUpdate(Filters filter, bool isUpdate) {
    // as we know that the state is immutable i.e. cannot be updated
    state = {...state, filter: isUpdate};
    // by doing this the state will copy its previous state
    // and by using filter:isUpdate ->  it will rewrite the filter passed
    // as an argument with the argument bool value
  }
}

final FiltersProvider =
    StateNotifierProvider<FilterNotifier, Map<Filters, bool>>(
        (ref) => FilterNotifier());

final FilteredMealsProvider = Provider((ref) {
  final activefilters = ref.watch(FiltersProvider);
  return dummyMeals.where((meal) {
    if(activefilters[Filters.glutenFree]! && !meal.isGlutenFree)
    {
      return false;
    }

    if(activefilters[Filters.lactoseFree]! && !meal.isLactoseFree)
    {
      return false;
    }

    if(activefilters[Filters.veg]! && !meal.isVegetarian)
    {
      return false;
    }

    if(activefilters[Filters.vegan]! && !meal.isVegan)
    {
      return false;
    }

    return true;
  }).toList();
});
