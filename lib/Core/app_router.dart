import 'package:food_delivery_app/Core/widgets/bottomNav_bar.dart';
import 'package:food_delivery_app/featurs/auth/presentation/views/password_recavory.dart';
import 'package:food_delivery_app/featurs/home/Presentation/views/food_detalis_view.dart';
import 'package:food_delivery_app/featurs/wallet/presentaion/views/wallet_view.dart';
import 'package:go_router/go_router.dart';

import '../featurs/auth/presentation/views/login_view.dart';
import '../featurs/auth/presentation/views/signUp_view.dart';

abstract class AppRouter {
  static String kOnBording = '/';
  static String kfoodDetalis = '/foodDetalis';
  static String kSignUpView = '/SignInViewBody';
  static String kLogInView = '/logInView';
  static String kBottomNavBar = '/BottomNavBar';
  static String kPasswordRecavory = '/PasswordRecavory';

  static final router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: kLogInView,
        builder: (context, state) {
          return const LogInView();
        },
      ),
      GoRoute(
        path: kSignUpView,
        builder: (context, state) => const SignUpView(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const WalletView(),//OnBordingView()
      ),
      GoRoute(
        path: kBottomNavBar,
        builder: (context, state) => const BottomNavBar(),
      ),
      GoRoute(
        
        path: kPasswordRecavory,
        builder: (context, state) =>  PasswordRecavory(),
      ),
      GoRoute(
        path: kfoodDetalis,
        builder: (context, state) => const FoodDetalisView(),
      )
    ],
  );
}