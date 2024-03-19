import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery_app/Core/text_styles/Styles.dart';
import 'package:food_delivery_app/featurs/home/Presentation/views/widgets/custom_horizontal_list_item.dart';
import 'package:food_delivery_app/featurs/home/Presentation/views/widgets/food_type_section.dart';

import 'widgets/custom_virtical_list_item.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Delicious Food',
              style: Styles.textStyle25,
            ),
            Text(
              'Discover and Get Great Food',
              style: Styles.textStyle14,
            ),
            SizedBox(
              height: 20,
            ),
            FoodTypeSection(),
            SizedBox(height: 40,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CustomUperListViewItem(),
                  CustomUperListViewItem(),
                  CustomUperListViewItem(),
                ],
              ),
            ),
              SizedBox(
              height: 20,
            ),
            CustomVirticalListItem(),
            CustomVirticalListItem()
          ],
        ),
      ),
    );
  }
}


