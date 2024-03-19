import 'package:flutter/material.dart';

import '../../../../../Core/text_styles/Styles.dart';

class UserState extends StatelessWidget {
  const UserState({
    super.key,
    required this.question,
    required this.ansswer, required this.onPressed,
  });
  final String question;
  final String ansswer;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
      height: MediaQuery.of(context).size.height / 2,
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                question,
                style: Styles.textStyle18,
              ),
              TextButton(
                  onPressed: onPressed,
                  child: Text(
                    ansswer,
                    style: Styles.textStyle18,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
