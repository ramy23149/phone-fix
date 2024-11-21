import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/app_router.dart';
import 'package:food_delivery_app/Core/helper/show_aweSome_dialog.dart';
import 'package:food_delivery_app/featurs/cart/data/models/cart_product_model.dart';
import 'package:food_delivery_app/featurs/cart/manager/providers/user_cart_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../Core/text_styles/Styles.dart';
import '../../../../Core/widgets/custom_loadingIndecator.dart';
import '../../../home/data/models/product_model.dart';
import 'custom_price_text.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.cartProductModel,
  });
  final CartProductModel cartProductModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRouter.kProductDetalis,
            extra: ProductModel.fromCart(cartProductModel));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 155,
        padding: const EdgeInsets.only(bottom: 10, right: 15.0, left: 15.0),
        child: Material(
          borderRadius: BorderRadius.circular(16),
          elevation: 7,
          child: Container(
            margin: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 35,
                  height: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: const Color(0xffA59EA5), width: 2.5)),
                  child: Center(
                    child: Text(
                      '${cartProductModel.count}',
                      style: const TextStyle(
                          color: Color(0xff9C959C),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Flexible(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      height: 100,
                      progressIndicatorBuilder: (context, url, progress) {
                        return const CustomLoadingIndecator();
                      },
                      imageUrl: cartProductModel.image,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) {
                        return const Icon(
                          Icons.error,
                          color: Colors.red,
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        maxLines: 4,
                        cartProductModel.name,
                        overflow: TextOverflow.ellipsis,
                        style: Styles.textStyle16,
                      ),
                    ],
                  ),
                ),
                Consumer<UserCartProvider>(
                  builder: (context, value, child) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            showAwesomeDialog(context, () {
                              value.deleteFromCart(
                                  cartProductModel.productId, context);
                            });
                          },
                          icon: const Icon(Icons.delete)),
                      CustomPriceText(price: cartProductModel.price),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

