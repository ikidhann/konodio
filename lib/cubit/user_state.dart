part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> users;

  const UserLoaded(this.users);
}

class UserError extends UserState {
  final String error;

  const UserError(this.error);
}