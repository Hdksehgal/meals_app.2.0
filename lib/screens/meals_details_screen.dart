import 'package:flutter/material.dart';
import 'package:meals_app/main.dart';
import 'package:meals_app/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:meals_app/providers/favourite_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealDetails extends ConsumerWidget {
  const MealDetails(
      {
        super.key,
        required this.meal,
        //required this.favouritesManipulator//RYP
      });
  final Meal meal;
  //final void Function(Meal meal) favouritesManipulator;//RYP

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FavouriteMeals = ref.watch(favoriteProvider);
    final isPresent = FavouriteMeals.contains(meal);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          meal.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: ThemeData().canvasColor,
              ),
        ),
        actions: [
          IconButton(
              onPressed: () {
               final wasAdded = ref.read(favoriteProvider.notifier).updateFavoriteList(meal);
               ScaffoldMessenger.of(context).clearSnackBars();
               ScaffoldMessenger.of(context)
                   .showSnackBar(SnackBar(content: Text(wasAdded ? "Meal Added to favorites" : "Meal Removed!" )));
              },
              icon: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                      opacity: Tween(begin: 0.1,end: 1.0).animate(animation),
                      child: child);
                },
                child: Icon( isPresent ?
                Icons.favorite_sharp : Icons.favorite_border_sharp,
                  color: Theme.of(context).copyWith().colorScheme.primary,
                  key: ValueKey(isPresent),
                ),
              ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
                child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Hero(
                      tag: meal.id,
                      child: FadeInImage(
                          placeholder: MemoryImage(kTransparentImage),
                          image: NetworkImage(meal.imageUrl)),
                    ))),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primaryContainer),
            ),
            for (final ingredient in meal.ingredients)
              Text(
                ingredient,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primaryContainer),
            ),
            for (final step in meal.steps)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
