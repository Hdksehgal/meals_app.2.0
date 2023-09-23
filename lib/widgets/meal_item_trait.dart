import 'package:flutter/material.dart';

class MealTrait extends StatelessWidget{
  MealTrait({super.key, required this.icon, required this.label});
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white70,),
        SizedBox(width: 10,),
        Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white70),),
      ],
    );

  }
}