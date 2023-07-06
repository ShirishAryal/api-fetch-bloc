part of 'user_bloc.dart';

@immutable
abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> userList;
  const UserLoaded(this.userList);
}

class UserError extends UserState {
  final String? error;
  const UserError(this.error);
}
