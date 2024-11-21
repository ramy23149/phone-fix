 class CardPaymentState {}

final class CardPaymentInitial extends CardPaymentState {}
final class CardPaymentSuccess extends CardPaymentState {}
final class CardPaymentFailure extends CardPaymentState {
  final String errMasessge;
  CardPaymentFailure(this.errMasessge);
}
final class CardPaymentLoading extends CardPaymentState {}