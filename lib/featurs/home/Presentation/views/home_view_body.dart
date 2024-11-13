import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/Core/text_styles/Styles.dart';
import 'package:food_delivery_app/featurs/auth/data/enums/store_type_enum.dart';
import 'package:food_delivery_app/featurs/home/Presentation/Manager/providers/customer_data_provider.dart';
import 'package:food_delivery_app/featurs/home/Presentation/views/widgets/type_section.dart';
import 'package:food_delivery_app/featurs/home/Presentation/views/widgets/horizontal_List_view.dart';
import 'package:food_delivery_app/featurs/home/Presentation/views/widgets/virtical_list_view.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key, required this.storeType});
  final StoreTypeEnum storeType;
  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  String? type;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(
              height: 10,
            ),
            TypeSection(),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 7),
              child: Text(
                ': الاقرب الى ${context.watch<CustomerDataProvider>().districte}',
                style: Styles.textStyle25,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const UperListView(), //stream
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(right: 7),
              child: Text(": جميع المناطق", style: Styles.textStyle25),
            ),
            LowerListView(
              foodType: type ?? 'ice_cream',
            ), //stream
          ],
        ),
      ),
    );
  }
}
