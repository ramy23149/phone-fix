import 'package:flutter/material.dart';
import 'package:food_delivery_app/featurs/home/data/models/product_model.dart';
import 'package:provider/provider.dart';

import '../../Manager/providers/confirum_filters_provider.dart';
import 'custom_virtical_list_item.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ConfirumFiltersProvider>(
      builder: (context, provider, child) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: provider.searchController,
              decoration: InputDecoration(
                hintText: "بحث",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  provider.search(value);
                } else {
                  provider.clearSearchResults();
                }
              },
            ),
            const SizedBox(height: 10),
            provider.isLoading?
            const Center(child: CircularProgressIndicator()):
            Expanded(
              child: ListView.builder(
                itemCount: provider.searchResults.length,
                itemBuilder: (context, index) {
                  var data = provider.searchResults[index].data()
                      as Map<String, dynamic>;
                  return CustomVirticalListItem(
                    productModel: ProductModel.fromJson(data),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
