import 'dart:async';

import 'package:bizzie_co/data/models/request.dart';
import 'package:bizzie_co/data/models/user.dart';
import 'package:bizzie_co/data/repository/firestore_repository.dart';
import 'package:bizzie_co/data/service/storage_service.dart';
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
    // _requestSubscription?.cancel();
    _requestSubscription =
        _firestoreRepository.getAllRequests().listen((requests) async {
      List<Request> myRequests = [];
      for (Request request in requests) {
        final userImageUrl =
            await StorageService().getImageUrl(request.userImagePath);

        request.setUrl = userImageUrl;

        myRequests.add(request);
      }
      add(UpdateRequest(myRequests));
    });
  }

  Stream<RequestState> _mapUpdateRequestsToState(UpdateRequest event) async* {
    yield RequestLoaded(
      requests: event.requests,
    );
  }

  Stream<RequestState> _mapCancelRequestsToState() async* {
    _requestSubscription?.cancel();
    yield InitialRequestState();
  }

  @override
  Future<void> close() {
    _requestSubscription?.cancel();
    return super.close();
  }
}
