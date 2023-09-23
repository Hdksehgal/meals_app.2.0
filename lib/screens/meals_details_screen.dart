import 'package:flutter/material.dart';
import 'package:meals_app/main.dart';
import 'package:meals_app/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';

class MealDetails extends StatelessWidget {
  MealDetails({super.key, required this.meal, required this.favouritesManipulator});
  final Meal meal;
  final void Function(Meal meal) favouritesManipulator;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          meal.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: ThemeData().canvasColor,
              ),
        ),
        actions: [
          IconButton(onPressed:() {favouritesManipulator(meal);}, icon: Icon(Icons.favorite_sharp, color: Theme.of(context).copyWith().colorScheme.primary,))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
                child: Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: FadeInImage(
                        placeholder: MemoryImage(kTransparentImage),
                        image: NetworkImage(meal.imageUrl)
                    )
                )
            ),
            const SizedBox(height: 20,),
            Text('Ingredients', style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.primaryContainer
            ),),

            for( final ingredient in meal.ingredients)
              Text(ingredient, style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground
              ),),

            const SizedBox(height: 20,),
            Text('Steps', style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primaryContainer
            ),),

            for( final step in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Text(step,textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground
                ),),
              ),
          ],
        ),
      ),
    );
  }
}
