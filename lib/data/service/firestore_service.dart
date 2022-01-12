import 'dart:async';
import 'dart:developer';
import 'package:bizzie_co/data/models/activity.dart';
import 'package:bizzie_co/data/models/attendee.dart';
import 'package:bizzie_co/data/models/comment.dart';
import 'package:bizzie_co/data/models/connection.dart';
import 'package:bizzie_co/data/models/event.dart';
import 'package:bizzie_co/data/models/industry_user.dart';
import 'package:bizzie_co/data/models/notification_model.dart';
import 'package:bizzie_co/data/models/report.dart';
import 'package:bizzie_co/data/models/request.dart';
import 'package:bizzie_co/data/models/ticket.dart';
import 'package:bizzie_co/data/models/user.dart';
import 'package:bizzie_co/data/models/user_card.dart';
import 'package:bizzie_co/data/service/storage_service.dart';

import 'package:bizzie_co/utils/constant.dart';
import 'package:bizzie_co/utils/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'authentication_service.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /* -------------------------------------------------------------------------- */
  /*                              current user data                             */
  /* -------------------------------------------------------------------------- */
  static User? _user;
  static UserCard? _userCard;
  static List<UserCard>? _userCards;
  static List<Ticket>? _tickets;

  static User? get currentUser => _user;
  static UserCard? get primaryCard => _userCard;
  static List<UserCard>? get cards => _userCards;
  static List<Ticket>? get tickets => _tickets;

  // static StreamController<List<User>> connectionsConetroller =
  // StreamController();

  /* -------------------------------------------------------------------------- */
  /*                                    user                                    */
  /* -------------------------------------------------------------------------- */
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
  Future<User?> loadUserData({required String userUid}) async {
    User? user;
    try {
      await _firestore.collection(USERS).doc(userUid).get().then((snapshot) {
        user = User.fromMap(snapshot.data()!);
      }).then((value) => log('data loaded successfully'));
      final String? url = await StorageService().getImageUrl(user?.imagePath);

      user?.setUrl = url;

      if (userUid == AuthenticationService().getUser()!.uid) {
        _user = user;
      }

      return user;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // update user fields
  Future<bool> deleteUser({required String userUid}) async =>
      await _firestore.collection(USERS).doc(userUid).delete().then((value) {
        return true;
      }).catchError((error) {
        return false;
      });

  /* -------------------------------------------------------------------------- */
  /*                                  industry                                  */
  /* -------------------------------------------------------------------------- */
  void addUserToIndustry({required IndustryUser industryUser}) {
    final String path =
        '$INDUSTRIES/${industryUser.industry}/$USERS/${industryUser.uid}';

    try {
      _firestore.doc(path).set(industryUser.toMap()).then((value) => _firestore
          .collection(ACTIVITIES)
          .doc(industryUser.industry)
          .update({'numOfUsers': FieldValue.increment(1)}));
    } catch (e) {
      log(e.toString());
      return;
    }
  }

/* -------------------------------------------------------------------------- */
/*                                    card                                    */
/* -------------------------------------------------------------------------- */
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
      await _firestore.collection(path).doc(cardUid).get().then((snapshot) {
        card = UserCard.fromMap(snapshot.data()!);
      });

      if (card!.userUid == AuthenticationService().getUser()!.uid) {
        _userCard = card;
        log('true statement');
      }

      return card;
    } catch (e) {
      log(e.toString() + 'check chekc');
      return null;
    }
  }

  // get all cards
  Future<List<UserCard>> getAllCards({required String userUid}) async {
    final String path = '$USERS/$userUid/$CARDS';

    return await _firestore
        .collection(path)
        .get()
        .then((snapshots) =>
            snapshots.docs.map((doc) => UserCard.fromMap(doc.data())).toList())
        .catchError((error) {
      return <UserCard>[];
    });
  }

  // delete card
  Future<String?> delete({required UserCard card}) async {
    final path = '$USERS/${card.userUid}/$CARDS';
    await _firestore.collection(path).doc(card.cardUid).delete().then((value) {
      return card.cardUid;
    }).catchError((error) {});
  }

  /* -------------------------------------------------------------------------- */
  /*                                   request                                  */
  /* -------------------------------------------------------------------------- */
  // add request
  Future<String?> addRequest({required Request request}) async {
    final path = '$USERS/${request.requestTo}/$REQUESTS';
    final connectionPath = '$USERS/${currentUser!.uid}/$CONNECTIONS';

    final docExists =
        await checkIfDocExists(path: path, docId: request.requestFrom);

    final docConnectionExists =
        await checkIfDocExists(path: connectionPath, docId: request.requestTo);

    if (docExists) {
      return 'You already sent request to this user';
    }
    if (docConnectionExists) {
      return 'You already have this user as a connection';
    }

    await _firestore
        .collection(path)
        .doc(request.requestFrom)
        .set(request.toMap())
        .then((value) {
      return null;
    }).catchError((error) {
      return error;
    });
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

// this method invoked when the user accept the request
  Future<void> acceptRequest({required Request request}) async {
    final path = '$USERS/${currentUser!.uid}/$REQUESTS';

    await _firestore
        .collection(path)
        .doc(request.requestFrom)
        .delete()
        .then((value) => addConnection(request: request))
        .onError((error, stackTrace) => log(error.toString()));
  }

  // this method invoked when the user accept the request
  Future<void> denyRequest({required Request request}) async {
    final path = '$USERS/${currentUser!.uid}/$REQUESTS';

    await _firestore
        .collection(path)
        .doc(request.requestFrom)
        .delete()
        .onError((error, stackTrace) => log(error.toString()));
  }

/* -------------------------------------------------------------------------- */
/*                                 connection                                 */
/* -------------------------------------------------------------------------- */

  // add connection
  void addConnection({required Request request}) {
    final myPath = '$USERS/${currentUser!.uid}/$CONNECTIONS';
    final otherPath = '$USERS/${request.requestFrom}/$CONNECTIONS';

    // add connection to my connections collection
    Connection myConnection = Connection(
        timestamp: DateTime.now(),
        userFirstName: request.userFirstName,
        userLastName: request.userLastName,
        industry: request.industry,
        userImagePath: request.userImagePath,
        userUid: request.requestFrom);
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
    Connection otherConnection = Connection(
        userFirstName: currentUser!.firstName!,
        userLastName: currentUser!.lastName!,
        userImagePath: currentUser!.imagePath,
        industry: currentUser!.industry,
        timestamp: DateTime.now(),
        userUid: request.requestTo);
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

  // add connection
  Future deleteConnection({required Connection connection}) async {
    final myPath = '$USERS/${currentUser!.uid}/$CONNECTIONS';
    final otherPath = '$USERS/${connection.userUid}/$CONNECTIONS';

    try {
      _firestore
          .collection(myPath)
          .doc(connection.userUid)
          .delete()
          .then((value) {});
    } catch (e) {
      log(e.toString());
    }

    try {
      _firestore
          .collection(otherPath)
          .doc(currentUser!.uid)
          .delete()
          .then((value) {});
    } catch (e) {
      log(e.toString());
    }
  }

  // // get all connections
  // Future<List<Connection>> getAllConnections({required String path}) async {
  //   List<Connection> connections = [];

  //   try {
  //     await _firestore.collection(path).get().then((snapshots) {
  //       for (QueryDocumentSnapshot snapshot in snapshots.docs) {
  //         Connection connection;

  //         connection =
  //             Connection.fromMap(snapshot.data()! as Map<String, dynamic>);

  //         connections.add(connection);
  //       }
  //     }).then((value) async {});

  //     return connections;
  //   } catch (e) {
  //     log(e.toString());
  //     return [];
  //   }
  // }

/* -------------------------------------------------------------------------- */
/*                                notification                                */
/* -------------------------------------------------------------------------- */

  // mark notification as read
  void readNotification({required String notificationId}) {
    final String path =
        '$USERS/${currentUser!.uid}/$NOTIFICATIONS/$notificationId';

    try {
      _firestore.doc(path).update({'isRead': true});
    } catch (e) {}
  }

/* -------------------------------------------------------------------------- */
/*                                  activity                                  */
/* -------------------------------------------------------------------------- */
  Future<bool> addActivity({String? reciever, Activity? activity}) async {
    String notificationText = 'shared their card with';

    Activity myActivity = Activity(
        likedBy: [],
        userFirstName: currentUser!.firstName!,
        userLastName: currentUser!.lastName!,
        userImagePath: currentUser!.imagePath,
        industry: currentUser!.industry,
        timestamp: DateTime.now(),
        description: notificationText,
        activityUser: currentUser!.uid,
        activityUid: const Uuid().v4(),
        recieverUser: reciever);
    if (activity != null) {
      myActivity = activity;
    }
    try {
      _firestore
          .collection(ACTIVITIES)
          .doc(myActivity.activityUid)
          .set(myActivity.toMap())
          .then((value) => true);

      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<List<Activity>> getAllActivities({required String path}) async {
    List<Activity> activities = [];

    try {
      await _firestore
          .collection(path)
          .orderBy('timestamp', descending: false)
          .get()
          .then((snapshots) {
        for (QueryDocumentSnapshot snapshot in snapshots.docs) {
          Activity activity;

          activity = Activity.fromMap(snapshot.data()! as Map<String, dynamic>);

          activities.add(activity);
        }
      }).then((value) async {});

      return activities;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

/* -------------------------------------------------------------------------- */
/*                                    like                                    */
/* -------------------------------------------------------------------------- */
  // add like or remove like from activity
  Future<bool> likeActivity(Activity activity) async {
    final String collectionPath = '$ACTIVITIES/${activity.activityUid}';
    final String notificationPath =
        '$USERS/${activity.activityUser}/$NOTIFICATIONS';

    // returns true when the user id exists in the likedBy list,
    //otherwise it's false
    final bool doesExist = activity.likedBy.contains(currentUser!.uid);

    try {
      if (!doesExist) {
        // if the user uid doesnt exists add my uid to the list
        await _firestore.doc(collectionPath).update({
          'likedBy': FieldValue.arrayUnion([currentUser!.uid])
        }).then((value) {
          // send notification to the creator of the activity
          final NotificationModel notification = NotificationModel(
              notificationFrom: currentUser!.uid,
              notificationType: NotificationType.like,
              notificationId: currentUser!.uid + activity.activityUid,
              // description: 'Liked your activity',

              timestamp: DateTime.now(),
              userFirstName: currentUser!.firstName!,
              userLastName: currentUser!.lastName!,
              industry: currentUser!.industry,
              userImagePath: currentUser!.imagePath);

          // if the user like their own post, don't send notification
          if (activity.activityUser != currentUser!.uid) {
            _firestore
                .doc('$notificationPath/${notification.notificationId}')
                .set(notification.toMap());
          }
          return true;
        });
      } else {
        // remove my uid from the likedBy list when I remove the like
        await _firestore.doc(collectionPath).update({
          'likedBy': FieldValue.arrayRemove([currentUser!.uid])
        }).then((value) {
          if (activity.activityUser != currentUser!.uid) {
            _firestore
                .doc(
                    '$notificationPath/${currentUser!.uid + activity.activityUid}')
                .delete();
          }
        });
      }
      return true;
    } catch (e) {
      log(e.toString());
      return true;
    }
  }

  /* -------------------------------------------------------------------------- */
  /*                                  comments                                  */
  /* -------------------------------------------------------------------------- */

  // Call the cards's CollectionReference to add a new use
  Future<void> addComment(
      {required Comment comment, required String path}) async {
    final String notificationPath = '$USERS/${comment.userUid}/$NOTIFICATIONS';
    await _firestore
        .collection(path)
        .doc(comment.commentUid)
        .set(comment.toMap())
        .then((value) {
      _firestore
          .doc('$ACTIVITIES/${comment.postUid}')
          .update({'numOfComments': FieldValue.increment(1)});

      // send notification to the user when commenting to their activity
      final NotificationModel notification = NotificationModel(
          notificationFrom: currentUser!.uid,
          notificationType: NotificationType.comment,
          notificationId: currentUser!.uid +
              DateTime.now().millisecondsSinceEpoch.toString(),
          // description: 'Liked your activity',

          timestamp: DateTime.now(),
          userFirstName: currentUser!.firstName!,
          userLastName: currentUser!.lastName!,
          industry: currentUser!.industry,
          userImagePath: currentUser!.imagePath);

      // don't send notification if it is my activity
      if (comment.userUid != currentUser!.uid) {
        _firestore
            .doc('$notificationPath/${notification.notificationId}')
            .set(notification.toMap());
      }
      return comment.commentUid;
    }).catchError((error) {});
  }

  /* -------------------------------------------------------------------------- */
  /*                                   report                                   */
  /* -------------------------------------------------------------------------- */

  // Add report document to reports collection
  Future<bool> addReport({required Report report}) async {
    try {
      await _firestore
          .collection(REPORTS)
          .doc(report.reportUid)
          .set(report.toMap())
          .then((value) {})
          .catchError((error) {});
      return true;
    } catch (e) {
      return false;
    }
  }

  /* -------------------------------------------------------------------------- */
  /*                                   events                                   */
  /* -------------------------------------------------------------------------- */

  // add event
  Future<void> addEvent({required Event event}) async {
    await _firestore
        .collection(EVENTS)
        .doc(event.id)
        .set(event.toMap())
        .then((value) {
      return;
    }).catchError((error) {
      return;
    });
  }

// load event data
  Future<Event?> loadEvent({required String eventId}) async {
    Event? event;
    try {
      await _firestore.collection(USERS).doc(eventId).get().then((snapshot) {
        event = Event.fromMap(snapshot.data()!);
      });

      return event;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // update event fields
  Future<bool> updateEvent(
          {required Map<String, dynamic> map, required String eventId}) async =>
      await _firestore
          .collection(EVENTS)
          .doc(eventId)
          .update(map)
          .then((value) {
        return true;
      }).catchError((error) {
        return false;
      });

  // attend event
  Future<String?> attendEvent(
      {required String userUid,
      required String eventUid,
      required Attendee attendee,
      required Ticket ticket}) async {
    final attendeePath = '$EVENTS/$eventUid/$ATTENDEES';
    final ticketPath = '$USERS/$userUid/$TICKETS';

    final bool attendeeExists =
        await checkIfDocExists(path: attendeePath, docId: userUid);
    final bool ticketExists =
        await checkIfDocExists(path: ticketPath, docId: ticket.eventUid);

    if (attendeeExists || ticketExists) {
      return 'You already registered for this event';
    }
    try {
      await _firestore.doc('$attendeePath/$userUid').set(attendee.toMap());
      await _firestore
          .doc('$ticketPath/${ticket.eventUid}')
          .set(ticket.toMap());

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // delete event
  Future<bool> deleteEvent({required String eventId}) async =>
      await _firestore.collection(EVENTS).doc(eventId).delete().then((value) {
        return true;
      }).catchError((error) {
        return false;
      });

  Future<List<Attendee>> getAttendees({required String eventId}) async {
    List<Attendee> attendees = [];

    await _firestore
        .collection(EVENTS)
        .doc(eventId)
        .collection(ATTENDEES)
        .get()
        .then((snapshots) {
      for (QueryDocumentSnapshot snapshot in snapshots.docs) {
        final attendee =
            Attendee.fromMap(snapshot.data()! as Map<String, dynamic>);

        attendees.add(attendee);
      }
    }).catchError((error) {
      return [];
    });
    return attendees;
  }

  // get all cards
  Future<List<Attendee>> getAllAttendees({required String eventUid}) async {
    final String path = '$EVENTS/$eventUid/$ATTENDEES';

    return await _firestore
        .collection(path)
        .get()
        .then((snapshots) =>
            snapshots.docs.map((doc) => Attendee.fromMap(doc.data())).toList())
        .catchError((error) {
      return <Attendee>[];
    });
  }

  Future<List<Ticket>> getTickets({required String userUid}) async {
    List<Ticket> tickets = [];

    await _firestore
        .collection(USERS)
        .doc(userUid)
        .collection(TICKETS)
        .get()
        .then((snapshots) {
      for (QueryDocumentSnapshot snapshot in snapshots.docs) {
        final ticket = Ticket.fromMap(snapshot.data()! as Map<String, dynamic>);

        tickets.add(ticket);
      }
    }).catchError((error) {
      return <Ticket>[];
    });
    return tickets;
  }

/* -------------------------------------------------------------------------- */
/*                              internal methods                              */
/* -------------------------------------------------------------------------- */

  void updateCurrentUser(User user) {
    _user = user;
  }

  static void setUserCards(List<UserCard> cards) {
    _userCards = cards;
  }

  static void setTickets(List<Ticket> tickets) {
    _tickets = tickets;
  }

  static void resetUser() {
    _user = null;
    _userCards = null;
    _userCard = null;
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
