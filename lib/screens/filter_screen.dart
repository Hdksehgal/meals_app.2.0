import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filters_provider.dart';

class FilterScreen extends ConsumerWidget {
  FilterScreen({
    super.key
    //required this.presentState//RYP
    });
  //Map<Filters, bool> presentState;//RYP


  // we have lean down the filters widget cause the main work is done
  // in the filters_provider so now we can make the widget statefree
  // and remove the necessary code from it and replace that directly from
  // the provider's use


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //since we have made the widget stateless we have to pass WidgetRef ref

    final activefilters = ref.watch(FiltersProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
      ),
      body:// the use of provider eliminates the use of WillPopScope RYP

      // WillPopScope(
      //   // willpopscope helps in returning some data on
      //   // poping
      //
      //   onWillPop: () async {
      //     // by adding async above we not only make sure
      //     // that we have to return a bool value which is future
      //
      //     // but also async basically wraps the whole code block
      //     // of the function including th return false i.e. lso making
      //     // the return false futuristic
      //
      //
      //     ref.read(FiltersProvider.notifier).filterUpdateAll({
      //       Filters.glutenFree: _glutenFreeFilter,
      //       Filters.lactoseFree: _lactoseFreeFilter,
      //       Filters.veg: _vegFilter,
      //       Filters.vegan: _veganFilter
      //     });
      //     return true;
      //
      //     // RYP
      //     // // Navigator.of(context).pop({
      //     // //   Filters.glutenFree: _glutenFreeFilter,
      //     // //   Filters.lactoseFree: _lactoseFreeFilter,
      //     // //   Filters.veg: _vegFilter,
      //     // //   Filters.vegan: _veganFilter
      //     // // });
      //     // return false;
      //     // we returning a bool value for whether to pop or not
      //     // on returning the data
      //     // but since we are manually returning back by using navigator pop
      //     // we return false .
      //   },
      //   child:
         Column(
          children: [
            SwitchListTile(
              value: activefilters[Filters.glutenFree]!,
              onChanged: (isChecked) {
                ref.read(FiltersProvider.notifier).filterUpdate(Filters.glutenFree, isChecked);
              },
              title: Text(
                'Gluten free',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Only Gluten free meals are displayed',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 20, right: 30),
            ),
            SwitchListTile(
              value: activefilters[Filters.lactoseFree]!,
              onChanged: (isChecked) {
                ref.read(FiltersProvider.notifier).filterUpdate(Filters.lactoseFree, isChecked);
              },
              title: Text(
                'Lactose free',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Only Lactose free meals are displayed',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 20, right: 30),
            ),
            SwitchListTile(
              value: activefilters[Filters.veg]!,
              onChanged: (isChecked) {
                ref.read(FiltersProvider.notifier).filterUpdate(Filters.veg, isChecked);
              },
              title: Text(
                'Vegetarian',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Only Veg meals are displayed',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 20, right: 30),
            ),
            SwitchListTile(
              value: activefilters[Filters.vegan]!,
              onChanged: (isChecked) {
                ref.read(FiltersProvider.notifier).filterUpdate(Filters.vegan, isChecked);
              },
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Only Vegan meals are displayed',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 20, right: 30),
            )
          ],
        ),
      );
  }
}
