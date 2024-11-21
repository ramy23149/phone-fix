import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/widgets/custom_loadingIndecator.dart';
import 'package:food_delivery_app/featurs/cart/views/widgets/product_item.dart';
import 'package:provider/provider.dart';

import '../../data/models/cart_product_model.dart';
import '../../manager/providers/user_cart_provider.dart';

class OrderListView extends StatelessWidget {
  const OrderListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<UserCartProvider, Stream<QuerySnapshot<Object?>>>(
      selector: (context, provider) => provider.getItems(context),
      builder: (context, value, child) => 
        StreamBuilder<QuerySnapshot<Object?>>(
          stream: value,
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.data!.docs.isNotEmpty &&
                snapshot.data != null) {
      
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    var ds = snapshot.data?.docs[index];
                    return ProductItem(
                      cartProductModel: CartProductModel.fromJson(ds!.data() as Map<String, dynamic>, ds.id),
                    );
                  });
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const CustomLoadingIndecator();
            } else if (snapshot.hasError) {
              return const Text('some thing went wrong');
            } else {
              return Image.asset('assets/images/cart.png');
            }
          }),
    );
  }
}
