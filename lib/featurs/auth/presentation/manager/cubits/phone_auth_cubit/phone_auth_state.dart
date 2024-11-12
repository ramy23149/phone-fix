part of 'phone_auth_cubit.dart';

@immutable
abstract class PhoneAuthState {}

class PhoneAuthInitial extends PhoneAuthState {}

class PhoneAuthLoading extends PhoneAuthState {}

class PhoneAuthSuccess extends PhoneAuthState {}

class PhoneAuthError extends PhoneAuthState {
  final String error;

  PhoneAuthError({required this.error});
}
class InvalidPhoneNumber extends PhoneAuthState {
  final String error;
  InvalidPhoneNumber({required this.error});
}

class CodeAutoRetrievalTimeout extends PhoneAuthState {
  final String error;
  CodeAutoRetrievalTimeout({required this.error});
}

class PhoneAuthCodeSent extends PhoneAuthState {
  final String verificationId;
  final int? resendToken;

  PhoneAuthCodeSent({required this.verificationId, this.resendToken});
}

class InvalidOtpError extends PhoneAuthState {
  final String error;
  InvalidOtpError({required this.error});
}

class GoToResetPasswordView extends PhoneAuthState {
final  UpdatePassowrdModel updatePassowrdModel;

  GoToResetPasswordView({required this.updatePassowrdModel});
}
