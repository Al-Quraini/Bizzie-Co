part of 'request_bloc.dart';

@immutable
abstract class RequestEvent extends Equatable {
  const RequestEvent();

  @override
  List<Object> get props => [];
}

class LoadRequest extends RequestEvent {}

class UpdateRequest extends RequestEvent {
  final List<Request> requests;
  final List<User> users;

  const UpdateRequest(this.requests, this.users);

  @override
  List<Object> get props => [requests, users];
}

class CancelRequest extends RequestEvent {}
