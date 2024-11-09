import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery_app/Core/app_router.dart';
import 'package:food_delivery_app/Core/constats.dart';
import 'package:food_delivery_app/Core/widgets/custom_bottom.dart';
import 'package:food_delivery_app/featurs/on_boarding/presentation/views/widgets/smooth_indecator.dart';
import 'package:go_router/go_router.dart';

import 'onBording_PageView.dart';

class OnBordingViewBody extends StatefulWidget {
  const OnBordingViewBody({super.key});

  @override
  State<OnBordingViewBody> createState() => _OnBordingVoewBodyState();
}

class _OnBordingVoewBodyState extends State<OnBordingViewBody> {
  int cruntPage = 0;
  int pageIndex = 0;

  final PageController controller = PageController();

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        cruntPage = controller.page!.round();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 120,
            child: SmoothIndecator(activeDot: pageIndex),
          ),
          OnBordingPageView(
            controller: controller,
            onPageChanged: (int page) {
              cruntPage = page;
              pageIndex = page;
            },
          ),
          Positioned(
              bottom: 50,
              child: CustomBotton(
                onPressed: pageIndex == 2
                    ? () {
                        context.go(AppRouter.kLogInView);
                      }
                    : () {
                        controller.animateToPage(cruntPage + 1,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                width: MediaQuery.of(context).size.width * .8,
                text: pageIndex == 2 ? 'Start' : 'Next',
                backgroundColor: kMainAppColor,
                textColor: Colors.white,
              ))
        ],
      ),
    );
  }
}
