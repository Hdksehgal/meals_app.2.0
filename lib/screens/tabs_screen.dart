import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/filter_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const kFilteredMeals = {
  Filters.glutenFree : false,
  Filters.lactoseFree : false,
  Filters.veg : false,
  Filters.vegan : false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    // TODO: implement createState
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedpage = 0;
  final List<Meal> _favouriteMeals = [];
  Map<Filters,bool> _selectedMeals = kFilteredMeals;

  void _setPage(index) {
    setState(() {
      _selectedpage = index;
    });
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final results = await  Navigator.of(context).push<Map<Filters, bool>>(MaterialPageRoute(
        builder: (context) => FilterScreen(presentState: _selectedMeals),
      ),);

      // we can print the result to check what data has been returned

      setState(() {
        _selectedMeals = results ?? kFilteredMeals;
      });

      // ?? is a special operator which checks whether the value
      // written before ?? is null if it is null then the
      // fallback value (i.e. kFilteredMeals) is assigned
    }
  }

  void _showFavorites(Meal meal) {
    final IsPresent = _favouriteMeals.contains(meal);

    if (IsPresent) {
      setState(() {
        _favouriteMeals.remove(meal);
      });
      showMessage('Meal is removed from the favourites');
    } else {
      setState(() {
        _favouriteMeals.add(meal);
      });
      showMessage('Meal is added to the favourites');
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if(_selectedMeals[Filters.glutenFree]! && !meal.isGlutenFree)
        {
          return false;
        }

      if(_selectedMeals[Filters.lactoseFree]! && !meal.isLactoseFree)
        {
          return false;
        }

      if(_selectedMeals[Filters.veg]! && !meal.isVegetarian)
        {
          return false;
        }

      if(_selectedMeals[Filters.vegan]! && !meal.isVegan)
        {
          return false;
        }

      return true;
    }).toList();

    Widget activeScreen = CategoriesScreen(
      favouritesManipulator: _showFavorites,
      currentMeals: availableMeals,
    );
    Widget activeTitle = Text('Categories');

    if (_selectedpage == 1) {
      activeScreen = MealsScreen(
        meals: _favouriteMeals,
        favouritesManipulator: _showFavorites,
      );
      activeTitle = Text('Favourites');
    }

    return Scaffold(
      appBar: AppBar(
        title: activeTitle,
      ),
      drawer: MainDrawer(onSetScreen: _setScreen),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedpage,
        onTap: _setPage,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal_rounded), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_sharp), label: 'Favourites')
        ],
      ),
    );
  }
}
