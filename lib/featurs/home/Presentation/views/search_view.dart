import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/featurs/home/Presentation/Manager/providers/confirum_filters_provider.dart';
import 'package:provider/provider.dart';

import '../../data/models/filter_model.dart';
import 'widgets/search_view_body.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key, required this.filterModel});
  final FilterModel? filterModel;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ConfirumFiltersProvider>(
      create: (context) => ConfirumFiltersProvider(
        filterModel: filterModel,
      )..confirmFilters(),
      child: const Scaffold(
        body: SearchViewBody(),
      ),
    );
  }
}
