import 'package:food_delivery_app/Core/widgets/bottomNav_bar.dart';
import 'package:food_delivery_app/featurs/admin/Presentation/views/admin_view.dart';
import 'package:food_delivery_app/featurs/auth/presentation/views/password_recavory.dart';
import 'package:food_delivery_app/featurs/home/Presentation/views/food_detalis_view.dart';
import 'package:food_delivery_app/featurs/on_boarding/presentation/views/on_bording_view.dart';
import 'package:go_router/go_router.dart';

import '../featurs/Profile/views/profile_view.dart';
import '../featurs/admin/Presentation/views/admin_home.dart';
import '../featurs/auth/presentation/views/login_view.dart';
import '../featurs/auth/presentation/views/signUp_view.dart';

abstract class AppRouter {
  static String kOnBording = '/';
  static String kfoodDetalis = '/foodDetalis';
  static String kSignUpView = '/SignInViewBody';
  static String kLogInView = '/logInView';
  static String kBottomNavBar = '/BottomNavBar';
  static String kPasswordRecavory = '/PasswordRecavory';
  static String kAdminView = '/AdminView';
  static String kAdminHome = '/AdminHome';

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
      GoRoute(path: '/', builder: (context, state) => const ProfileView()),
      GoRoute(
        path: kAdminHome,
        builder: (context, state) => const HomeAdmin(),
      ),
      GoRoute(
        path: kBottomNavBar,
        builder: (context, state) => const BottomNavBar(),
      ),
      GoRoute(
        path: kPasswordRecavory,
        builder: (context, state) => const PasswordRecavory(),
      ),
      GoRoute(
          path: kfoodDetalis,
          builder: (context, state) {
              final Map<String, dynamic> data = state.extra! as Map<String, dynamic>;
            return  FoodDetalisView(
              name: data['name'],
              imageUrl: data['image'],
              desc: data['detalis'],
              price: data['price'],
            );
          })
    ],
  );
}
