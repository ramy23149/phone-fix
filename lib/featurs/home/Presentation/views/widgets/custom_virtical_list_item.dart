import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery_app/Core/app_router.dart';
import 'package:go_router/go_router.dart';

import '../../../../../Core/text_styles/Styles.dart';

class CustomVirticalListItem extends StatelessWidget {
  const CustomVirticalListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
     context.push(AppRouter.kfoodDetalis);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .2,
        padding: const EdgeInsets.only(right: 10,bottom: 10),
        child: Material(
          borderRadius: BorderRadius.circular(16),
          elevation: 7,
          child: Container(
            margin: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Image.asset(
                    "assets/images/salad2.png",
                              
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 13,
                ),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        'Salad',
                        style: Styles.textStyle20,
                      ),
                      Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        'Fresh and Healthy',
                        style: Styles.textStyle14,
                      ),
                      Text(
                        '\$25',
                        style: Styles.textStyle20,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
