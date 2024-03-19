import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/constats.dart';

abstract class Styles {
  static const textStyle18 =
      TextStyle(fontWeight: FontWeight.w600, fontSize: 18);

  static const textStyle20 = TextStyle(
      fontWeight: FontWeight.w600, fontSize: 20, fontFamily: kPoppins);

        static const textStyle20Extra = TextStyle(
      fontWeight: FontWeight.w800, fontSize: 20, fontFamily: kPoppins);


  static const textStyle25 = TextStyle(
      fontWeight: FontWeight.w800, fontSize: 25, fontFamily: kPoppins);

  static const textStyle14 = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 14,
      color: Color.fromARGB(255, 119, 118, 118),
      fontFamily: kPoppins);

  static const textStyle16 =
      TextStyle(fontWeight: FontWeight.w500, fontSize: 16);
}