class MonitorVerificationModel {
    int id;
    String name;

    MonitorVerificationModel({
        this.id,
        this.name,
    });

    factory MonitorVerificationModel.fromJson(Map<String, dynamic> json) => new MonitorVerificationModel(
        id: json["Id"],
        name: json["Name"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
    };
}
