import 'package:flutter/material.dart';

import '../../../../Core/constats.dart';
import '../../../../Core/text_styles/Styles.dart';
import '../../../../Core/widgets/custom_bottom.dart';

class ChekOutBox extends StatelessWidget {
  const ChekOutBox({super.key,
  // required this.totalPrice
   });
  //final int totalPrice;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          const Divider(
            color: Colors.grey,
            thickness: 1,
          ),
           Padding(
            padding:const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              const  Text(
                  'Total Price',
                  style: Styles.textStyle20,
                ),
                Text(
                  '\$370',
                  style: Styles.textStyle20,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: CustomBotton(
                borderRadius: BorderRadius.circular(8),
                width: MediaQuery.of(context).size.width,
                textColor: kWhite,
                backgroundColor: kBlack,
                text: 'CheckOut'),
          ),
          const SizedBox(
            height: 6,
          )
        ],
      ),
    );
  }
}
