import 'dart:developer';

import 'package:bizzie_co/data/models/activity.dart';
import 'package:bizzie_co/data/repository/firestore_repository.dart';
import 'package:bizzie_co/data/service/storage_service.dart';
import 'package:meta/meta.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import 'package:equatable/equatable.dart';

part 'my_activity_event.dart';
part 'my_activity_state.dart';

class MyActivityBloc extends Bloc<MyActivityEvent, MyActivityState> {
  final FirestoreRepository _firestoreRepository;
  StreamSubscription? _activitySubscription;

  static final MyActivityBloc _instance =
      MyActivityBloc._(firestoreRepository: FirestoreRepository());

  factory MyActivityBloc() {
    return _instance;
  }

  MyActivityBloc._({required FirestoreRepository firestoreRepository})
      : _firestoreRepository = firestoreRepository,
        super(MyActivityInitial());

  // ActivityBloc._({required FirestoreRepository firestoreRepository}) {
  //   // initialization logic
  // }
  @override
  Stream<MyActivityState> mapEventToState(MyActivityEvent event) async* {
    if (event is LoadMyActivity) {
      yield* _mapLoadActivitiesToState();
    } else if (event is UpdateMyActivity) {
      yield* _mapUpdateActivitesToState(event);
    } else if (event is CancelMyActivity) {
      yield* _mapCancelActivitiesToState();
    }
  }

  Stream<MyActivityState> _mapLoadActivitiesToState() async* {
    _activitySubscription?.cancel();
    // String path = '$USERS/${FirestoreService.currentUser!.uid}/$ACTIVITIES';
    _activitySubscription =
        _firestoreRepository.getMyActivities().listen((activities) async {
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
      add(UpdateMyActivity(myActivities));
    });
  }

  Stream<MyActivityState> _mapUpdateActivitesToState(
      UpdateMyActivity event) async* {
    yield MyActivityLoaded(activities: event.activities);
  }

  Stream<MyActivityState> _mapCancelActivitiesToState() async* {
    yield MyActivityInitial();
  }

  @override
  Future<void> close() {
    _activitySubscription?.cancel();
    return super.close();
  }
}
