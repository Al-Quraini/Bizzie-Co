part of 'connections_bloc.dart';

@immutable
abstract class ConnectionsEvent extends Equatable {
  const ConnectionsEvent();

  @override
  List<Object> get props => [];
}

class ResetConnections extends ConnectionsEvent {}

class LoadConnections extends ConnectionsEvent {}

class UpdateConnections extends ConnectionsEvent {
  final List<Connection> connections;
  final List<User> users;

  const UpdateConnections(this.connections, this.users);

  @override
  List<Object> get props => [connections, users];
}
