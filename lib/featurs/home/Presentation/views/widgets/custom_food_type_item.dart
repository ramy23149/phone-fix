import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/constats.dart';

class CustomFoodTypeItem extends StatelessWidget {
  const CustomFoodTypeItem(
      {super.key,
      required this.imageName,
      required this.onFoodSelected,
      required this.isSelected});
  final String imageName;
  final Function(
    String,
  ) onFoodSelected;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onFoodSelected(imageName);
      },
      child: Container(
        decoration: BoxDecoration( 
           color: isSelected ? kMainAppColor : Colors.black,
          borderRadius: BorderRadius.circular(10),),
        height: 70,
        width: 70,
        child: Card(
          color: isSelected ? Colors.black : Colors.white,
          elevation: 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
              imageName,
                height: 50,
              
              ),
            ],
          ),
        ),
      ),
    );
  }
}
