import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/featurs/auth/data/enums/user_role_enum.dart';
import 'package:food_delivery_app/featurs/auth/presentation/manager/providers/auth_provider.dart';
import 'package:go_router/go_router.dart';

import '../../../../../Core/app_router.dart';
import '../../../../../Core/constats.dart';
import '../../../../../Core/text_styles/Styles.dart';

class UserRoleContaner extends StatelessWidget {
  const UserRoleContaner({
    super.key,
    required this.icon,
    required this.role,
  });
  final IconData icon;
  final UserRoleEnum role;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            context.read<AuthUserProvider>().userRoleEnum = role;

            context.push(AppRouter.kSignUpView);
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
          role.getDisplayName,
          style: Styles.textStyle20,
        )
      ],
    );
  }
}
