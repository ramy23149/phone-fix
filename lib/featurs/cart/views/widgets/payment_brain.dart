import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../Core/helper/Costom_alert_dialog.dart';
import '../../helper/loading_dialog.dart';
import '../../manager/card_payment_cubit/card_payment_cubit.dart';
import '../../manager/card_payment_cubit/card_payment_state.dart';
import '../../manager/confirm_order_cubit/confirm_order_cubit.dart';

class PaymetBrain extends StatelessWidget {
  const PaymetBrain({super.key, required this.child});
final Widget child;
  @override
  Widget build(BuildContext context) {
    return BlocListener<CardPaymentCubit, CardPaymentState>(
      listener: (context, state) {
        if (state is CardPaymentSuccess) {
          log("Payment was successful, proceeding to confirm order.");
          context.read<ConfirmOrderCubit>().confirmOrder(context);
        } else if (state is CardPaymentFailure) {
          log("Payment failed: ${state.errMasessge}");
          showAlertDialog(
            context,
            state.errMasessge,
            const Icon(Icons.error),
            Colors.red,
            () {
              context.pop();
              context.pop();
            },
          );
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
        child: child,
      ),
    );
      }
  }
