import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery_app/Core/text_styles/Styles.dart';
import 'package:food_delivery_app/featurs/auth/data/enums/store_type_enum.dart';
import 'package:food_delivery_app/featurs/home/Presentation/views/widgets/type_section.dart';
import 'package:food_delivery_app/featurs/home/Presentation/views/widgets/neareast_places_List_view.dart';
import 'package:food_delivery_app/featurs/home/Presentation/views/widgets/virtical_list_view.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key, required this.storeType});
  final StoreTypeEnum storeType;
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 10,
            ),
            TypeSection(),
            NearestPlacesListView(),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(right: 7),
              child: Text(": جميع المناطق", style: Styles.textStyle25),
            ),
            LowerListView(),
          ],
        ),
      ),
    );
  }
}
