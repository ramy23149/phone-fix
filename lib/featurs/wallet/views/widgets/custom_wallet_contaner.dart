import 'package:flutter/material.dart';

import '../../../../Core/text_styles/Styles.dart';

class CustomWalletContaner extends StatelessWidget {
  const CustomWalletContaner({super.key});

  @override
  Widget build(BuildContext context) {
    return   Container(
          height: 80,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Color(0xffF0EEF0)
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Image.asset('assets/images/wallet.png',height: 60,width: 60,fit: BoxFit.cover,),
                const SizedBox(width: 20,),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Your Wallet",style: Styles.textStyle14,),
                    Text("\$0",style: Styles.textStyle20Extra,)
                  ],
                )
              ],
            ),
          ),
          );
  }
}