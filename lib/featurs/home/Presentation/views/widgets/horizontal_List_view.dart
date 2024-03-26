import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/servers/data_base_methouds.dart';
import 'package:food_delivery_app/Core/widgets/custom_loadingIndecator.dart';

import 'custom_horizontal_list_item.dart';

class UperListView extends StatefulWidget {
  const UperListView({
    super.key,
  });

  @override
  State<UperListView> createState() => _UperListViewState();
}

class _UperListViewState extends State<UperListView> {
  Stream<QuerySnapshot<Object?>>? foodItemStream;

  getItems() async {
    foodItemStream = await DataBaseMethouds().getItems('genral');
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
            return Text(snapshot.error.toString());
          }
        });
  }
}
