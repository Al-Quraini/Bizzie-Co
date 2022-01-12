import 'dart:async';
import 'dart:developer';

import 'package:bizzie_co/data/models/user.dart';
import 'package:bizzie_co/data/models/user_card.dart';
import 'package:bizzie_co/data/repository/firestore_repository.dart';
import 'package:bizzie_co/data/service/firestore_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final FirestoreRepository _firestoreRepository = FirestoreRepository();
  StreamSubscription? _userSubscription;

  UserCubit() : super(UserInitial());
/* 
  emitUser() {
    _userSubscription?.cancel();
    _userSubscription = _firestoreRepository.currentUser().listen((_) async {
      final user = await FirestoreService()
          .loadUserData(userUid: FirestoreService.currentUser!.uid);
      final card = FirestoreService.primaryCard;
      if (user == null) return;
      log('this is current user my niggers fuch soo much ${user.numOfConnections}');

      emit(UpdateUser(user: user, card: card!));
    });
  }

  emitInitialState() {
    _userSubscription?.cancel();
    emit(UserInitial());
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  } */
}
