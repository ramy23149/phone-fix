part of 'paymony_cubit.dart';

@immutable
sealed class PaymonyState {}

final class PaymonyInitial extends PaymonyState {}

final class PaymonyLoading extends PaymonyState {}

final class PaymonySuccess extends PaymonyState {}

final class PaymonyError extends PaymonyState {}
final class PayZeroError extends PaymonyState{}
