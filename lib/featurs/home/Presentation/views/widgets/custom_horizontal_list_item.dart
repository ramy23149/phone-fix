import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/app_router.dart';
import 'package:food_delivery_app/Core/text_styles/Styles.dart';
import 'package:food_delivery_app/Core/widgets/custom_loadingIndecator.dart';
import 'package:go_router/go_router.dart';

class CustomUperListViewItem extends StatelessWidget {
  const CustomUperListViewItem({super.key, required this.imageUrl, required this.foodName, required this.price, required this.desc});
  final String imageUrl;
  final String foodName;
  final String price;
  final String desc;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRouter.kfoodDetalis),
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
                        child: CachedNetworkImage(
                          height: 150,
                          width: 150,
                          progressIndicatorBuilder: (context, url, progress) {
                            return const CustomLoadingIndecator();
                          },
                          imageUrl: imageUrl,
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
                   Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    foodName,
                    style: Styles.textStyle20,
                  ),
                   Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    desc,
                    style: Styles.textStyle14,
                  ),
                   Text(
                    '\$$price',
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
