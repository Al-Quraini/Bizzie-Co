import 'dart:async';
import 'dart:developer';

import 'package:bizzie_co/business_logic/bloc/activity/activity_bloc.dart';
import 'package:bizzie_co/business_logic/bloc/notification/notification_bloc.dart';
import 'package:bizzie_co/data/models/connection.dart';
import 'package:bizzie_co/data/models/user.dart';
import 'package:bizzie_co/data/repository/firestore_repository.dart';
import 'package:bizzie_co/data/service/firestore_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'connections_event.dart';
part 'connections_state.dart';

class ConnectionsBloc extends Bloc<ConnectionsEvent, ConnectionsState> {
  final FirestoreRepository _firestoreRepository;
  StreamSubscription? _connectionSubscription;
  ActivityBloc _activityBloc;
  NotificationBloc _notificationBloc;

  static final ConnectionsBloc _instance =
      ConnectionsBloc._(firestoreRepository: FirestoreRepository());

  factory ConnectionsBloc() {
    return _instance;
  }

  ConnectionsBloc._({required FirestoreRepository firestoreRepository})
      : _firestoreRepository = firestoreRepository,
        _activityBloc = ActivityBloc(),
        _notificationBloc = NotificationBloc(),
        super(InitialConnectionState());

  @override
  Stream<ConnectionsState> mapEventToState(ConnectionsEvent event) async* {
    if (event is LoadConnections) {
      yield* _mapLoadConnectionstsToState();
    } else if (event is UpdateConnections) {
      yield* _mapUpdateConnectionstsToState(event);
    } else {
      yield* _mapResetConnectionstsToState();
    }
  }

  Stream<ConnectionsState> _mapLoadConnectionstsToState() async* {
    _connectionSubscription?.cancel();
    _firestoreRepository.getAllConnections().listen((connections) async {
      List<User> users = [];
      for (Connection connection in connections) {
        final user = await _firestoreRepository.loadUserData(
            userUid: connection.userUid);
        if (user != null) {
          users.add(user);
        }
      }
      FirestoreService().updateConnections(users);
      _activityBloc.add(LoadActivity());
      add(UpdateConnections(connections, users));
    });
  }

  Stream<ConnectionsState> _mapUpdateConnectionstsToState(
      UpdateConnections event) async* {
    yield ConnectionLoaded(connections: event.connections, users: event.users);
  }

  Stream<ConnectionsState> _mapResetConnectionstsToState() async* {
    yield InitialConnectionState();
  }
}
