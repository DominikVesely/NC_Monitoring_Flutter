// To parse this JSON data, do
//
//     final channelListModel = channelListModelFromJson(jsonString);

class ChannelListModel {
    int id;
    String name;
    int channelTypeId;
    List<dynamic> scenarios;

    ChannelListModel({
        this.id,
        this.name,
        this.channelTypeId,
        this.scenarios,
    });

    factory ChannelListModel.fromJson(Map<String, dynamic> json) => new ChannelListModel(
        id: json["Id"],
        name: json["Name"],
        channelTypeId: json["ChannelTypeId"],
        scenarios: new List<dynamic>.from(json["Scenarios"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "ChannelTypeId": channelTypeId,
        "Scenarios": new List<dynamic>.from(scenarios.map((x) => x)),
    };
}
