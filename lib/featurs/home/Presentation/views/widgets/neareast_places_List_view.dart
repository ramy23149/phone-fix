import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/widgets/custom_loadingIndecator.dart';
import 'package:food_delivery_app/featurs/home/Presentation/Manager/providers/change_category_provider.dart';
import 'package:provider/provider.dart';

import 'custom_horizontal_list_item.dart';

class NearestPlacesListView extends StatelessWidget {
  const NearestPlacesListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<ChangeCategoryProvider,Future<QuerySnapshot>>(
      selector: (context, value) => value.neriestProductsQuery(context: context,showTheNearestPlaces: true),
      builder: (context, query, child) => 
      FutureBuilder<QuerySnapshot<Object?>>(
          future: query,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * .37,
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      var ds = snapshot.data?.docs[index];
                      return CustomUperListViewItem(
                        foodName: ds!['name'],
                        imageUrl: ds['image'],
                        price: ds['price'],
                        desc: ds['detalis'],
                      );
                    }),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const CustomLoadingIndecator();
            } else {
              print(snapshot.error);
              return Center(child: Text('There was an ${snapshot.error} error'));
            }
          }),
    );
  }
}
