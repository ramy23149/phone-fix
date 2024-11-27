import 'package:food_delivery_app/Core/widgets/bottomNav_bar.dart';
import 'package:food_delivery_app/featurs/auth/presentation/views/password_recavory.dart';
import 'package:food_delivery_app/featurs/home/Presentation/views/product_detalis_view.dart';
import 'package:food_delivery_app/featurs/home/data/models/filter_model.dart';
import 'package:food_delivery_app/featurs/home/data/models/product_model.dart';
import 'package:food_delivery_app/featurs/splash/Presentation/view/splash_view.dart';
import 'package:go_router/go_router.dart';
import '../featurs/admin/Presentation/views/admin_home.dart';
import '../featurs/admin/Presentation/views/admin_view.dart';
import '../featurs/admin/Presentation/views/select_what_spare_parts_store_need_to_add_view.dart';
import '../featurs/auth/data/models/update_passowrd_model.dart';
import '../featurs/auth/data/models/verificatoin_data_model.dart';
import '../featurs/auth/presentation/views/create_new_password_view.dart';
import '../featurs/auth/presentation/views/login_view.dart';
import '../featurs/auth/presentation/views/otp_verification_view.dart';
import '../featurs/auth/presentation/views/signUp_view.dart';
import '../featurs/auth/presentation/views/slect_role_view.dart';
import '../featurs/cart/views/order_view.dart';
import '../featurs/home/Presentation/views/search_view.dart';
import '../featurs/purchases/presentation/views/purchases_view.dart';

abstract class AppRouter {
  static String kProductDetalis = '/foodDetalis';
  static String kSignUpView = '/SignInViewBody';
  static String kLogInView = '/logInView';
  static String kBottomNavBar = '/BottomNavBar';
  static String kPasswordRecavory = '/PasswordRecavory';
  static String kAdminView = '/AdminView';
  static String kAdminHome = '/AdminHome';
  static String kCartView = '/CartView';
  static String kSelectRoleView = '/SelectRoleView';
  static String kVerifyView = '/VerifyView';
  static String kCreateNewPasswordView = '/CreateNewPasswordView';
  static String kSplashView = '/';
  static String kSearchView = '/SearchView';
  static String kSelectWhatSparePartsStoreNeedToAddView =
      '/SelectWhatSparePartsStoreNeedToAddView';
  static String kPurchasesView = '/PurchasesView';

  static final router = GoRouter(
    initialLocation: kSplashView,
    routes: <RouteBase>[
      GoRoute(
        path: kLogInView,
        builder: (context, state) {
          return const LogInView();
        },
      ),
      GoRoute(
        path: kSplashView,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(path: kPurchasesView, builder: (context, state) => const PurchasesView()),
      GoRoute(
          path: kSelectWhatSparePartsStoreNeedToAddView,
          builder: (context, state) =>
              const SelectWhatSparePartsStoreNeedToAddView()),
      GoRoute(
          path: kSearchView,
          builder: (context, state) {
            final filterModel = state.extra as FilterModel?;
            return SearchView(
              filterModel: filterModel,
            );
          }),
      GoRoute(
        path: kSignUpView,
        builder: (context, state) => const SignUpView(),
      ),
      GoRoute(path: kAdminView, builder: (context, state) => const AdminView()),
      GoRoute(path: kCartView, builder: (context, state) => const CartView()),

      // GoRoute(
      //   path: kBottomNavBar, // Route for BottomNavBar
      //   builder: (context, state) {
      //     if (FirebaseAuth.instance.currentUser != null) {
      //       return const BottomNavBar();
      //     } else {
      //       return const OnBordingView();
      //     }
      //   },
      // ),
      GoRoute(
          path: kAdminHome,
          builder: (context, state) {
            final isNeedsToAddService = state.extra as bool?;
            return HomeAdmin(isNeedsToAddService:isNeedsToAddService);
          }),
      GoRoute(
        path: kBottomNavBar,
        builder: (context, state) {
          final userRole = state.extra as String;
          return  BottomNavBar(
            userRole: userRole,
          );
        }
      ),
      GoRoute(
        path: kPasswordRecavory,
        builder: (context, state) => const PasswordRecavoryView(),
      ),
      GoRoute(
          path: kProductDetalis,
          builder: (context, state) {
            final productModel = state.extra! as ProductModel;
            return ProductDetalisView(
              productModel: productModel,
            );
          }),
      GoRoute(
        path: kSelectRoleView,
        builder: (context, state) => const SlectRoleView(),
      ),
      GoRoute(
          path: kVerifyView,
          builder: (context, state) {
            final data = state.extra as VerificatoinDataModel;
            return VerifyView(
              data: data,
            );
          }),
      GoRoute(
          path: kCreateNewPasswordView,
          builder: (context, state) {
            final updatePassowrdModel = state.extra as UpdatePassowrdModel;
            return CreateNewPasswordView(
                updatePasswordModel: updatePassowrdModel);
          })
    ],
  );
}
