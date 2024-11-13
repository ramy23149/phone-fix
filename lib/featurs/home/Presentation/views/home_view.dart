import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/Core/servers/sherd_pref.dart';
import 'package:food_delivery_app/Core/text_styles/Styles.dart';
import 'package:food_delivery_app/featurs/auth/data/enums/store_type_enum.dart';
import 'package:food_delivery_app/featurs/home/Presentation/Manager/providers/customer_data_provider.dart';
import 'package:food_delivery_app/featurs/home/Presentation/views/home_view_body.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CustomerDataProvider>().fetchCustomerData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Consumer<CustomerDataProvider>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: Text(
                value.name != null ? '${value.name} مرحبا' : 'جاري التحميل...',
                style: Styles.textStyle20),
            bottom: TabBar(tabs: [
              Text(StoreTypeEnum.phoneAccessories.getDisplayName),
              Text(StoreTypeEnum.phoneSpareParts.getDisplayName)
            ]),
            toolbarHeight: 30,
          ),
          body: const TabBarView(children: [
            HomeViewBody(
              storeType: StoreTypeEnum.phoneAccessories,
            ),
            HomeViewBody(
              storeType: StoreTypeEnum.phoneSpareParts,
            ),
          ]),
        ),
      ),
    );
  }
}
