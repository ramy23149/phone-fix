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
    String foodImage = 'assets/images/covers.png';

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomFoodTypeItem(
                  isSelected: foodImage == 'assets/images/covers.png',
                  onFoodSelected: (selectedIceCream) {
                    setState(() {
                      foodImage = selectedIceCream;
                      widget.onIceCreamSelected();
                    });
                    
                  },
                  imageName: 'assets/images/covers.png',
                ),
                CustomFoodTypeItem(
                  isSelected: foodImage == 'assets/images/phone_charger.png',
                  onFoodSelected: (selectedPizza) {
                    setState(() {
                      foodImage = selectedPizza;
                        widget.onPizzaSelected();
                    });
                  
                  },
                  imageName: 'assets/images/phone_charger.png',
                ),
                CustomFoodTypeItem(
                  isSelected: foodImage == 'assets/images/head_phone.png',
                  onFoodSelected: (selectedSalad) {
                    setState(() {
                      foodImage = selectedSalad;
                      widget.onSaladSelected();
                    });
                    
                  },
                  imageName: 'assets/images/head_phone.png',
                ),
                CustomFoodTypeItem(
                  isSelected: foodImage == 'assets/images/genral_phone_accessories.webp',
                  onFoodSelected: (selectedBurger) {
                    setState(() {
                      foodImage = selectedBurger;
                        widget.onBurgerSelected();
                    });
                  
                  },
                  imageName: 'assets/images/genral_phone_accessories.webp',
                ),
              ],
            ),
          );
  }
}