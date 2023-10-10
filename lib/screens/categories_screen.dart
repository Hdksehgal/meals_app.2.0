import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen(
      {super.key,
      //required this.favouritesManipulator,//RYP
      required this.currentMeals});
  //final void Function(Meal meal) favouritesManipulator;//RYP
  final List<Meal> currentMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  // we have converted this widget into stateful widget because when
  // we use the animations flutter will update or re render the
  // whenever the animations will be used

  late AnimationController _animation;
  // the late keyword is used to tell flutter that this property
  // doesn't have a value initially when the class is created
  // but will have one before it is needed.
  // OR
  // this in end is a variable not have a value when class is created
  // but will have a value as soon as it is being used for the first
  // time.

  @override
  void initState() {
    super.initState();

    // with keyword is used to merge or mixin the two classes
    // to provide certain features to this class.

    // TickerProviderStateMixin is used in case of more than one
    // animation controllers
    _animation = AnimationController(
      vsync: this,
      // vsync is responsible for making sure that this animation
      // executes for every frame.

      duration: Duration(milliseconds: 500),
      lowerBound: 0,
      upperBound: 1,
      // both the values of upperbound and lowerbound are by default set to 0
      // and 1 respectively by flutter
    );

    _animation.forward(); // to start the animation
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.currentMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => MealsScreen(
                  title: category.title,
                  meals: filteredMeals,
                  //favouritesManipulator: favouritesManipulator,//RYP
                )));
    // Alternate
    // Navigator.of(context).push()
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animation,

        // here child contains that part of the build method  or widget
        // that will be the part of the code to be animated but will
        // not be rebuild everytime
        child: GridView(
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
        ),
        builder: (context, child) => SlideTransition(
          position: Tween(
            begin: Offset(0 , 0.1),
            end: Offset(0,0),
          ).animate(CurvedAnimation(parent: _animation, curve: Curves.easeInBack))
          , child: child,)


            // Padding(
            //   padding: EdgeInsets.only(top: 100 - _animation.value * 100),
            //   child: child,
            // )
    );
  }
}
