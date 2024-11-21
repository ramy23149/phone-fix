class CartProductModel {
    final int count;
  final String image;
  final String name;
  final int price;
  final String productId;
  final String desc;
  final String type;
  final Map<String, dynamic> storeInfo;



  CartProductModel({
    required this.type,
    required this.desc,
    required this.storeInfo,
    required this.count,
    required this.image,
    required this.name,
    required this.price,
    required this.productId,
  });

factory CartProductModel.fromJson(Map<String, dynamic> json,String productId) => CartProductModel(
  type: json["type"],
  desc: json["detalis"],
    storeInfo: json["storeInfo"],
    count: json["quanter"],
    image: json["image"],
    name: json["name"],
    price: json["totalPrice"],
    productId: productId,
  );
}