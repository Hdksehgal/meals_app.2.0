import 'package:flutter/material.dart';

enum Filters  {glutenFree , lactoseFree, veg, vegan}

class FilterScreen extends StatefulWidget {
  FilterScreen({super.key, required this.presentState});
  Map<Filters,bool> presentState;

  @override
  State<FilterScreen> createState() {
    return _FilterScreenState();
  }
}

class _FilterScreenState extends State<FilterScreen> {
  var _glutenFreeFilter = false;
  var _lactoseFreeFilter = false;
  var _vegFilter = false;
  var _veganFilter = false;

  @override
  void initState() {
    super.initState();
    _glutenFreeFilter = widget.presentState[Filters.glutenFree]!;
    _lactoseFreeFilter = widget.presentState[Filters.lactoseFree]!;
    _vegFilter = widget.presentState[Filters.veg]!;
    _veganFilter = widget.presentState[Filters.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
      ),
      body: WillPopScope(
        // willpopscope helps in returning some data on
        // poping

        onWillPop: () async {
          // by adding async above we not only make sure
          // that we have to return a bool value which is future

          // but also async basically wraps the whole code block
          // of the function including th return false i.e. lso making
          // the return false futuristic

          Navigator.of(context).pop({
            Filters.glutenFree : _glutenFreeFilter,
            Filters.lactoseFree : _lactoseFreeFilter,
            Filters.veg : _vegFilter,
            Filters.vegan : _veganFilter
          });
          return false;
          // we returning a bool value for whether to pop or not
          // on returning the data
          // but since we are manually returning back by using navigator pop
          // we return false .

        },
        child: Column(
          children: [
            SwitchListTile(
              value: _glutenFreeFilter,
              onChanged: (isChecked) {
                setState(() {
                  _glutenFreeFilter = isChecked;
                });
              },
              title: Text(
                'Gluten free',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Only Gluten free meals are displayed',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 20, right: 30),
            ),


            SwitchListTile(
              value: _lactoseFreeFilter,
              onChanged: (isChecked) {
                setState(() {
                  _lactoseFreeFilter = isChecked;
                });
              },
              title: Text(
                'Lactose free',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Only Lactose free meals are displayed',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 20, right: 30),
            ),


            SwitchListTile(
              value: _vegFilter,
              onChanged: (isChecked) {
                setState(() {
                  _vegFilter = isChecked;
                });
              },
              title: Text(
                'Vegetarian',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Only Veg meals are displayed',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 20, right: 30),
            ),


            SwitchListTile(
              value: _veganFilter,
              onChanged: (isChecked) {
                setState(() {
                  _veganFilter = isChecked;
                });
              },
              title: Text(
                'Vegan',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Only Vegan meals are displayed',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 20, right: 30),
            )
          ],
        ),
      ),
    );
  }
}
