part of 'ceck_user_existeince_cubit.dart';

@immutable
sealed class CheckUserExisteniceState{}

final class CheckUserExisteniceInitial extends CheckUserExisteniceState{}

final class CheckUserExisteniceLoading extends CheckUserExisteniceState{}

final class ThisIsNewUser extends CheckUserExisteniceState{
  final String phone;

  ThisIsNewUser({required this.phone});
}

final class ThisUserAllreadyExist extends CheckUserExisteniceState{
final  DocumentSnapshot<Map<String, dynamic>> doc;

  ThisUserAllreadyExist({required this.doc});
  
}

final class CheckUserExisteniceError extends CheckUserExisteniceState{	
final String error;
CheckUserExisteniceError({required this.error});
}
