import 'package:flutter/material.dart';
import '../../../../Core/text_styles/Styles.dart';

class FoodItem extends StatelessWidget {
  const FoodItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 120,
      padding: const EdgeInsets.only(bottom: 10,right: 15.0,left: 15.0),
      child: Material(
        borderRadius: BorderRadius.circular(16),
        elevation: 7,
        child: Container(
          margin: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 35,
                height: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xffA59EA5))),
                child: const Center(
                  child: Text(
                    '7',
                    style: TextStyle(
                        color: Color(0xffA59EA5), fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset('assets/images/food.jpg', height: 100)),
              ),
              const SizedBox(
                width: 13,
              ),
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      'Food',
                      style: Styles.textStyle20Extra,
                    ),
                    Text(
                      '\$200',
                      style: Styles.textStyle20Extra,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
