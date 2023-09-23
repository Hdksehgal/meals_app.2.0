//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/main.dart';


class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.category, required this.selectCategory});

  final Category category;
  final void Function() selectCategory;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).primaryColor,
      onTap: selectCategory,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              category.color,
              category.color.withOpacity(.55)
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight
          )
        ),
        child: Center(
          child: Text(
            category.title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ),
      ),
    );
  }
}