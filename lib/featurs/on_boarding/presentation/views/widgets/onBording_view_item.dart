import 'package:flutter/cupertino.dart';

import '../../../../../Core/text_styles/Styles.dart';

class OnBordingViewItem extends StatelessWidget {
  const OnBordingViewItem({super.key, required this.title1, required this.sub1, required this.sub2, required this.imagePath, this.title2,});
  final String title1, sub1, sub2, imagePath;
  final String? title2;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width / 1.3,
            child: Image.asset(imagePath)),
        const Spacer(
          flex: 2,
        ),
        Text(
          title1,
          style: Styles.textStyle20.copyWith(fontWeight: FontWeight.w700),
        ),
      
      title2!=null?  Text(
          title2??'',
          style: Styles.textStyle20.copyWith(fontWeight: FontWeight.w700),
        ):const SizedBox(),
        const Spacer(),
        //const SizedBox(height: 25,),
        Opacity(
          opacity: .5,
          child: Text(
            sub1,
            style: Styles.textStyle20.copyWith(fontSize: 16),
          ),
        ),
        Opacity(
          opacity: .5,
          child: Text(
            sub2,
            style: Styles.textStyle20.copyWith(fontSize: 16),
          ),
        ),
        Spacer(
          flex: 10,
        )
      ],
    );
  }
}
