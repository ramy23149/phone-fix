import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_delivery_app/Core/app_router.dart';
import 'package:food_delivery_app/Core/constats.dart';
import 'package:food_delivery_app/observer.dart';

import 'firebase_options.dart';


void main() async {
  Bloc.observer = AppObserver();
  WidgetsFlutterBinding.ensureInitialized();
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
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
