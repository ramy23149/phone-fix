import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/featurs/home/Presentation/Manager/providers/change_category_provider.dart';
import 'package:food_delivery_app/featurs/home/data/models/product_model.dart';
import 'package:provider/provider.dart';

import 'custom_virtical_list_item.dart';

class LowerListView extends StatelessWidget {
  const LowerListView({super.key});


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
                   var docSnapshot = snapshot.data!.docs[index];
          
          var docData = docSnapshot.data() as Map<String, dynamic>;
                    return CustomVirticalListItem(
                      productModel: ProductModel.fromJson(docData),
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
