import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/Core/constats.dart';
import 'package:food_delivery_app/Core/helper/custom_snakBar.dart';
import 'package:food_delivery_app/Core/text_styles/Styles.dart';
import 'package:food_delivery_app/Core/widgets/custom_bottom.dart';
import 'package:food_delivery_app/featurs/home/Presentation/Manager/cubits/add_to_curt_cubit/add_to_curt_cubit.dart';
import 'package:food_delivery_app/featurs/home/Presentation/views/widgets/custom_image.dart';

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

  int foodCount = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    curantprice = int.parse(widget.price);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddToCurtCubit, AddToCurtState>(
      listener: (context, state) {
        if (state is AddToCurtSuccess) {
          showSnackBar(context, 'Added To Curt Successfuly');
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImage(image: widget.imageUrl),
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
                      foodCount = value;
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
                    onPressed: () {
                      BlocProvider.of<AddToCurtCubit>(context).addToCurt(
                          widget.name, foodCount, curantprice, widget.imageUrl);
                    },
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
      ),
    );
  }
}
