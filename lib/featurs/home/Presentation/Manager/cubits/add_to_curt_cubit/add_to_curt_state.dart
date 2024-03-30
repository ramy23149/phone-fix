part of 'add_to_curt_cubit.dart';

@immutable
sealed class AddToCurtState {}

final class AddToCurtInitial extends AddToCurtState {}

final class AddToCurtSuccess extends AddToCurtState{}

final class AddToCartLoading extends AddToCurtState{}
