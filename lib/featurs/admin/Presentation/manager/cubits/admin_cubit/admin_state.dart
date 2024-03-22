part of 'admin_cubit.dart';

@immutable
sealed class AdminState {}

final class AdminInitial extends AdminState {}

final class AdminLoading extends AdminState {}

final class AdminLoginSuccess extends AdminState {}

final class AdminWrongId extends AdminState {}

final class AdminWrongPassword extends AdminState {}
