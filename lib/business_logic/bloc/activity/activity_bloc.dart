import 'package:bizzie_co/data/models/activity.dart';
import 'package:meta/meta.dart';

import 'dart:async';

import 'package:bizzie_co/data/repository/firestore_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import 'package:equatable/equatable.dart';

part 'activity_event.dart';
part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final FirestoreRepository _firestoreRepository;
  StreamSubscription? _activitySubscription;

  static final ActivityBloc _instance =
      ActivityBloc._(firestoreRepository: FirestoreRepository());

  factory ActivityBloc() {
    return _instance;
  }

  ActivityBloc._({required FirestoreRepository firestoreRepository})
      : _firestoreRepository = firestoreRepository,
        super(ActivityInitial());

  // ActivityBloc._({required FirestoreRepository firestoreRepository}) {
  //   // initialization logic
  // }
  @override
  Stream<ActivityState> mapEventToState(ActivityEvent event) async* {
    if (event is LoadActivity) {
      yield* _mapLoadActivitiesToState();
    } else if (event is UpdateActivity) {
      yield* _mapUpdateActivitesToState(event);
    }
    if (event is CancelActivity) {
      yield* _mapCancelActivitiesToState();
    }
  }

  Stream<ActivityState> _mapLoadActivitiesToState() async* {
    _activitySubscription?.cancel();
    _firestoreRepository.getAllActivities().listen((activities) async {
      add(UpdateActivity(activities));
    });
  }

  Stream<ActivityState> _mapUpdateActivitesToState(
      UpdateActivity event) async* {
    yield ActivityLoaded(activities: event.activities);
  }

  Stream<ActivityState> _mapCancelActivitiesToState() async* {
    yield ActivityInitial();
  }
}
