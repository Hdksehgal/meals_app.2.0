import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.favouritesManipulator, required this.currentMeals});
  final void Function(Meal meal) favouritesManipulator;
  final List<Meal> currentMeals;

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = currentMeals.where((meal) => meal.categories.contains(category.id)).toList();

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => MealsScreen(title: category.title, meals: filteredMeals, favouritesManipulator: favouritesManipulator,)));
    // Alternate
    // Navigator.of(context).push()
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: [
          for (final category in availableCategories)
            CategoryItem(
              category: category,
              selectCategory: () {
                _selectCategory(context, category);
              },
            )
        ],
    );
  }
}
