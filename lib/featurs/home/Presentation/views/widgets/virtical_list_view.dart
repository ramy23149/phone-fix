import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/servers/data_base_methouds.dart';
import 'package:food_delivery_app/Core/widgets/custom_loadingIndecator.dart';

import 'custom_virtical_list_item.dart';

class LowerListView extends StatefulWidget {
  const LowerListView({super.key,required this.foodType});

  final String foodType;

  @override
  State<LowerListView> createState() => _LowerListViewState();
}

class _LowerListViewState extends State<LowerListView> {
  Stream<QuerySnapshot<Object?>>? foodItemStream;

  getItems() async {
    foodItemStream = await DataBaseMethouds().getItems(widget.foodType);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getItems();
  }

  @override
    void didUpdateWidget(LowerListView oldWidget) {
    if (oldWidget.foodType != widget.foodType) {
      getItems();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Object?>>(
        stream: foodItemStream,
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
                    imageUrl: ds['image'],
                    price: ds['price'],
                    desc: ds['detalis'],
                  );
                });
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CustomLoadingIndecator();
          } else {
            print(snapshot.error);
            return Text('there was an error ${snapshot.error}');
          }
        });
  }
}
