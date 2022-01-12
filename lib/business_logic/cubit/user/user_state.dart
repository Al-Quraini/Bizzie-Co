part of 'user_cubit.dart';

@immutable
abstract class UserState {
  const UserState();

  // @override
  // List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UpdateUser extends UserState {
  final User user;
  final UserCard card;

  const UpdateUser({required this.user, required this.card});

  // @override
  // List<Object?> get props => [user, card];
}
