import 'dart:developer';

import 'package:bizzie_co/business_logic/bloc/activity/activity_bloc.dart';
import 'package:bizzie_co/data/models/activity.dart';
import 'package:bizzie_co/data/models/connection.dart';
import 'package:bizzie_co/data/models/notification_model.dart';
import 'package:bizzie_co/data/models/request.dart';
import 'package:bizzie_co/data/models/user.dart';
import 'package:bizzie_co/data/service/firestore_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'base_firestore_repository.dart';

class FirestoreRepository extends BaseFirestoreRepository {
  final FirebaseFirestore _firestore;

  FirestoreRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Request>> getAllRequests() {
    final path = '$USERS/${FirestoreService.currentUser!.uid}/$REQUESTS';

    return _firestore
        .collection(path)
        .orderBy('dateTime')
        .where('isPending', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Request.fromMap(doc.data())).toList();
    });
  }

  // get activities stream
  @override
  Stream<List<Activity>> getAllActivities() {
    final path = ACTIVITIES;
    final listOfUsers = FirestoreService.myConnections
        .map((connection) => connection.uid)
        .toList();

    listOfUsers.add(FirestoreService.currentUser!.uid);

    return _firestore
        .collection(path)
        .orderBy('timeStamp')
        .where('activityUser', whereIn: listOfUsers)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Activity.fromMap(doc.data())).toList();
    });
  }

  // get all notifications stream
  @override
  Stream<List<NotificationModel>> getAllNotifications() {
    final path = '$USERS/${FirestoreService.currentUser!.uid}/$NOTIFICATIONS';

    return _firestore
        .collection(path)
        .orderBy('timeStamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => NotificationModel.fromMap(doc.data()))
          .toList();
    });
  }

  @override
  Stream<List<Connection>> getAllConnections() {
    final path = '$USERS/${FirestoreService.currentUser!.uid}/$CONNECTIONS';

    return _firestore.collection(path).snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Connection.fromMap(doc.data()))
          .toList();
    });
  }

  @override
  Future<User?> loadUserData({String userUid = ''}) async {
    User? user;
    try {
      await _firestore
          .collection(USERS)
          .doc(userUid)
          .get()
          .then((snapshot) {
            user = User.fromMap(snapshot.data()!);
          })
          .then((value) => log('data loaded successfully'))
          .catchError((onError) => log('$onError'));

      return user;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
