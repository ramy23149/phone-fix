import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery_app/Core/app_router.dart';
import 'package:food_delivery_app/Core/text_styles/Styles.dart';
import 'package:go_router/go_router.dart';

class CustomUperListViewItem extends StatelessWidget {
  const CustomUperListViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRouter.kfoodDetalis),
      child: Container(
        width: MediaQuery.of(context).size.width*.6,
        height:  MediaQuery.of(context).size.height*.37,
      padding: const EdgeInsets.only(right: 10),
        child: Card(
          elevation: 5,
          child: Material(
            borderRadius: BorderRadius.circular(16),
            elevation: 6,
            child: Container(
              
              margin: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Image.asset(
                      "assets/images/salad2.png",
                    
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    'Salad',
                    
                    style: Styles.textStyle20,
                  ),
                  const Text(
                      maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    'Fresh and Healthy',
                    style: Styles.textStyle14,
                  ),
                  const Text(
                    '\$25',
                    style: Styles.textStyle20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}