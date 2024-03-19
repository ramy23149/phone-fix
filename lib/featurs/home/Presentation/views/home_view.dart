import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/text_styles/Styles.dart';
import 'package:food_delivery_app/featurs/home/Presentation/views/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hallo ramy,',style: Styles.textStyle20),
            actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black,
              ),
              child: IconButton(
                iconSize: 27,
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                ), 
                onPressed: () {
                },
              ),
            ),
          ],
        ),
        body: HomeViewBody(),
        ),
    );
  }
}
