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
                color: kBlack,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(MediaQuery.of(context).size.width, 90),
                  
                )
              ),
            );
  }
}