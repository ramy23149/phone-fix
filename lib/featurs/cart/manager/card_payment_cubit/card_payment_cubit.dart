import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/featurs/cart/data/repos/payment_repos/payment_repo.dart';
import 'package:food_delivery_app/featurs/cart/manager/card_payment_cubit/card_payment_state.dart';
import 'package:food_delivery_app/featurs/cart/manager/providers/user_cart_provider.dart';
import '../../../../Core/helper/Costom_alert_dialog.dart';
import '../../data/enums/payment_methoud_enum.dart';

class CardPaymentCubit extends Cubit<CardPaymentState> {
  CardPaymentCubit(this.walletRepo) : super(CardPaymentInitial());
  final WalletRepo walletRepo;

  Future<void> makeCardPayment(BuildContext context) async {
    emit(CardPaymentLoading());
    final amount = context.read<UserCartProvider>().totalCartPrice;
    if (amount != 0) {
      var result = await walletRepo.makePayment(amount.toInt(), 'EGP');

      result.fold(
        (falier) => emit(CardPaymentFailure(falier.errMasessge)),
        (r) async {
          context.read<UserCartProvider>().paymentMethoudEnum =
              PaymentMethoudEnum.card; //required to confirm Order step
          emit(CardPaymentSuccess());
          if (context.mounted) {
            showAlertDialog(context, "Your payment was successful.",
                const Icon(Icons.done_outline_rounded), Colors.green);
          }
        },
      );
    }else{
      emit(CardPaymentFailure("حدث خطا ما رجاء المحاوله مره اخر"));
    }
  }
}
