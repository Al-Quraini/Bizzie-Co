import 'dart:async';

import 'package:bizzie_co/data/models/connection.dart';
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

part 'connections_event.dart';
part 'connections_state.dart';

class ConnectionsBloc extends Bloc<ConnectionsEvent, ConnectionsState> {
  final FirestoreRepository _firestoreRepository;
  StreamSubscription? _connectionSubscription;
  int _limit;

  static final ConnectionsBloc _instance =
      ConnectionsBloc._(firestoreRepository: FirestoreRepository(), limit: 15);

  factory ConnectionsBloc() {
    return _instance;
  }

  ConnectionsBloc._(
      {required FirestoreRepository firestoreRepository, required int limit})
      : _firestoreRepository = firestoreRepository,
        _limit = limit,
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

    String path = '$USERS/${FirestoreService.currentUser!.uid}/$CONNECTIONS';

    _connectionSubscription = _firestoreRepository
        .getConnections(path: path, limit: _limit)
        .listen((connections) async {
      List<Connection> myConnections = [];
      for (Connection connection in connections) {
        final userImageUrl =
            await StorageService().getImageUrl(connection.userImagePath);

        connection.setUrl = userImageUrl;

        myConnections.add(connection);
      }
      add(UpdateConnections(myConnections));
    });
  }

  Stream<ConnectionsState> _mapUpdateConnectionstsToState(
      UpdateConnections event) async* {
    yield ConnectionLoaded(connections: event.connections);
  }

  Stream<ConnectionsState> _mapResetConnectionstsToState() async* {
    yield InitialConnectionState();
  }

  @override
  Future<void> close() {
    _connectionSubscription?.cancel();
    return super.close();
  }
}
