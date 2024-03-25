import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery_app/Core/text_styles/Styles.dart';
import 'package:food_delivery_app/featurs/home/Presentation/views/widgets/food_type_section.dart';
import 'package:food_delivery_app/featurs/home/Presentation/views/widgets/horizontal_List_view.dart';
import 'package:food_delivery_app/featurs/home/Presentation/views/widgets/virtical_list_view.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  String? foodType;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Delicious Food',
              style: Styles.textStyle25,
            ),
            const Text(
              'Discover and Get Great Food',
              style: Styles.textStyle14,
            ),
            const SizedBox(
              height: 20,
            ),
            FoodTypeSection(
              onBurgerSelected: () {
                setState(() {
  foodType = 'Burger';
});
              },
              onPizzaSelected: () {
                setState(() {
  foodType = 'pizza';
});
              },
              onSaladSelected: () {
                setState(() {
                  foodType = 'Salad';
                });
              },
              onIceCreamSelected: () {
                setState(() {
                  foodType = 'ice_cream';
                });
                
              
              },
            ),
            const SizedBox(
              height: 40,
            ),
          const  UperListView(
            
            ), //stream
            const SizedBox(
              height: 20,
            ),
            LowerListView(
              foodType: foodType??'ice_cream',
            ), //stream
          ],
        ),
      ),
    );
  }
}
