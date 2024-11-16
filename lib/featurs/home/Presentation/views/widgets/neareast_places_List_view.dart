import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/widgets/custom_loadingIndecator.dart';
import 'package:food_delivery_app/featurs/home/Presentation/Manager/providers/change_category_provider.dart';
import 'package:food_delivery_app/featurs/home/data/models/product_model.dart';
import 'package:provider/provider.dart';

import '../../../../../Core/text_styles/Styles.dart';
import '../../Manager/providers/customer_data_provider.dart';
import 'custom_horizontal_list_item.dart';

class NearestPlacesListView extends StatelessWidget {
  const NearestPlacesListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<ChangeCategoryProvider, Future<QuerySnapshot>>(
      selector: (context, value) => value.neriestProductsQuery(
          context: context, showTheNearestPlaces: true),
      builder: (context, query, child) => FutureBuilder<QuerySnapshot<Object?>>(
          future: query,
          builder: (context, snapshot) {
            print(context.watch<CustomerDataProvider>().districte);
            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 7),
                    child: Text(
                      ': الاقرب الى ${context.watch<CustomerDataProvider>().districte}',
                      style: Styles.textStyle25,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .37,
                    child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          var docSnapshot = snapshot.data!.docs[index];

                          // Convert the document data to a Map<String, dynamic>
                          var docData =
                              docSnapshot.data() as Map<String, dynamic>;
                          return CustomUperListViewItem(
                            productModel: ProductModel.fromJson(docData),
                          );
                        }),
                  ),
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const CustomLoadingIndecator();
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const SizedBox();
            } else {
              print(snapshot.error);
              return Center(
                  child: Text('There was an ${snapshot.error} error'));
            }
          }),
    );
  }
}
