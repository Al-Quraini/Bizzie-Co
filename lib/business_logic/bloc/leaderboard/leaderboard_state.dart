part of 'leaderboard_bloc.dart';

@immutable
abstract class LeaderboardState extends Equatable {
  const LeaderboardState();
  @override
  List<Object?> get props => [];
}

class LeaderboardInitial extends LeaderboardState {}

class LeaderboardLoading extends LeaderboardState {}

class LeaderboardLoaded extends LeaderboardState {
  final List<User> users;
  final List<Industry> industries;

  const LeaderboardLoaded(
      {this.users = const <User>[], this.industries = const <Industry>[]});

  @override
  List<Object?> get props => [users, industries];
}
