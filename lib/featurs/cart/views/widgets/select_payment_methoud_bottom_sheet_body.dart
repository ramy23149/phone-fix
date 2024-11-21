import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/featurs/cart/manager/card_payment_cubit/card_payment_cubit.dart';
import 'package:food_delivery_app/featurs/cart/manager/card_payment_cubit/card_payment_state.dart';
import 'package:food_delivery_app/featurs/cart/manager/providers/user_cart_provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../Core/constats.dart';
import '../../../../Core/helper/Costom_alert_dialog.dart';
import '../../../../Core/servers/get_locator.dart';
import '../../../../Core/text_styles/Styles.dart';
import '../../data/enums/payment_methoud_enum.dart';
import '../../helper/loading_dialog.dart';
import '../../manager/confirm_order_cubit/confirm_order_cubit.dart';

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
    return BlocListener<CardPaymentCubit, CardPaymentState>(
      listener: (context, state) {
        if (state is CardPaymentSuccess) {
          context.read<ConfirmOrderCubit>().confirmOrder(context);
        } else if (state is CardPaymentFailure) {
          showAlertDialog(
              context, state.errMasessge, const Icon(Icons.error), Colors.red,
              () {
          //  context.read<CustomerDataProvider>().updateUserCart();//to update check box of the user
            context.pop(); // close dialog
            context.pop(); // close bottom sheet
          });
        }
      },
      child: BlocListener<ConfirmOrderCubit, ConfirmOrderState>(
        listener: (context, state) {
          if (state is ConfirmOrderSuccess) {
            context.pop(); //close the loading dialog
            showAlertDialog(context, "تم تاكيد الطلب بنجاح",
                const Icon(Icons.done), Colors.green, () {
              context.pop(); // close dialog
              context.pop(); // close bottom sheet
            });
          } else if (state is ConfirmOrderError) {
            context.pop(); //close the loading dialog
            showAlertDialog(
                context, state.errMessage, const Icon(Icons.error), Colors.red,
                () {
              context.pop(); // close dialog
              context.pop(); // close bottom sheet
            });
          } else if (state is ConfirmOrderLoading) {
            showLoadingDialog(context);
          }
        },
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
                  Navigator.pop(context);
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
      ),
    );
  }
}
