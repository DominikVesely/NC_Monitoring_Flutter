class ScenarioListModel {
    int id;
    String name;

    ScenarioListModel({
        this.id,
        this.name,
    });

    factory ScenarioListModel.fromJson(Map<String, dynamic> json) => new ScenarioListModel(
        id: json["Id"],
        name: json["Name"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
    };
}
