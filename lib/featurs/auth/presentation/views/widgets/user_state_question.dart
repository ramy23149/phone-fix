import 'package:flutter/material.dart';

import '../../../../../Core/text_styles/Styles.dart';

class UserStateQuestion extends StatelessWidget {
  const UserStateQuestion({
    super.key,
    required this.question,
    required this.ansswer,
    required this.onPressed,
  });
  final String question;
  final String ansswer;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text.rich(
            TextSpan(
              children: [
                WidgetSpan(
                  child: Transform.translate(
                    offset: const Offset(0, 15),
                    child: TextButton(
                      onPressed: onPressed,
                      child: Text(
                        ansswer, 
                        style: Styles.textStyle18,
                      ),
                    ),
                  ),
                ),
                TextSpan(
                  text: question,
                  style: Styles.textStyle18,
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
