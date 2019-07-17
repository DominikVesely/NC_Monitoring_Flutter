class MonitorMethodModel {
    int id;
    String name;

    MonitorMethodModel({
        this.id,
        this.name,
    });

    factory MonitorMethodModel.fromJson(Map<String, dynamic> json) => new MonitorMethodModel(
        id: json["Id"],
        name: json["Name"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
    };
}
