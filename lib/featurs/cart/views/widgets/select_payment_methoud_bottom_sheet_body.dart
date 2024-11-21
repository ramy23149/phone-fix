
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/featurs/cart/manager/card_payment_cubit/card_payment_cubit.dart';
import 'package:food_delivery_app/featurs/cart/manager/providers/user_cart_provider.dart';
import '../../../../Core/constats.dart';
import '../../../../Core/servers/get_locator.dart';
import '../../../../Core/text_styles/Styles.dart';
import '../../data/enums/payment_methoud_enum.dart';
import '../../manager/confirm_order_cubit/confirm_order_cubit.dart';
import 'payment_brain.dart';

class SelectPaymetMethoudBottomSheetBody extends StatefulWidget {
  const SelectPaymetMethoudBottomSheetBody({
    super.key,
  });

  @override
  State<SelectPaymetMethoudBottomSheetBody> createState() =>
      _SelectPaymetMethoudBottomSheetBodyState();
}

class _SelectPaymetMethoudBottomSheetBodyState
    extends State<SelectPaymetMethoudBottomSheetBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<UserCartProvider>().calculateCartTotalPrice(context);
  }

  @override
  Widget build(BuildContext context) {
  return PaymetBrain(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'اختر طريقة الدفع',
            style: Styles.textStyle18.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.credit_card, color: kMainAppColor),
            title: const Text('الدفع عن طريق البطاقة'),
            onTap: () {
              locator<CardPaymentCubit>().makeCardPayment(context);
            //  Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.money, color: kMainAppColor),
            title: const Text('الدفع عند الاستلام'),
            onTap: () {
              context.read<UserCartProvider>().paymentMethoudEnum =
                  PaymentMethoudEnum.cash;
              context.read<ConfirmOrderCubit>().confirmOrder(context);
            },
          ),
        ],
      ),
    ),
  );
  }
}

