import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/Core/helper/custom_payment_dialog.dart';
import 'package:food_delivery_app/Core/widgets/Custom_text_bottom.dart';
import 'package:food_delivery_app/Core/widgets/custom_bottom.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../Core/constats.dart';
import '../../../../../Core/text_styles/Styles.dart';
import '../../../../../Core/widgets/custom_appbar.dart';
import '../../../../cart/manager/add_mony_cubit/add_mony_cubit.dart';
import '../../../../cart/manager/add_mony_cubit/add_mony_state.dart';
import 'custom_wallet_contaner.dart';

class WalletViewBody extends StatefulWidget {
  const WalletViewBody({super.key});

  @override
  State<WalletViewBody> createState() => _WalletViewBodyState();
}

class _WalletViewBodyState extends State<WalletViewBody> {
  bool isLoading = false;
  TextEditingController paymentController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    paymentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddMonyCubit, AddMonyState>(
      listener: (context, state) {
        setState(() {
          isLoading = state is AddMonyLoading;
        });
      },
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Column(
          children: [
            const CustomAppBar(
              title: 'Wallet',
            ),
            const SizedBox(height: 20),
            FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc("+201212977066")
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('Error fetching data');
                } else {
                  // final userData =
                  //     snapshot.data!.data() as Map<String, dynamic>;
                //  final totalMoney = userData[''];
                  return CustomWalletContaner(totalMony:200);
                }
              },
            ),
            const SizedBox(height: 20),
            _buildAddMoneySection(),
          ],
        ),
      ),
    );
  }

  Widget _buildAddMoneySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Text(
            "Add money",
            style: Styles.textStyle20Extra,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildAddMoneyButton(
                  100,
                ),
                buildAddMoneyButton(
                  500,
                ),
                buildAddMoneyButton(
                  1000,
                ),
                buildAddMoneyButton(
                  2000,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 45),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: CustomBotton(
            borderRadius: BorderRadius.circular(5),
            width: MediaQuery.of(context).size.width,
            textColor: kWhite,
            backgroundColor: const Color(0xff017476),
            text: "Add Money",
            onPressed: () {
              showPaymentDialog(context, paymentController, () {
                if (key.currentState!.validate()) {
                  int amount = int.tryParse(paymentController.text) ?? 0;
                  showPaymentSheet(
                    amount,
                  );
                  paymentController.clear();
                  context.pop();
                }
              }, key);
              //showPaymentSheet(100,); // Default amount
            },
          ),
        ),
      ],
    );
  }

  Widget buildAddMoneyButton(int amount) {
    return CustomTextButtom(
      onPressed: () {
        showPaymentSheet(
          amount,
        );
      },
      text: "\$$amount",
    );
  }

  Future<void> showPaymentSheet(
    int money,
  ) async {
    await BlocProvider.of<AddMonyCubit>(context).addMony(
      money,
      context,
    );
  }
}
