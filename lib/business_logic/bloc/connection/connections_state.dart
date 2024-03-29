part of 'connections_bloc.dart';

@immutable
abstract class ConnectionsState extends Equatable {
  const ConnectionsState();

  @override
  List<Object?> get props => [];
}

class InitialConnectionState extends ConnectionsState {}

class ConnectionLoading extends ConnectionsState {}

class ConnectionLoaded extends ConnectionsState {
  final List<Connection> connections;


  const ConnectionLoaded(
      {this.connections = const <Connection>[]});

  @override
  List<Object?> get props => [connections];
}
