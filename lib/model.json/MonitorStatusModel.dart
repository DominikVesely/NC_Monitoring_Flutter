import 'dart:convert';

List<MonitorStatusModel> monitorStatusModelFromJson(String str) => new List<MonitorStatusModel>.from(json.decode(str).map((x) => MonitorStatusModel.fromJson(x)));

String monitorStatusModelToJson(List<MonitorStatusModel> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class MonitorStatusModel {
    int id;
    String name;

    MonitorStatusModel({
        this.id,
        this.name,
    });

    factory MonitorStatusModel.fromJson(Map<String, dynamic> json) => new MonitorStatusModel(
        id: json["Id"],
        name: json["Name"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
    };
}
