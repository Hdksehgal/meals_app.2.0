import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSetScreen});
  final void Function(String identifier) onSetScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.primaryContainer.withOpacity(.5),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
           ) ,
              child: Row(children: [
                Icon(Icons.fastfood_outlined, color: Theme.of(context).colorScheme.primary, size: 48,),
                const SizedBox(width: 8,),
                Text('Cooking up!',style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),)
              ],
              )
          ),
          ListTile(
            onTap: (){
              onSetScreen('meals');
            },
            leading: Icon(Icons.restaurant_menu, color: Theme.of(context).colorScheme.secondary,),
            title: Text('Meals', style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(context).colorScheme.secondary
            ),),
          ),
          ListTile(
            onTap: (){
              onSetScreen('filters');
            },
            leading: Icon(Icons.filter_list_sharp, color: Theme.of(context).colorScheme.secondary,),
            title: Text('Filters', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.secondary
            ),),
          )
        ],
      ),
    );
  }
}