import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/Core/constats.dart';
import 'package:food_delivery_app/Core/helper/custom_snakBar.dart';
import 'package:food_delivery_app/Core/text_styles/Styles.dart';
import 'package:food_delivery_app/Core/widgets/custom_bottom.dart';
import 'package:food_delivery_app/featurs/home/Presentation/Manager/cubits/add_to_curt_cubit/add_to_curt_cubit.dart';
import 'package:food_delivery_app/featurs/home/Presentation/views/widgets/custom_image.dart';
import 'package:food_delivery_app/featurs/home/data/models/product_model.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'custom_counter.dart';

class ProductDetalisBody extends StatefulWidget {
  const ProductDetalisBody({
    super.key,
    required this.productModel,
  });
  final ProductModel productModel;

  @override
  State<ProductDetalisBody> createState() => _ProductDetalisBodyState();
}

class _ProductDetalisBodyState extends State<ProductDetalisBody> {
  late int curantprice;

  int count = 1;

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    curantprice = int.parse(widget.productModel.price);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddToCurtCubit, AddToCurtState>(
      builder: (context, state) {
        if (state is AddToCurtSuccess) {
          Future.microtask(() {
            showSnackBar(context, 'Added to cart successfully');
          });
        }
        return ModalProgressHUD(
          inAsyncCall: state is AddToCartLoading,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImage(image: widget.productModel.imageUrl),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(
                      widget.productModel.name,
                      style: Styles.textStyle20,
                      overflow: TextOverflow.ellipsis,
                    )),
                    CustomCounter(
                      onCounterValueChanged: (value) {
                        setState(() {
                          curantprice =
                              int.parse(widget.productModel.price) * value;
                          count = value;
                        });
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  widget.productModel.desc,
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
                              productModel: widget.productModel,
                              count: count,
                              totalPrice: curantprice,
                              context: context);
                        },
                        borderRadius: BorderRadius.circular(16),
                        textColor: kWhite,
                        backgroundColor: kMainAppColor,
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
      },
    );
  }
}
