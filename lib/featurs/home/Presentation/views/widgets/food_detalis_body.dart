import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery_app/Core/constats.dart';
import 'package:food_delivery_app/Core/text_styles/Styles.dart';
import 'package:food_delivery_app/Core/widgets/custom_bottom.dart';

import 'custom_counter.dart';

class FoodDetalisBody extends StatelessWidget {
  const FoodDetalisBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/images/salad2.png',
          height: MediaQuery.of(context).size.height*.4,
          width: MediaQuery.of(context).size.width,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: const Text('Salad',style:Styles.textStyle20,overflow: TextOverflow.ellipsis,)),
              CustomCounter()
            ],
          ),
        const  SizedBox(height: 7,),
          const Text('Low in Calories: When prepared without heavy dressings or fried toppings, salads can be a low-calorie option, making them ideal for those looking to manage their weight or maintain a healthy diet.'
          ,style: Styles.textStyle14,maxLines: 5,overflow: TextOverflow.fade,),
          const SizedBox(height: 27,),
          const Row(
            children: [
              Text('Delivery Time:',style: Styles.textStyle20,),
              SizedBox(width: 40,),
                Icon(Icons.alarm_outlined,color: Color(0xffB2ACB2),),
              Text(' 30 min',style: Styles.textStyle20,),
            ],
          ),
          const Spacer(),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                children: [
                  Text('Total Price',style: Styles.textStyle18,),
                  Text('\$50',style: Styles.textStyle20,)
                ],
              ),
              CustomBotton(

                borderRadius: BorderRadius.circular(16),
                textColor: kWhite,
                backgroundColor: kBlack,
                text: 'Add to cart  🛒')
            ],
          ),
        const  SizedBox(height: 5,)
        ],
      ),
    );
  }
}