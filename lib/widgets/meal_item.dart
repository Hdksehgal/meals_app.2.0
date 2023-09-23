import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screens/meals_details_screen.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:meals_app/models/meal.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.favouritesManipulator});
  final Meal meal;
  final void Function(Meal meal) favouritesManipulator;

  String get complexityText{
    return meal.complexity.name[0].toUpperCase() + meal.complexity.name.substring(1);
  }

  String get affordabilityText{
    return meal.affordability.name[0].toUpperCase() + meal.affordability.name.substring(1);
  }

  void _showDetail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => MealDetails(meal: meal, favouritesManipulator: favouritesManipulator,)));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.hardEdge,
      elevation: 5,
      child: InkWell(
        onTap: () {
          _showDetail(context);
        },
        child: Stack(
          // this Stack widget is used to position multiple widgets
          // one above each other not as in column but directly above
          // each other as setting image as a background of the main text


          children: [
            FadeInImage(
              // it is a utility widget that is being
              // used to provide a faded in transition to the image

                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
              height: 250,
              width: double.infinity,
            ),
            Positioned(
              // this widget is used to position one widget on top another widget
              // in a stack

                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  color: Colors.black54,
                  child: Column(
                    children: [
                      Text(
                        meal.title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        // softwrap is used to make sure that text is wrapped
                        // in a good looking way

                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          MealTrait(icon: Icons.timer_sharp, label: '${meal.duration} min'),
                          SizedBox(width: 15),
                          MealTrait(icon: Icons.attach_money_sharp, label: affordabilityText),
                          SizedBox(width: 15),
                          MealTrait(icon: Icons.soup_kitchen_outlined, label: complexityText),

                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
