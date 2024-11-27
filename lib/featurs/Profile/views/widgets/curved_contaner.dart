import 'package:flutter/widgets.dart';

import '../../../../Core/constats.dart';

class CurvedContaner extends StatelessWidget {
  const CurvedContaner({super.key});

  @override
  Widget build(BuildContext context) {
    return   Container(
              height: MediaQuery.of(context).size.height/4.2,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [kMainAppColor, Color(0xffF84A1E)]),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(MediaQuery.of(context).size.width, 90),
                  
                )
              ),
            );
  }
}