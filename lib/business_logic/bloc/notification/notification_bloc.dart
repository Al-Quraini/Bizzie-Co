import 'dart:developer';

import 'package:bizzie_co/data/models/notification_model.dart';
import 'package:bizzie_co/data/models/user.dart';
import 'package:bizzie_co/data/service/storage_service.dart';
import 'package:meta/meta.dart';

import 'dart:async';

import 'package:bizzie_co/data/repository/firestore_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import 'package:equatable/equatable.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final FirestoreRepository _firestoreRepository;
  StreamSubscription? _notificationsSubscription;

  static final NotificationBloc _instance =
      NotificationBloc._(firestoreRepository: FirestoreRepository());

  factory NotificationBloc() {
    return _instance;
  }

  NotificationBloc._({required FirestoreRepository firestoreRepository})
      : _firestoreRepository = firestoreRepository,
        super(NotificationInitial());

  // ActivityBloc._({required FirestoreRepository firestoreRepository}) {
  //   // initialization logic
  // }
  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is LoadNotification) {
      yield* _mapLoadNotificationsToState();
    } else if (event is UpdateNotification) {
      yield* _mapUpdateNotificationsToState(event);
    }
    if (event is InitializeNotification) {
      yield* _mapInitializeNotificationToState();
    }
  }

  Stream<NotificationState> _mapLoadNotificationsToState() async* {
    // _notificationsSubscription?.cancel();
    _notificationsSubscription = _firestoreRepository
        .getAllNotifications()
        .listen((notifications) async {
      List<NotificationModel> myNotifications = [];
      for (NotificationModel notification in notifications) {
        final userImageUrl =
            await StorageService().getImageUrl(notification.userImagePath);

        notification.setUrl = userImageUrl;

        myNotifications.add(notification);
      }
      add(UpdateNotification(myNotifications));
    });
  }

  Stream<NotificationState> _mapUpdateNotificationsToState(
      UpdateNotification event) async* {
    yield NotificationLoaded(
      notifications: event.notifications,
    );
  }

  Stream<NotificationState> _mapInitializeNotificationToState() async* {
    _notificationsSubscription?.cancel();

    yield NotificationInitial();
  }

  @override
  Future<void> close() {
    _notificationsSubscription?.cancel();
    return super.close();
  }
}
