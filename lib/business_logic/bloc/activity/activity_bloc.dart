import 'dart:developer';

import 'package:bizzie_co/data/models/activity.dart';
import 'package:bizzie_co/data/repository/firestore_repository.dart';
import 'package:bizzie_co/data/service/firestore_service.dart';
import 'package:bizzie_co/data/service/storage_service.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:meta/meta.dart';
import 'dart:async';
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
    } else if (event is CancelActivity) {
      yield* _mapCancelActivitiesToState();
    }
  }

  Stream<ActivityState> _mapLoadActivitiesToState() async* {
    // _activitySubscription?.cancel();
    // String path = '$USERS/${FirestoreService.currentUser!.uid}/$ACTIVITIES';
    _activitySubscription =
        _firestoreRepository.combinedActivities().listen((activities) async {
      List<Activity> myActivities = [];
      for (Activity activity in activities) {
        final userImageUrl =
            await StorageService().getImageUrl(activity.userImagePath);
        final activityImageUrl =
            await StorageService().getImageUrl(activity.url);

        activity.setUserUrl = userImageUrl;
        activity.setPhotoUrl = activityImageUrl;

        myActivities.add(activity);
      }

      add(UpdateActivity(myActivities));
    });
  }

  Stream<ActivityState> _mapUpdateActivitesToState(
      UpdateActivity event) async* {
    yield ActivityLoaded(activities: event.activities);
  }

  Stream<ActivityState> _mapCancelActivitiesToState() async* {
    yield ActivityInitial();
  }

  @override
  Future<void> close() {
    _activitySubscription?.cancel();
    return super.close();
  }
}
