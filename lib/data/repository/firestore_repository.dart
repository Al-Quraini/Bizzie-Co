import 'dart:developer';

import 'package:bizzie_co/data/models/activity.dart';
import 'package:bizzie_co/data/models/attendee.dart';
import 'package:bizzie_co/data/models/comment.dart';
import 'package:bizzie_co/data/models/event.dart';
import 'package:bizzie_co/data/models/industry.dart';
import 'package:bizzie_co/data/service/authentication_service.dart';
import 'package:bizzie_co/data/service/storage_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bizzie_co/data/models/connection.dart';
import 'package:bizzie_co/data/models/notification_model.dart';
import 'package:bizzie_co/data/models/request.dart';
import 'package:bizzie_co/data/models/user.dart';
import 'package:bizzie_co/data/service/firestore_service.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'base_firestore_repository.dart';

class FirestoreRepository extends BaseFirestoreRepository {
  final FirebaseFirestore _firestore;

  FirestoreRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /* -------------------------------------------------------------------------- */
  /*                                get requests                                */
  /* -------------------------------------------------------------------------- */
  @override
  Stream<List<Request>> getAllRequests() {
    final path = '$USERS/${FirestoreService.currentUser!.uid}/$REQUESTS';

    return _firestore
        .collection(path)
        .orderBy('timestamp')
        .where('isPending', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Request.fromMap(doc.data())).toList();
    });
  }

  /* -------------------------------------------------------------------------- */
  /*                          // get activities stream                          */
  /* -------------------------------------------------------------------------- */
  @override
  Stream<List<Activity>> getMyActivities() {
    Stream<List<Activity>> stream1 = _firestore
        .collection(ACTIVITIES)
        .where('activityUser', isEqualTo: FirestoreService.currentUser!.uid)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Activity.fromMap(doc.data())).toList());

    Stream<List<Activity>> stream2 = _firestore
        .collection(ACTIVITIES)
        .where('receiverUser', isEqualTo: FirestoreService.currentUser!.uid)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Activity.fromMap(doc.data())).toList());

    return Rx.combineLatest2(stream1, stream2,
        (List<Activity> a, List<Activity> b) {
      List<Activity> combinedList = a + b;

      combinedList.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      // combinedList.sort();
      return combinedList;
    });
  }

  @override
  Stream<List<Activity>> getAllActivities() {
    String pathA = '$USERS/${FirestoreService.currentUser!.uid}/$ACTIVITIES';

    return _firestore
        .collection(pathA)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Activity.fromMap(doc.data())).toList());
  }

  @override
  Stream<List<Activity>> getSponsoredActivities() {
    return _firestore
        .collection(ACTIVITIES)
        .orderBy('timestamp', descending: true)
        .where('visibility', isEqualTo: 'anyone')
        // .where('activituUser', isNotEqualTo: FirestoreService.currentUser!.uid)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Activity.fromMap(doc.data()))
            .where((activity) =>
                activity.activityUser != FirestoreService.currentUser!.uid)
            .toList());
  }

  @override
  Stream<List<Activity>> combinedActivities() {
    return Rx.combineLatest2(getAllActivities(), getSponsoredActivities(),
        (List<Activity> a, List<Activity> b) {
      List<Activity> combinedList = a + b;

      combinedList.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      // combinedList.sort();
      return combinedList;
    });
  }

  /* -------------------------------------------------------------------------- */
  /*                       // get all notifications stream                      */
  /* -------------------------------------------------------------------------- */
  @override
  Stream<List<NotificationModel>> getAllNotifications() {
    final path = '$USERS/${FirestoreService.currentUser!.uid}/$NOTIFICATIONS';

    return _firestore
        .collection(path)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => NotificationModel.fromMap(doc.data()))
          .toList();
    });
  }

/* -------------------------------------------------------------------------- */
/*                                 connections                                */
/* -------------------------------------------------------------------------- */
  @override
  Stream<List<Connection>> getConnections(
      {required String path, required int limit}) {
    // final path = '$USERS/${FirestoreService.currentUser!.uid}/$CONNECTIONS';

    return _firestore.collection(path).limit(limit).snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Connection.fromMap(doc.data()))
          .toList();
    });
  }

  @override
  Stream<List<Event>> getEvents({required int limit}) {
    // final path = '$USERS/${FirestoreService.currentUser!.uid}/$CONNECTIONS';

    return _firestore
        .collection(EVENTS)
        .limit(limit)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Event.fromMap(doc.data())).toList();
    });
  }

  /* -------------------------------------------------------------------------- */
  /*                            get leaderboard users                            */
  /* -------------------------------------------------------------------------- */
  @override
  Stream<List<User>> getLeaderboardUsers() {
    return _firestore
        .collection(USERS)
        .orderBy('numOfConnections', descending: true)
        .limit(10)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => User.fromMap(doc.data())).toList();
    });
  }

  @override
  Future<List<Industry>> getLeaderboardIndustries() async {
    return await _firestore
        .collection(INDUSTRIES)
        .orderBy('numOfUsers', descending: true)
        .limit(10)
        .get()
        .then((snapshot) {
      return snapshot.docs.map((doc) => Industry.fromMap(doc.data())).toList();
    });
  }

  /* -------------------------------------------------------------------------- */
  /*                            get list of comments                            */
  /* -------------------------------------------------------------------------- */

  // get likes of the activity
  @override
  Future<List<Comment>> getComments({required String path, int? limit}) async {
    List<Comment> comments = [];

    Query<Map<String, dynamic>> query =
        _firestore.collection(path).orderBy('timestamp', descending: false);
    if (limit != null) {
      query = query.limit(limit);
    }

    try {
      await query.get().then((snapshots) async {
        for (QueryDocumentSnapshot snapshot in snapshots.docs) {
          Comment comment;

          comment = Comment.fromMap(snapshot.data()! as Map<String, dynamic>);
          comment.setUrl =
              await StorageService().getImageUrl(comment.userImagePath);

          comments.add(comment);
        }
      }).then((value) {});

      return comments;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
  /* -------------------------------------------------------------------------- */
  /*                            get list of attendees                            */
  /* -------------------------------------------------------------------------- */

  // get likes of the activity
  @override
  Future<List<Attendee>> getAttendees({required String path}) async {
    List<Attendee> comments = [];

    Query<Map<String, dynamic>> query =
        _firestore.collection(path).orderBy('timestamp', descending: false);
    // if (limit != null) {
    //   query = query.limit(limit);
    // }

    try {
      await query.get().then((snapshots) async {
        for (QueryDocumentSnapshot snapshot in snapshots.docs) {
          Attendee attendee;

          attendee = Attendee.fromMap(snapshot.data()! as Map<String, dynamic>);
          attendee.setUrl =
              await StorageService().getImageUrl(attendee.imagePath);

          comments.add(attendee);
        }
      }).then((value) {});

      return comments;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  @override
  Stream<User> currentUser() {
    return _firestore
        .doc('$USERS/${AuthenticationService().getUser()!.uid}')
        .snapshots()
        .map((snapshot) {
      // log(snapshot.data()!.toString());
      return User.fromMap(snapshot.data()!);
    });
  }
}
