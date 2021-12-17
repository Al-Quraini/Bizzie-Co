import 'dart:async';

import 'package:bizzie_co/data/models/request.dart';
import 'package:bizzie_co/data/models/user.dart';
import 'package:bizzie_co/data/repository/firestore_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'request_event.dart';
part 'request_state.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  final FirestoreRepository _firestoreRepository;
  StreamSubscription? _requestSubscription;

  static final RequestBloc _instance =
      RequestBloc._(firestoreRepository: FirestoreRepository());

  factory RequestBloc() {
    return _instance;
  }

  RequestBloc._({required FirestoreRepository firestoreRepository})
      : _firestoreRepository = firestoreRepository,
        super(InitialRequestState());

  @override
  Stream<RequestState> mapEventToState(RequestEvent event) async* {
    if (event is LoadRequest) {
      yield* _mapLoadRequestsToState();
    } else if (event is UpdateRequest) {
      yield* _mapUpdateRequestsToState(event);
    }
    if (event is CancelRequest) {
      yield* _mapCancelRequestsToState();
    }
  }

  Stream<RequestState> _mapLoadRequestsToState() async* {
    _requestSubscription?.cancel();
    _firestoreRepository.getAllRequests().listen((requests) async {
      List<User> users = [];
      for (Request request in requests) {
        final user = await _firestoreRepository.loadUserData(
            userUid: request.requestFrom);
        if (user != null) {
          users.add(user);
        }
      }
      add(UpdateRequest(requests, users));
    });
  }

  Stream<RequestState> _mapUpdateRequestsToState(UpdateRequest event) async* {
    yield RequestLoaded(requests: event.requests, users: event.users);
  }

  Stream<RequestState> _mapCancelRequestsToState() async* {
    yield InitialRequestState();
  }
}
