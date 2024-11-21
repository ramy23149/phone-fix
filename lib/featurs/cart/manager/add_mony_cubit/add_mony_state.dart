 class AddMonyState {}

final class AddMonyInitial extends AddMonyState {}
final class AddMonySuccess extends AddMonyState {}
final class AddMonyFailure extends AddMonyState {
  final String errMasessge;
  AddMonyFailure(this.errMasessge);
}
final class AddMonyLoading extends AddMonyState {}