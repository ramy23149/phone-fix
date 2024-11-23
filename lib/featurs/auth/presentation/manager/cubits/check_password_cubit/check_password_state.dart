part of 'check_password_cubit.dart';

@immutable
sealed class CheckPasswordState {}

final class CheckPasswordInitial extends CheckPasswordState {}

final class CheckPasswordLoading extends CheckPasswordState {}

final class TruePassword extends CheckPasswordState {
//   final UserRoleEnum userRoleEnum;

//   TruePassword({required this.userRoleEnum});
}

final class WrongPassword extends CheckPasswordState {
  final String message;

  WrongPassword({required this.message});
}

final class CheckPasswordError extends CheckPasswordState {
  final String error;

  CheckPasswordError({required this.error});
}
