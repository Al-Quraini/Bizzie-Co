part of 'request_bloc.dart';

@immutable
abstract class RequestState extends Equatable {
  const RequestState();

  @override
  List<Object?> get props => [];
}

class InitialRequestState extends RequestState {}

class RequestLoading extends RequestState {}

class RequestLoaded extends RequestState {
  final List<Request> requests;
  final List<User> users;

  const RequestLoaded(
      {this.users = const <User>[], this.requests = const <Request>[]});

  @override
  List<Object?> get props => [requests, users];
}
