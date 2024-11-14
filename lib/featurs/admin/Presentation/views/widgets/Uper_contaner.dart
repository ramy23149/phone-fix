import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/constats.dart';


class LowerContaner extends StatelessWidget {
  const LowerContaner({
    super.key,
    
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*.59),
      height: MediaQuery.of(context).size.height *.5,
      width: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [kMainAppColor,Colors.red]
          ),
          
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      
    );
  }
}
