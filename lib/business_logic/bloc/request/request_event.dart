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

  const UpdateRequest(this.requests);

  @override
  List<Object> get props => [requests];
}

class CancelRequest extends RequestEvent {}
