import 'dart:async';
import 'dart:developer';
import 'package:bizzie_co/data/models/activity.dart';
import 'package:bizzie_co/data/models/connection.dart';
import 'package:bizzie_co/data/models/like.dart';
import 'package:bizzie_co/data/models/request.dart';
import 'package:bizzie_co/data/models/user.dart';
import 'package:bizzie_co/data/models/user_card.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'authentication_service.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static User? _user;
  static UserCard? _userCard;
  static List<User> _conncetionUsers = [];
  static User? get currentUser => _user;
  static UserCard? get primaryCard => _userCard;
  static List<User> get myConnections => _conncetionUsers;
  // static StreamController<List<User>> connectionsConetroller =
  // StreamController();

  void updateConnections(List<User> connectionUsers) {
    _conncetionUsers = connectionUsers;
    // connectionsConetroller.add(connectionUsers);
    // log('${FirestoreService.myConnections.length}');
  }

  static void resetUser() {
    _conncetionUsers = [];
    _user = null;
  }

  // Call the user's CollectionReference to add a new use
  Future<void> addUser({required User user}) async {
    await _firestore
        .collection(USERS)
        .doc(AuthenticationService().getUser()!.uid)
        .set(user.toMap())
        .then((value) {
      return;
    }).catchError((error) {
      return;
    });
  }

// update user fields
  Future<bool> updateUser({required Map<String, dynamic> map}) async =>
      await _firestore
          .collection(USERS)
          .doc(AuthenticationService().getUser()!.uid)
          .update(map)
          .then((value) {
        return true;
      }).catchError((error) {
        return false;
      });

// load user data
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
          .catchError((onError) => log('noononononononon $onError'));

      if (userUid == AuthenticationService().getUser()!.uid) {
        _user = user;
      }

      return user;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // Call the cards's CollectionReference to add a new use
  Future<String?> addCard({required UserCard card}) async {
    final path = '$USERS/${card.userUid}/$CARDS';
    await _firestore
        .collection(path)
        .doc(card.cardUid)
        .set(card.toMap())
        .then((value) {
      return card.cardUid;
    }).catchError((error) {});
  }

  // Call the cards's CollectionReference to add a new use
  Future<String?> updateCardFields(
      {required Map<String, dynamic> map, required UserCard card}) async {
    final path = '$USERS/${card.userUid}/$CARDS';
    await _firestore
        .collection(path)
        .doc(card.cardUid)
        .update(map)
        .then((value) {
      return card.cardUid;
    }).catchError((error) {});
  }

  // load card data
  Future<UserCard?> getCardData(
      {required String userUid, required String cardUid}) async {
    UserCard? card;
    final path = '$USERS/$userUid/$CARDS/';

    try {
      await _firestore
          .collection(path)
          .doc(cardUid)
          .get()
          .then((snapshot) {
            card = UserCard.fromMap(snapshot.data()!);
          })
          .then((value) => log('card data loaded successfully'))
          .catchError((onError) {});

      if (card!.userUid == AuthenticationService().getUser()!.uid) {
        _userCard = card;
      }

      return card;
    } catch (e) {
      log(e.toString() + 'check chekc');
      return null;
    }
  }

  // delete card
  Future<String?> delete({required UserCard card}) async {
    final path = '$USERS/${card.userUid}/$CARDS';
    await _firestore.collection(path).doc(card.cardUid).delete().then((value) {
      return card.cardUid;
    }).catchError((error) {});
  }

  // add request
  Future<String?> addRequest({required Request request}) async {
    final path = '$USERS/${request.requestTo}/$REQUESTS';

    final docExists =
        await checkIfDocExists(path: path, docId: request.requestFrom);

    if (!docExists) {
      await _firestore
          .collection(path)
          .doc(request.requestFrom)
          .set(request.toMap())
          .then((value) {
        return null;
      }).catchError((error) {
        return error;
      });
    } else {
      log('You already sent request to this user');
      return 'You already sent request to this user';
    }
  }

  // get connections
  Future<List<User>> getConnections() async {
    final path = '$USERS/${currentUser!.uid}/$CONNECTIONS';
    List<Connection> connections = [];
    List<User> users = [];

    try {
      await _firestore.collection(path).get().then((snapshots) {
        for (QueryDocumentSnapshot snapshot in snapshots.docs) {
          Connection connection;

          log(snapshots.docs[2].data().toString());

          connection =
              Connection.fromMap(snapshot.data()! as Map<String, dynamic>);

          connections.add(connection);
        }
      }).then((value) async {
        final listOfUid = connections.map((e) => e.userUid).toList();

        for (String uid in listOfUid) {
          final user = await loadUserData(userUid: uid);
          users.add(user!);
        }
      });

      _conncetionUsers = users;

      return users;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  // get requests
  List<Request> getRequests(AsyncSnapshot<QuerySnapshot> snapshots) {
    List<Request> requests = [];

    try {
      Request request;
      for (QueryDocumentSnapshot snapshot in snapshots.data!.docs) {
        request = Request.fromMap(snapshot.data()! as Map<String, dynamic>);

        requests.add(request);
      }

      return requests;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<void> acceptRequest({required Request request}) async {
    final path = '$USERS/${currentUser!.uid}/$REQUESTS';

    await _firestore
        .collection(path)
        .doc(request.requestFrom)
        .delete()
        .then((value) => addConnection(request: request))
        .onError((error, stackTrace) => log(error.toString()));
  }

  Future<void> denyRequest({required Request request}) async {
    final path = '$USERS/${currentUser!.uid}/$REQUESTS';

    await _firestore
        .collection(path)
        .doc(request.requestFrom)
        .delete()
        .then((value) => log("deleted"))
        .onError((error, stackTrace) => log(error.toString()));
  }

  void addConnection({required Request request}) {
    final myPath = '$USERS/${currentUser!.uid}/$CONNECTIONS';
    final otherPath = '$USERS/${request.requestFrom}/$CONNECTIONS';

    // add connection to my connections collection
    Connection myConnection =
        Connection(timeStamp: DateTime.now(), userUid: request.requestFrom);
    try {
      _firestore
          .collection(myPath)
          .doc(request.requestFrom)
          .set(myConnection.toMap())
          .then((value) {
        addActivity(
          reciever: request.requestFrom,
        );
      });
    } catch (e) {
      log(e.toString());
    }

    // add connection to other person connections collection
    Connection otherConnection =
        Connection(timeStamp: DateTime.now(), userUid: request.requestTo);
    try {
      _firestore
          .collection(otherPath)
          .doc(request.requestTo)
          .set(otherConnection.toMap())
          .then((value) {});
    } catch (e) {
      log(e.toString());
    }
  }

  // add notification to firestore
  void addActivity({String? reciever}) async {
    String notificationText = 'shared their card with';

    Activity activity = Activity(
        timeStamp: DateTime.now(),
        description: notificationText,
        activityUser: currentUser!.uid,
        activityUid: const Uuid().v4(),
        recieverUser: reciever);

    try {
      _firestore
          .collection(ACTIVITIES)
          .doc(activity.activityUid)
          .set(activity.toMap());
    } catch (e) {
      log(e.toString());
    }
  }

  // add like or remove like from activity
  void likeActivity(String docId, Like like) async {
    final String collectionPath = '$ACTIVITIES/$docId/$LIKES';
    final bool doesExist = await checkIfDocExists(path: collectionPath);
    try {
      if (!doesExist) {
        _firestore
            .collection(collectionPath)
            .doc(currentUser!.uid)
            .set(like.toMap())
            .then((value) => log('succefully like the activity'));
      } else {
        _firestore
            .collection(collectionPath)
            .doc(currentUser!.uid)
            .delete()
            .then((value) => log('succefully delete the like'));
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // get likes of the activity
  Future<List<Like>> getLikesOfActivity({required String docId}) async {
    final path = '$ACTIVITIES/$docId/$LIKES';
    List<Like> likes = [];

    try {
      await _firestore.collection(path).get().then((snapshots) {
        for (QueryDocumentSnapshot snapshot in snapshots.docs) {
          Like like;

          like = Like.fromMap(snapshot.data()! as Map<String, dynamic>);

          likes.add(like);
        }
      }).then((value) async {});

      return likes;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  // get likes
  List<Like> getLikes(AsyncSnapshot<QuerySnapshot> snapshots) {
    List<Like> likes = [];

    try {
      Like like;
      for (QueryDocumentSnapshot snapshot in snapshots.data!.docs) {
        like = Like.fromMap(snapshot.data()! as Map<String, dynamic>);

        likes.add(like);
      }

      return likes;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  // likes stream
  Stream<QuerySnapshot> likesStream({required String activityId}) {
    final path = '$ACTIVITIES/$activityId/$LIKES';

    return _firestore.collection(path).snapshots();
  }

// check if the document exists in the collection
  Future<bool> checkIfDocExists({required String path, String? docId}) async {
    try {
      // Get reference to Firestore collection
      var collectionRef = _firestore.collection(path);

      var doc = await collectionRef.doc(docId ?? currentUser!.uid).get();
      log(doc.exists.toString());
      return doc.exists;
    } catch (e) {
      rethrow;
    }
  }
}
