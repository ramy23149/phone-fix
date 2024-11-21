part of 'confirm_order_cubit.dart';

@immutable
sealed class ConfirmOrderState {}

final class ConfirmOrderInitial extends ConfirmOrderState {}

final class ConfirmOrderLoading extends ConfirmOrderState {}

final class ConfirmOrderSuccess extends ConfirmOrderState {}

final class ConfirmOrderError extends ConfirmOrderState {
  final  String errMessage;

  ConfirmOrderError(this.errMessage);
}
