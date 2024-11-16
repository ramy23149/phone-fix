class ProductModel {
  final String imageUrl;
  final String desc;
  final String price;
  final String name;
  final Map<String, dynamic> storeInfo;
  final String type;
  ProductModel({
    required this.type,
    required this.storeInfo,
    required this.imageUrl,
    required this.desc,
    required this.price,
    required this.name,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      type: json['type'],
      storeInfo: json['storeInfo'],
      imageUrl: json['image'],
      desc: json['detalis'],
      price: json['price'],
      name: json['name'],
    );
  }
}
