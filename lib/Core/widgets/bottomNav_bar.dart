  import 'package:curved_navigation_bar/curved_navigation_bar.dart';
  import 'package:flutter/material.dart';
  import 'package:food_delivery_app/featurs/Profile/views/profile_view.dart';
  import 'package:food_delivery_app/featurs/home/Presentation/views/home_view.dart';
  import 'package:food_delivery_app/featurs/cart/views/order_view.dart';
  import 'package:food_delivery_app/featurs/wallet/presentaion/views/wallet_view.dart';

  class BottomNavBar extends StatefulWidget {
    const BottomNavBar({super.key});

    @override
    State<BottomNavBar> createState() => _BottomNavBarState();
  }

  class _BottomNavBarState extends State<BottomNavBar> {
    int pageIndex = 0;

    late List<Widget> pagesList;
    late Widget crruntPage;
    late HomeView homeView;
    late OrderView orderView;
    late WalletView walletView;
    late ProfileView profileView;

    @override
    void initState() {
      homeView = const HomeView();
      orderView = const OrderView();
      walletView = const WalletView();
      profileView = const ProfileView();
      pagesList = [homeView, orderView, walletView, profileView];
      super.initState();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          animationDuration: const Duration(milliseconds: 500),
          height: 55,
          color: Colors.black,
          buttonBackgroundColor: Colors.black,
          backgroundColor: Colors.white,
          onTap: (index) {
            setState(() {
              pageIndex = index;
            });
          //   if(index==2){
          //     BlocProvider.of<AddMonyCubit>(context).addMony(100);
          //   }
          },
          items: const [
            Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.wallet_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.person_outline,
              color: Colors.white,
            )
          ],
        ),
        body: pagesList[pageIndex],
      );
    }
  }
