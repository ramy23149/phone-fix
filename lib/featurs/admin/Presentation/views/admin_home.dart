import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/featurs/admin/Presentation/manager/cubits/Add_Item_cubit/add_items_cubit.dart';
import 'package:food_delivery_app/featurs/admin/Presentation/views/widgets/admin_home_body.dart';

class HomeAdmin extends StatelessWidget {
  const HomeAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddItemsCubit(),
      child: const SafeArea(
        child: Scaffold(
          //appBar: //AppBar(
          //   scrolledUnderElevation: 0,
          //   centerTitle: true,
          //   title: const Text('Add Item',style: Styles.textStyle20Extra,),
          // ),
          body: AdminHomeBody(),
        ),
      ),
    );
  }
}
