part of 'get_curt_cubit.dart';

@immutable
sealed class GetCurtState {}

final class GetCurtInitial extends GetCurtState {}

final class GetCurtLoaded extends GetCurtState {}

final class GetCurtError extends GetCurtState {}

final class GetCurtSuccess extends GetCurtState {}
