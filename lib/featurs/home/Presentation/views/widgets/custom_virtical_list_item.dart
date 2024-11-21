import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery_app/Core/app_router.dart';
import 'package:food_delivery_app/Core/widgets/custom_loadingIndecator.dart';
import 'package:food_delivery_app/featurs/home/data/models/product_model.dart';
import 'package:go_router/go_router.dart';

import '../../../../../Core/text_styles/Styles.dart';

class CustomVirticalListItem extends StatelessWidget {
  const CustomVirticalListItem(
      {super.key, required this.productModel,
});
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRouter.kProductDetalis, extra: productModel);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .21,
        padding: const EdgeInsets.only(right: 10, bottom: 10),
        child: Material(
          borderRadius: BorderRadius.circular(16),
          elevation: 7,
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      height: 100,
                      width: 100,
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
                const SizedBox(
                  width: 13,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        productModel.name,
                        style: Styles.textStyle20,
                      ),
                      Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      //  "lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, accusantium.",
                        productModel.desc,
                        style: Styles.textStyle14,
                      ),
                      Text(
                        '${productModel.price} EGP',
                        style: Styles.textStyle20,
                      ),
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
