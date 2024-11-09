  import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/featurs/on_boarding/presentation/views/widgets/onBording_view_item.dart';

class OnBordingPageView extends StatelessWidget {
  const OnBordingPageView({super.key, required this.controller, required this.onPageChanged});
 
 final PageController controller;
 final void Function(int) onPageChanged;
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      onPageChanged: onPageChanged,
      children: const [
        OnBordingViewItem(
            title1: 'Select form Our',
            sub1: 'Pick your fook from our menu',
            sub2: 'More than 35 times',
            imagePath: 'assets/images/screen1.png'),
        OnBordingViewItem(
            title1: 'Easy and Online Payment',
            sub1: 'You can pay cash on delivery and',
            sub2: 'Card payment is available',
            imagePath: 'assets/images/screen2.png'),
        OnBordingViewItem(
            title2: 'Your Doorstep',
            title1: 'Quick Delivery at',
            sub1: 'Deliver your food at your',
            sub2: 'Doorstep',
            imagePath: 'assets/images/screen3.png')
      ],
    );
  }
}
