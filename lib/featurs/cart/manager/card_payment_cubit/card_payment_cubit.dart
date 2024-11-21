import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/featurs/cart/data/repos/payment_repos/payment_repo.dart';
import 'package:food_delivery_app/featurs/cart/manager/card_payment_cubit/card_payment_state.dart';
import 'package:food_delivery_app/featurs/cart/manager/providers/user_cart_provider.dart';
import '../../data/enums/payment_methoud_enum.dart';
import '../confirm_order_cubit/confirm_order_cubit.dart';

class CardPaymentCubit extends Cubit<CardPaymentState> {
  CardPaymentCubit(this.walletRepo) : super(CardPaymentInitial());
  final WalletRepo walletRepo;

  Future<void> makeCardPayment(BuildContext context) async {
    emit(CardPaymentLoading());
    final amount = context.read<UserCartProvider>().totalCartPrice;

    if (amount != 0) {
      var result = await walletRepo.makePayment(amount.toInt(), 'EGP');

      result.fold(
        (failure) {
          emit(CardPaymentFailure(failure.errMasessge));
        },
        (success) async {
            context.read<UserCartProvider>().paymentMethoudEnum =
                PaymentMethoudEnum.card;
            context.read<ConfirmOrderCubit>().confirmOrder(context);
            emit(CardPaymentSuccess());
      
        },
      );
    } else {
      emit(CardPaymentFailure("حدث خطأ ما، يرجى المحاولة مرة أخرى"));
    }
  }
}
