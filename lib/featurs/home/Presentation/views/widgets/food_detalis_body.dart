import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/constats.dart';
import 'package:food_delivery_app/Core/text_styles/Styles.dart';
import 'package:food_delivery_app/Core/widgets/custom_bottom.dart';

import '../../../../../Core/widgets/custom_loadingIndecator.dart';
import 'custom_counter.dart';

class FoodDetalisBody extends StatefulWidget {
  const FoodDetalisBody(
      {super.key,
      required this.imageUrl,
      required this.desc,
      required this.price,
      required this.name});
  final String imageUrl;
  final String desc;
  final String price;
  final String name;

  @override
  State<FoodDetalisBody> createState() => _FoodDetalisBodyState();
}

class _FoodDetalisBodyState extends State<FoodDetalisBody> {
  late int curantprice;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    curantprice =int.parse(widget.price);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                height: MediaQuery.of(context).size.height * .45,
                width: MediaQuery.of(context).size.width,
                progressIndicatorBuilder: (context, url, progress) {
                  return const CustomLoadingIndecator();
                },
                imageUrl: widget.imageUrl,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Text(
                widget.name,
                style: Styles.textStyle20,
                overflow: TextOverflow.ellipsis,
              )),
              CustomCounter(
                onCounterValueChanged: (value) {
                  setState(() {
                    curantprice = int.parse(widget.price) * value;
                  });
                },
              )
            ],
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            widget.desc,
            style: Styles.textStyle14,
            maxLines: 5,
            overflow: TextOverflow.fade,
          ),
          const SizedBox(
            height: 27,
          ),
          const Row(
            children: [
              Text(
                'Delivery Time:',
                style: Styles.textStyle20,
              ),
              SizedBox(
                width: 40,
              ),
              Icon(
                Icons.alarm_outlined,
                color: Color(0xffB2ACB2),
              ),
              Text(
                ' 30 min',
                style: Styles.textStyle20,
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text(
                    'Total Price',
                    style: Styles.textStyle18,
                  ),
                  Text(
                    '\$$curantprice',
                    style: Styles.textStyle20,
                  )
                ],
              ),
              CustomBotton(
                  borderRadius: BorderRadius.circular(16),
                  textColor: kWhite,
                  backgroundColor: kBlack,
                  text: 'Add to cart  🛒')
            ],
          ),
          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
