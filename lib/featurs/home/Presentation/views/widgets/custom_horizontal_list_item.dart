import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/app_router.dart';
import 'package:food_delivery_app/Core/text_styles/Styles.dart';
import 'package:food_delivery_app/Core/widgets/custom_loadingIndecator.dart';
import 'package:food_delivery_app/featurs/home/data/models/product_model.dart';
import 'package:go_router/go_router.dart';

class CustomUperListViewItem extends StatelessWidget {
  const CustomUperListViewItem({
    super.key, required this.productModel,

  });
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRouter.kProductDetalis, extra: productModel),
      child: Container(
        width: MediaQuery.of(context).size.width * .6,
        height: MediaQuery.of(context).size.height * .37,
        padding: const EdgeInsets.only(right: 10),
        child: Card(
          elevation: 5,
          child: Material(
            borderRadius: BorderRadius.circular(16),
            elevation: 6,
            child: Container(
              margin: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Align(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Hero(
                          tag: productModel.imageUrl,
                          child: CachedNetworkImage(
                            height: 150,
                            width: 150,
                            progressIndicatorBuilder: (context, url, progress) {
                              return const CustomLoadingIndecator();
                            },
                            imageUrl: productModel.imageUrl,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) {
                              return const Icon(
                                Icons.error,
                                color: Colors.red,
                              );
                            },
                            //BoxFit.cover
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    productModel.name,
                    style: Styles.textStyle20,
                  ),
                  Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    productModel.desc,
                    style: Styles.textStyle14,
                  ),
                  Text(
                    '${productModel.price} EGP',
                    style: Styles.textStyle20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
