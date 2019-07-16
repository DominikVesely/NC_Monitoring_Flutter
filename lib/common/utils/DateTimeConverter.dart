import 'package:json_annotation/json_annotation.dart';

class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();

 @override
  DateTime fromJson(String json) {
    // if (json.contains(".")) {
    //   json = json.substring(0, json.length - 1);
    // }
    return DateTime.parse(json);
  }

  @override
  String toJson(DateTime object) => object.toIso8601String();
}