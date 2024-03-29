import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery_app/Core/constats.dart';
import 'package:food_delivery_app/Core/widgets/custom_appbar.dart';
import 'package:food_delivery_app/Core/widgets/custom_bottom.dart';

import '../../../../Core/text_styles/Styles.dart';
import 'food_item.dart';

class OrderViewBody extends StatelessWidget {
  const OrderViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
       Column(
        children: [
          
          CustomAppBar(
            title: 'Food Cart',
          ),
          SizedBox(
            height: 10,
          ),
          FoodItem(),
        ],
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: ChekOutBox()),
    ]);
  }
}


class ChekOutBox extends StatelessWidget {
  const ChekOutBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      const  Divider(
          color: Colors.grey,
          thickness: 1,
        ),
      const  Padding(
          padding:  EdgeInsets.symmetric(horizontal: 8.0),
          child:  Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Price',style: Styles.textStyle20,),
              Text('\$350',style: Styles.textStyle20,),
            ],
          ),
        ),
      const  SizedBox(height: 15,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: CustomBotton(
            borderRadius: BorderRadius.circular(8),
            width: MediaQuery.of(context).size.width,
            textColor: kWhite,
            backgroundColor: kBlack,
            text: 'CheckOut'),
        ),
        const  SizedBox(height: 6,)
      ],
    );
  }
}