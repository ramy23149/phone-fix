import 'package:flutter/material.dart';

import 'custom_food_type_item.dart';

class FoodTypeSection extends StatefulWidget {
  const FoodTypeSection({super.key, required this.onBurgerSelected, required this.onPizzaSelected, required this.onSaladSelected, required this.onIceCreamSelected});
  final Function onBurgerSelected;
  final Function onPizzaSelected;
  final Function onSaladSelected;
  final Function onIceCreamSelected;

  @override
  State<FoodTypeSection> createState() => _FoodTypeSectionState();
}

class _FoodTypeSectionState extends State<FoodTypeSection> {
    String foodImage = 'assets/images/ice-cream.png';

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomFoodTypeItem(
                  isSelected: foodImage == 'assets/images/ice-cream.png',
                  onFoodSelected: (selectedIceCream) {
                    setState(() {
                      foodImage = selectedIceCream;
                      widget.onIceCreamSelected();
                    });
                    
                  },
                  imageName: 'assets/images/ice-cream.png',
                ),
                CustomFoodTypeItem(
                  isSelected: foodImage == 'assets/images/pizza.png',
                  onFoodSelected: (selectedPizza) {
                    setState(() {
                      foodImage = selectedPizza;
                        widget.onPizzaSelected();
                    });
                  
                  },
                  imageName: 'assets/images/pizza.png',
                ),
                CustomFoodTypeItem(
                  isSelected: foodImage == 'assets/images/salad.png',
                  onFoodSelected: (selectedSalad) {
                    setState(() {
                      foodImage = selectedSalad;
                      widget.onSaladSelected();
                    });
                    
                  },
                  imageName: 'assets/images/salad.png',
                ),
                CustomFoodTypeItem(
                  isSelected: foodImage == 'assets/images/burger.png',
                  onFoodSelected: (selectedBurger) {
                    setState(() {
                      foodImage = selectedBurger;
                        widget.onBurgerSelected();
                    });
                  
                  },
                  imageName: 'assets/images/burger.png',
                ),
              ],
            ),
          );
  }
}