import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery_app/Core/text_styles/Styles.dart';
import 'package:food_delivery_app/featurs/home/Presentation/views/widgets/food_type_section.dart';
import 'package:food_delivery_app/featurs/home/Presentation/views/widgets/horizontal_List_view.dart';
import 'package:food_delivery_app/featurs/home/Presentation/views/widgets/virtical_list_view.dart';


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
            UperListView(),//stream
              SizedBox(
              height: 20,
            ),
          LowerListView(),//stream
          ],
        ),
      ),
    );
  }
}


