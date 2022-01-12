import 'dart:async';

import 'package:bizzie_co/data/models/event.dart';
import 'package:bizzie_co/data/repository/firestore_repository.dart';
import 'package:bizzie_co/data/service/firestore_service.dart';
import 'package:bizzie_co/data/service/storage_service.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventBloc extends Bloc<EventsEvent, EventsState> {
  final FirestoreRepository _firestoreRepository;
  StreamSubscription? _eventubscription;
  int _limit;

  static final EventBloc _instance =
      EventBloc._(firestoreRepository: FirestoreRepository(), limit: 15);

  factory EventBloc() {
    return _instance;
  }

  EventBloc._(
      {required FirestoreRepository firestoreRepository, required int limit})
      : _firestoreRepository = firestoreRepository,
        _limit = limit,
        super(InitialEventsState());

  @override
  Stream<EventsState> mapEventToState(EventsEvent event) async* {
    if (event is LoadEvents) {
      yield* _mapLoadEventtsToState();
    } else if (event is UpdateEvents) {
      yield* _mapUpdateEventsToState(event);
    } else {
      yield* _mapResetEventtsToState();
    }
  }

  Stream<EventsState> _mapLoadEventtsToState() async* {
    _eventubscription?.cancel();

    _eventubscription =
        _firestoreRepository.getEvents(limit: _limit).listen((events) async {
      List<Event> myEvents = [];
      for (Event event in events) {
        final userImageUrl =
            await StorageService().getImageUrl(event.userImagePath);

        final eventImageUrl =
            await StorageService().getImageUrl(event.imagePath);

        event.setUserUrl = userImageUrl;
        event.setEventUrl = eventImageUrl;

        myEvents.add(event);
      }
      add(UpdateEvents(myEvents));
    });
  }

  Stream<EventsState> _mapUpdateEventsToState(UpdateEvents event) async* {
    yield EventsLoaded(events: event.events);
  }

  Stream<EventsState> _mapResetEventtsToState() async* {
    yield InitialEventsState();
  }

  @override
  Future<void> close() {
    _eventubscription?.cancel();
    return super.close();
  }
}
