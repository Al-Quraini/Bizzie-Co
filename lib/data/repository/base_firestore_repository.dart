import 'package:bizzie_co/data/models/activity.dart';
import 'package:bizzie_co/data/models/attendee.dart';
import 'package:bizzie_co/data/models/comment.dart';
import 'package:bizzie_co/data/models/connection.dart';
import 'package:bizzie_co/data/models/event.dart';
import 'package:bizzie_co/data/models/industry.dart';
import 'package:bizzie_co/data/models/notification_model.dart';
import 'package:bizzie_co/data/models/request.dart';
import 'package:bizzie_co/data/models/user.dart';

abstract class BaseFirestoreRepository {
  Stream<List<Request>> getAllRequests();

  Stream<List<Activity>> getAllActivities();

  Stream<List<Activity>> getSponsoredActivities();

  Stream<List<Activity>> combinedActivities();

  Stream<List<Activity>> getMyActivities();

  Stream<List<NotificationModel>> getAllNotifications();

  Stream<User> currentUser();

  Stream<List<Connection>> getConnections(
      {required String path, required int limit});

  Stream<List<User>> getLeaderboardUsers();
  Future<List<Industry>> getLeaderboardIndustries();

  Future<List<Comment>> getComments({required String path, int? limit});
  Future<List<Attendee>> getAttendees({required String path});
  Stream<List<Event>> getEvents({required int limit});
}
