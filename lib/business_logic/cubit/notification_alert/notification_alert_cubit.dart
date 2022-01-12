import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'notification_alert_state.dart';

class NotificationAlertCubit extends Cubit<NotificationAlertState> {
  NotificationAlertCubit() : super(NotificationAlertInitial());
}
