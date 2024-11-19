import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../Core/app_router.dart';
import '../../../../../Core/constats.dart';
import '../../../../../Core/text_styles/Styles.dart';

class SelectWhatSparePartsStoreNeedToAdd extends StatelessWidget {
  const SelectWhatSparePartsStoreNeedToAdd({
    super.key,
    required this.lable,
    required this.icon,
  required  this.isNeedsToAddService,
  });
  final String lable;
  final IconData icon;
  final bool isNeedsToAddService;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            context.push(AppRouter.kAdminHome,extra: isNeedsToAddService);
          },
          child: Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width / 2.2,
            decoration: BoxDecoration(
                color: kWhite, borderRadius: BorderRadius.circular(16)),
            child: Icon(
              icon,
              size: 100,
            ),
          ),
        ),
        Text(
          lable,
          style: Styles.textStyle20,
        )
      ],
    );
  }
}
