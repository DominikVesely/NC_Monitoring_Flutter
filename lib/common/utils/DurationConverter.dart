import 'package:app/common/utils/DurationFormatter.dart';
import 'package:json_annotation/json_annotation.dart';

class DurationConverter implements JsonConverter<Duration, String> {
  const DurationConverter();

  @override
  Duration fromJson(String timespan) {
    List<String> tokens = timespan?.split(':');

    if (tokens.length != 3) {
      return null;
    }

    int hours = 0, minutes = 0, seconds = 0;

    hours = int.tryParse(tokens[0]) ?? 0;
    minutes = int.tryParse(tokens[1]) ?? 0;
    seconds = int.tryParse(tokens[2]) ?? 0;

    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  }

  @override
  String toJson(Duration duration) {
    return DurationFormatter.ToTimeSpan(duration);
  }
}
