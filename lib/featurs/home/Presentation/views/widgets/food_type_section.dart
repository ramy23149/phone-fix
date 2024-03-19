import 'package:flutter/material.dart';

import 'custom_food_type_item.dart';

class FoodTypeSection extends StatefulWidget {
  const FoodTypeSection({super.key});

  @override
  State<FoodTypeSection> createState() => _FoodTypeSectionState();
}

class _FoodTypeSectionState extends State<FoodTypeSection> {
    String foodType = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomFoodTypeItem(
                  isSelected: foodType == 'assets/images/ice-cream.png',
                  onFoodSelected: (selectedIceCream) {
                    setState(() {
                      foodType = selectedIceCream;
                    });
                  },
                  imageName: 'assets/images/ice-cream.png',
                ),
                CustomFoodTypeItem(
                  isSelected: foodType == 'assets/images/pizza.png',
                  onFoodSelected: (selectedPizza) {
                    setState(() {
                      foodType = selectedPizza;
                    });
                  },
                  imageName: 'assets/images/pizza.png',
                ),
                CustomFoodTypeItem(
                  isSelected: foodType == 'assets/images/salad.png',
                  onFoodSelected: (selectedSalad) {
                    setState(() {
                      foodType = selectedSalad;
                    });
                  },
                  imageName: 'assets/images/salad.png',
                ),
                CustomFoodTypeItem(
                  isSelected: foodType == 'assets/images/burger.png',
                  onFoodSelected: (selectedBurger) {
                    setState(() {
                      foodType = selectedBurger;
                    });
                  },
                  imageName: 'assets/images/burger.png',
                ),
              ],
            ),
          );
  }
}