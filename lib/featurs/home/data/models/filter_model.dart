class FilterModel {
  final int minPrice;
  final int maxPrice;
  final List<String>? categories;
  final String? brand;

  FilterModel({required this.minPrice, required this.maxPrice, this.categories, this.brand});
}