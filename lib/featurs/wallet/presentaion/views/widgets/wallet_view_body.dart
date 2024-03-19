import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery_app/Core/constats.dart';
import 'package:food_delivery_app/Core/text_styles/Styles.dart';
import 'package:food_delivery_app/Core/widgets/custom_bottom.dart';
import '../../../../../Core/widgets/Custom_text_bottom.dart';
import '../../../../../Core/widgets/custom_appBar.dart';
import '../../manager/add_mony_cubit/add_mony_cubit.dart';
import '../../manager/add_mony_cubit/add_mony_state.dart';
import 'custom_wallet_contaner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletViewBody extends StatefulWidget {
  const WalletViewBody({super.key});

  @override
  State<WalletViewBody> createState() => _WalletViewBodyState();
}

class _WalletViewBodyState extends State<WalletViewBody> {
  int totalMony = 0;
  int amount = 0;
  String currency = 'USD';

  Future<void> showPaymentSheet(int mony) async {
    await BlocProvider.of<AddMonyCubit>(context).addMony(mony);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddMonyCubit, AddMonyState>(
      builder: (context, state) {
        return Column(
          children: [
            const CustomAppBar(),
            const SizedBox(
              height: 20,
            ),
            CustomWalletContaner(
              totalMony: totalMony,
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Add money",
                    style: Styles.textStyle20Extra,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 11.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextButtom(
                          onPressed: () {
                            showPaymentSheet(100);
                          },
                          text: "\$100",
                        ),
                        CustomTextButtom(
                          onPressed: () {
                          showPaymentSheet(500);
                          },
                          text: "\$500",
                        ),
                        CustomTextButtom(
                          onPressed: () {
                          showPaymentSheet(1000);
                          },
                          text: "\$1000",
                        ),
                        CustomTextButtom(
                          onPressed: () {
                          showPaymentSheet(2000);
                          },
                          text: "\$2000",
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: CustomBotton(
                    borderRadius: BorderRadius.circular(5),
                    width: MediaQuery.of(context).size.width,
                    textColor: kWhite,
                    backgroundColor: const Color(0xff017476),
                    text: "Add Money",
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
