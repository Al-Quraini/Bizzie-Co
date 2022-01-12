/* -------------------------------------------------------------------------- */
/*                             date time extension                            */
/* -------------------------------------------------------------------------- */
int minute = const Duration(minutes: 1).inMilliseconds;
int hour = const Duration(hours: 1).inMilliseconds;
int day = const Duration(days: 1).inMilliseconds;
int week = const Duration(days: 7).inMilliseconds;

extension TimeAgo on DateTime {
  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }

  String toTimeAgo() {
    if (timePassed() < 2 * minute) {
      return 'moment ago';
    } else if (timePassed() < hour) {
      return '${timePassed() ~/ minute} minutes';
    } else if (timePassed() < day) {
      return '${timePassed() ~/ hour} hours';
    } else if (timePassed() < 2 * day) {
      return '1 day ago';
    } else if (timePassed() < week) {
      return '${timePassed() ~/ day} days';
    } else if (timePassed() < 2 * week) {
      return 'a week ago';
    } else if (timePassed() < 4 * week) {
      return '${timePassed() ~/ week} weeks';
    }

    return '$hour';
  }

  int timePassed() =>
      DateTime.now().millisecondsSinceEpoch - millisecondsSinceEpoch;

  bool isSameDate() => year == year && month == month && day == day;
}

/* -------------------------------------------------------------------------- */
/*                               list extension                               */
/* -------------------------------------------------------------------------- */

/* extension IterableExtensions<T> on Iterable<T> {
  Iterable<T> sortBy<TSelected extends Comparable<TSelected>>(
          TSelected Function(T) selector) =>
      toList()..sort((a, b) => selector(a).compareTo(selector(b)));

  Iterable<T> sortByDescending<TSelected extends Comparable<TSelected>>(
          TSelected Function(T) selector) =>
      sortBy(selector).toList().reversed;
} */

extension Avreviation on String {
  String? getStateAbreviation() {
    List<String> splitted = split('');
    String abriviation = substring(0, 2).toUpperCase();

    if (splitted.length == 2) {
      abriviation =
          '${splitted[0].substring(0, 1)}${splitted[1].substring(0, 1)}';
      return abriviation.toUpperCase();
    }

    return abriviation;
  }
}
