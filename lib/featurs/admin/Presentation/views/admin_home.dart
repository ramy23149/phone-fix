import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/featurs/admin/Presentation/manager/cubits/Add_Item_cubit/add_items_cubit.dart';
import 'package:food_delivery_app/featurs/admin/Presentation/views/widgets/admin_home_body.dart';

class HomeAdmin extends StatelessWidget {
  const HomeAdmin({super.key, this.isNeedsToAddService});
  final bool? isNeedsToAddService;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddItemsCubit(),
      child:  SafeArea(
        child: Scaffold(
          body: AdminHomeBody(isNeedsToAddService:isNeedsToAddService),
        ),
      ),
    );
  }
}
