import 'package:bizzie_co/data/models/activity.dart';
import 'package:bizzie_co/data/models/attendee.dart';
import 'package:bizzie_co/data/models/comment.dart';
import 'package:bizzie_co/data/models/event.dart';
import 'package:bizzie_co/data/repository/firestore_repository.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
part 'attendees_state.dart';

class AttendeesCubit extends Cubit<AttendeesState> {
  final FirestoreRepository _firestoreRepository;

  AttendeesCubit({required FirestoreRepository firestoreRepository})
      : _firestoreRepository = firestoreRepository,
        super(AttendeesInitial());

  void emitAttendeesInitial() => emit(AttendeesInitial());

  void emitAttendeesLoading({required Event event}) {
    emit(AttendeesLoading());

    emitAttendeesLoaded(event: event);
  }

  Future<void> emitAttendeesLoaded({required Event event}) async {
    String path = '$EVENTS/${event.id}/$ATTENDEES';

    final List<Attendee> attendees = await _firestoreRepository.getAttendees(
      path: path,
    );

    emit(AttendeesLoaded(attendees: attendees));
  }
}
