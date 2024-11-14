import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/featurs/home/Presentation/Manager/providers/change_category_provider.dart';
import 'package:provider/provider.dart';

import 'custom_virtical_list_item.dart';

class LowerListView extends StatelessWidget {
  const LowerListView({super.key,required this.foodType});

  final String foodType;

  @override
  Widget build(BuildContext context) {
    return Selector<ChangeCategoryProvider,Future<QuerySnapshot>>(
    selector: (context, value) => value.neriestProductsQuery(context: context,showTheNearestPlaces: false),
    builder: (context, query, child) => 
       FutureBuilder<QuerySnapshot<Object?>>(
          future: query,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    var ds = snapshot.data?.docs[index];
                    return CustomVirticalListItem(
                      foodName: ds!['name'],
                      imageUrla: ds['image'],
                      price: ds['price'],
                      desc: ds['detalis'],
                    );
                  });
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox();
            } else {
              print(snapshot.error);
              return Center(child: Text('there was an error ${snapshot.error} error'));
            }
          }),
    );
  }
}
