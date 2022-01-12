part of 'leaderboard_bloc.dart';

@immutable
abstract class LeaderboardEvent extends Equatable {
  const LeaderboardEvent();

  @override
  List<Object> get props => [];
}

class CancelLeaderboard extends LeaderboardEvent {}

class LoadLeaderboard extends LeaderboardEvent {}

class UpdateLeaderboard extends LeaderboardEvent {
  final List<User> users;
  final List<Industry> industries;

  const UpdateLeaderboard(this.users, this.industries);

  @override
  List<Object> get props => [users, industries];
}
