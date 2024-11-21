import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/Core/helper/Costom_alert_dialog.dart';
import 'package:food_delivery_app/Core/widgets/custom_appbar.dart';
import 'package:food_delivery_app/featurs/cart/manager/confirm_order_cubit/paymony_cubit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'check_out_box.dart';
import 'order_list_view.dart';

class OrderViewBody extends StatefulWidget {
  const OrderViewBody({super.key});

  @override
  State<OrderViewBody> createState() => _OrderViewBodyState();
}

class _OrderViewBodyState extends State<OrderViewBody> {
  int total = 0;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymonyCubit, PaymonyState>(
      listener: (context, state) {
        if (state is PaymonySuccess) {
          showAlertDialog(context, "You Are Payed $total USD",
              const Icon(Icons.done_outline_rounded), Colors.green);
        } else if (state is PaymonyError) {
          showAlertDialog(context, "you don't have enough money",
              const Icon(Icons.error), Colors.red);
        } else if (state is PayZeroError) {
            showAlertDialog(context, "Failed operation",
              const Icon(Icons.error), Colors.red);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is PaymonyLoading,
          child: Stack(children: [
            Column(
              children: [
                const CustomAppBar(
                  title: 'عربة التسوق',
                ),
                const Spacer(),
                ChekOutBox(
                  onTap: () {
                    BlocProvider.of<PaymonyCubit>(context).paymony(total);
                  },
                ),
              ],
            ),
            const Positioned(
                top: 65,
                bottom: 110,
                right: 0,
                left: 0,
                child: OrderListView(
                )),
          ]),
        );
      },
    );
  }
}
