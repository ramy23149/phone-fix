import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/featurs/cart/manager/confirm_order_cubit/confirm_order_cubit.dart';
import 'package:food_delivery_app/featurs/cart/views/widgets/custom_price_text.dart';
import 'package:provider/provider.dart';

import '../../../../Core/constats.dart';
import '../../../../Core/servers/get_locator.dart';
import '../../../../Core/text_styles/Styles.dart';
import '../../../../Core/widgets/custom_bottom.dart';
import '../../manager/card_payment_cubit/card_payment_cubit.dart';
import '../../manager/providers/user_cart_provider.dart';
import 'select_payment_methoud_bottom_sheet_body.dart';

class ChekOutBox extends StatefulWidget {
  const ChekOutBox({super.key});

  @override
  _ChekOutBoxState createState() => _ChekOutBoxState();
}

class _ChekOutBoxState extends State<ChekOutBox> {
  @override
  Widget build(BuildContext context) {
    final totalPrice = context.watch<UserCartProvider>().totalCartPrice;

    return totalPrice == 0
        ? const SizedBox()
        : Container(
            color: Colors.transparent,
            child: Column(
              children: [
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'الاجمالي :',
                          style: Styles.textStyle20,
                        ),
                        CustomPriceText(price: totalPrice.toInt())
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: CustomBotton(
                    onPressed: _onContinueCheckoutPressed,
                    borderRadius: BorderRadius.circular(8),
                    width: MediaQuery.of(context).size.width,
                    textColor: kWhite,
                    backgroundColor: kMainAppColor,
                    text: 'تابع عمليه الشراء',
                  ),
                ),
                const SizedBox(
                  height: 6,
                )
              ],
            ),
          );
  }

  void _onContinueCheckoutPressed() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => locator<CardPaymentCubit>(),
            ),
            BlocProvider(
              create: (context) => ConfirmOrderCubit(),
            ),
          ],
          child: ChangeNotifierProvider<UserCartProvider>(
            create: (context) => UserCartProvider(),
            child: const SelectPaymetMethoudBottomSheetBody(),
          ),
        );
      },
    ).then((_) {
      context.read<UserCartProvider>().calculateCartTotalPrice(context);
      setState(() {});
    });
  }
}
