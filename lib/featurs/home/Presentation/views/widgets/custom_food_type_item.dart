import 'package:flutter/material.dart';

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
      child: SizedBox(
        height: 70,
        child: Card(
          color: isSelected ? Colors.black : Colors.white,
          elevation: 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
              imageName,
                height: 50,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
