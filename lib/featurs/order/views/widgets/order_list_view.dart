import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/widgets/custom_loadingIndecator.dart';
import 'package:food_delivery_app/featurs/order/views/widgets/food_item.dart';

import '../../../../Core/servers/data_base_methouds.dart';

class OrderListView extends StatefulWidget {
  const OrderListView({
    super.key,
    required this.onAdd,
  });
  final void Function(int) onAdd;

  @override
  State<OrderListView> createState() => _OrderListViewState();
}

class _OrderListViewState extends State<OrderListView> {
  Stream<QuerySnapshot<Object?>>? foodItemStream;

  getItems() async {
    foodItemStream = await DataBaseMethouds().getCart();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getItems();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Object?>>(
        stream: foodItemStream,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data!.docs.isNotEmpty &&
              snapshot.data != null) {
            return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  var ds = snapshot.data?.docs[index];
                  double totalPrices = 0;
                  for (var ds in snapshot.data!.docs) {
                    totalPrices += ds['totalPrice'];
                    widget.onAdd(totalPrices.toInt());
                  }
                  return FoodItem(
                    image: ds!['image'],
                    name: ds['name'],
                    price: ds['totalPrice'],
                    count: ds['quanter'],
                  );
                  
                });
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CustomLoadingIndecator();
          } else if (snapshot.hasError) {
            return const Text('some thing went wrong');
          } else {
            return Image.asset('assets/images/cart.png');
          }
        });
  }
}
