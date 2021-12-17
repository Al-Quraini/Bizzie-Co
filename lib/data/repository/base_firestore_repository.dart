import 'package:bizzie_co/data/models/activity.dart';
import 'package:bizzie_co/data/models/connection.dart';
import 'package:bizzie_co/data/models/notification_model.dart';
import 'package:bizzie_co/data/models/request.dart';
import 'package:bizzie_co/data/models/user.dart';

abstract class BaseFirestoreRepository {
  Stream<List<Request>> getAllRequests();

  Stream<List<Activity>> getAllActivities();

  Stream<List<NotificationModel>> getAllNotifications();

  Future<User?> loadUserData({String userUid});

  Stream<List<Connection>> getAllConnections();
}
