import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_delivery_app/Core/app_router.dart';
import 'package:food_delivery_app/Core/constats.dart';
import 'package:food_delivery_app/featurs/home/Presentation/Manager/providers/customer_data_provider.dart';
import 'package:food_delivery_app/observer.dart';
import 'package:provider/provider.dart';

import 'featurs/auth/presentation/manager/providers/auth_provider.dart';
import 'firebase_options.dart';


void main() async {
  Bloc.observer = AppObserver();
  WidgetsFlutterBinding.ensureInitialized();
await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp]);
  
  Stripe.publishableKey = kPublishablekey;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const DelivaryApp());
}

class DelivaryApp extends StatelessWidget {
  const DelivaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance
  .authStateChanges()
  .listen((User? user) {
    if (user == null) {
      print('User is currently signed out!=========================');
    } else {
      print('User is signed in!=========================');
    }
  });
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthUserProvider>(
          create: (context) => AuthUserProvider(),
        ),
        ChangeNotifierProvider<CustomerDataProvider>(
          create: (context) => CustomerDataProvider())
      ],
      child: SafeArea(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
