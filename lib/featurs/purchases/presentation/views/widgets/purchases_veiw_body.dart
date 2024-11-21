import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Core/widgets/custom_appbar.dart';
import '../../../../home/Presentation/Manager/providers/customer_data_provider.dart';
import '../../../../home/Presentation/views/widgets/custom_virtical_list_item.dart';
import '../../../../home/data/models/product_model.dart';

class PurchasesViewBody extends StatelessWidget {
  const PurchasesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final userPhoneNumber = context.read<CustomerDataProvider>().phoneNumber;

    return Column(
      children: [
        const CustomAppBar(
          title: 'مشترياتك',
        ),
        const SizedBox(height: 20),
        Expanded(
          child: FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(userPhoneNumber)
                .collection('Purchases')
                .get(),
            builder: (context, snapshot) {
  if (snapshot.connectionState == ConnectionState.waiting) {
    return const Center(child: CircularProgressIndicator());
  } else if (snapshot.hasError) {
    return const Center(child: Text('Error fetching data'));
  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
    return const Center(child: Text('No purchases found'));
  } else {
    // Parse purchases
    final List<ProductModel> allItems = [];

    for (var doc in snapshot.data!.docs) {
      final items = (doc['items'] as List<dynamic>).map((item) {
        return ProductModel.fromPurchase(item as Map<String, dynamic>);
      }).toList();

      allItems.addAll(items);
    }

    return ListView.builder(
      itemCount: allItems.length,
      itemBuilder: (context, index) {
        return CustomVirticalListItem(productModel: allItems[index]);
      },
    );
  }
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
