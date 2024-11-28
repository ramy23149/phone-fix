
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../featurs/Profile/views/profile_view.dart';
import '../../featurs/auth/data/enums/user_role_enum.dart';
import '../../featurs/home/Presentation/views/home_view.dart';
import '../../featurs/cart/views/order_view.dart';
import '../../featurs/orders/presentation/views/orders_view.dart';
import '../../featurs/purchases/presentation/views/purchases_view.dart';
import '../../featurs/home/Presentation/Manager/providers/customer_data_provider.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<CustomerDataProvider>().fetchCustomerData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerDataProvider>(
      builder: (context, customerData, _) {
        final userRole = customerData.userRole;

        // Display a loading indicator until the user role is fetched
        if (userRole == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Determine the pages and navigation bar items based on user role
        final isUser = userRole == UserRoleEnum.user.getDisplayName;
        final pagesList = isUser
            ? [
                const HomeView(),
                const CartView(),
                const PurchasesView(),
                const ProfileView(),
              ]
            : [
                const HomeView(),
                const OrdersView(),
                const ProfileView(),
              ];

        final navBarItems = isUser
            ? const [
                Icon(Icons.home_outlined, color: Colors.white),
                Icon(Icons.shopping_cart_outlined, color: Colors.white),
                Icon(Icons.shopping_bag_outlined, color: Colors.white),
                Icon(Icons.person_outline, color: Colors.white),
              ]
            : const [
                Icon(Icons.home_outlined, color: Colors.white),
                Icon(Icons.list_alt_outlined, color: Colors.white),
                Icon(Icons.person_outline, color: Colors.white),
              ];

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
            items: navBarItems,
          ),
          body: pagesList[pageIndex],
        );
      },
    );
  }
}
