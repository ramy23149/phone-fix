import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/widgets/custom_loadingIndecator.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          height: MediaQuery.of(context).size.height * .45,
          width: MediaQuery.of(context).size.width,
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
    );
  }
}
