
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/featurs/Profile/views/profile_view.dart';
import 'package:food_delivery_app/featurs/auth/data/enums/user_role_enum.dart';
import 'package:food_delivery_app/featurs/home/Presentation/views/home_view.dart';
import 'package:food_delivery_app/featurs/cart/views/order_view.dart';
import '../../featurs/orders/presentation/views/orders_view.dart';
import '../../featurs/purchases/presentation/views/purchases_view.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key, required this.userRole});
final String userRole;
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int pageIndex = 0;
  List<Widget>? pagesList;
  List<Widget>? navBarItems;

  Future<void> _initializeNavBar() async {
    // Wait for userRole to be available
    

    if (widget.userRole == UserRoleEnum.user.getDisplayName) {
      pagesList = [
        const HomeView(),
        const CartView(),
        const PurchasesView(),
        const ProfileView()
      ];
      navBarItems = const [
        Icon(Icons.home_outlined, color: Colors.white),
        Icon(Icons.shopping_cart_outlined, color: Colors.white),
        Icon(Icons.shopping_bag_outlined, color: Colors.white),
        Icon(Icons.person_outline, color: Colors.white),
      ];
    } else {
      pagesList = [
        const HomeView(),
        const OrdersView(),
        const ProfileView(),
      ];
      navBarItems = const [
        Icon(Icons.home_outlined, color: Colors.white),
        Icon(Icons.list_alt_outlined, color: Colors.white),
        Icon(Icons.person_outline, color: Colors.white),
      ];
    }

    setState(() {
      // Trigger a rebuild once initialization is complete
      pageIndex = 0;
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeNavBar();
  }

  @override
  Widget build(BuildContext context) {
    // Show a loading indicator while navBarItems/pagesList is being initialized
    if (navBarItems == null || pagesList == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: pageIndex,
        animationDuration: const Duration(milliseconds: 500),
        height: 55,
        color: Colors.black,
        buttonBackgroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        items: navBarItems!,
      ),
      body: pagesList![pageIndex],
    );
  }
}
