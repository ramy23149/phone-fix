part of 'add_items_cubit.dart';

@immutable
sealed class AddItemsState {}

final class AddItemsInitial extends AddItemsState {}

final class AddItemsLoading extends AddItemsState {}

final class AddItemsSuccess extends AddItemsState {}

final class AddItemsError extends AddItemsState {}
