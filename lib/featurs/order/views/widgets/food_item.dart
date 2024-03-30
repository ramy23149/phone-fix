import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/app_router.dart';
import 'package:food_delivery_app/Core/helper/show_aweSome_dialog.dart';
import 'package:food_delivery_app/Core/servers/data_base_methouds.dart';
import 'package:go_router/go_router.dart';
import '../../../../Core/text_styles/Styles.dart';
import '../../../../Core/widgets/custom_loadingIndecator.dart';

class FoodItem extends StatelessWidget {
  const FoodItem(
      {super.key,
      required this.count,
      required this.image,
      required this.name,
      required this.price,
      required this.id});
  final int count;
  final String image;
  final String name;
  final int price;
  final String id;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRouter.kfoodDetalis, extra: {
          'image': image,
          'detalis': 'you have ordered $count of $name',
          'price': price.toString(),
          'name': name
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 120,
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
                      '$count',
                      style: const TextStyle(
                          color: Color(0xff9C959C),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      height: 100,
                      progressIndicatorBuilder: (context, url, progress) {
                        return const CustomLoadingIndecator();
                      },
                      imageUrl: image,
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
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        name,
                        style: Styles.textStyle20Extra,
                      ),
                      Text(
                        '\$$price',
                        style: Styles.textStyle20Extra,
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {
                      showAwesomeDialog(context, () {
                        DataBaseMethouds().deleteItemFromCurt(id);
                      });
                    },
                    icon: const Icon(Icons.delete))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
