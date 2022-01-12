import 'package:bizzie_co/data/models/industry.dart';
import 'package:bizzie_co/data/models/user.dart';
import 'package:bizzie_co/data/service/storage_service.dart';
import 'package:meta/meta.dart';

import 'dart:async';

import 'package:bizzie_co/data/repository/firestore_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import 'package:equatable/equatable.dart';

part 'leaderboard_event.dart';
part 'leaderboard_state.dart';

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  final FirestoreRepository _firestoreRepository;
  StreamSubscription? _usersSubscription;
  StreamSubscription? _indutriesSubscription;

  static final LeaderboardBloc _instance =
      LeaderboardBloc._(firestoreRepository: FirestoreRepository());

  factory LeaderboardBloc() {
    return _instance;
  }

  LeaderboardBloc._({required FirestoreRepository firestoreRepository})
      : _firestoreRepository = firestoreRepository,
        super(LeaderboardInitial());

  @override
  Stream<LeaderboardState> mapEventToState(LeaderboardEvent event) async* {
    if (event is LoadLeaderboard) {
      yield* _mapLoadLeaderboardToState();
    } else if (event is UpdateLeaderboard) {
      yield* _mapUpdateLeaderboardToState(event);
    }
    if (event is CancelLeaderboard) {
      yield* _mapCancelLeaderboardToState();
    }
  }

  Stream<LeaderboardState> _mapLoadLeaderboardToState() async* {
    _usersSubscription?.cancel();
    _usersSubscription = _firestoreRepository
        .getLeaderboardUsers()
        .listen((leaderboardUsersList) async {
      List<User> leaderUsers = [];
      for (User user in leaderboardUsersList) {
        final userImageUrl = await StorageService().getImageUrl(user.imagePath);

        user.setUrl = userImageUrl;
        leaderUsers.add(user);
      }

      final leaderboardIndustriesList =
          await _firestoreRepository.getLeaderboardIndustries();

      add(UpdateLeaderboard(leaderUsers, leaderboardIndustriesList));
    });
  }

  Stream<LeaderboardState> _mapUpdateLeaderboardToState(
      UpdateLeaderboard event) async* {
    yield LeaderboardLoaded(users: event.users, industries: event.industries);
  }

  Stream<LeaderboardState> _mapCancelLeaderboardToState() async* {
    yield LeaderboardInitial();
  }

  @override
  Future<void> close() {
    _usersSubscription?.cancel();
    _indutriesSubscription?.cancel();
    return super.close();
  }
}
