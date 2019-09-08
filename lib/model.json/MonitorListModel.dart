class MonitorListModel {
    String id;
    String name;
    int statusId;
    String statusName;
    bool enabled;
    int methodTypeId;
    String url;
    int verificationTypeId;
    String verificationValue;
    String timeout;
    int scenarioId;

    MonitorListModel({
        this.id,
        this.name,
        this.statusId,
        this.statusName,
        this.enabled,
        this.methodTypeId,
        this.url,
        this.verificationTypeId,
        this.verificationValue,
        this.timeout,
        this.scenarioId,
    });

    factory MonitorListModel.fromJson(Map<String, dynamic> json) => new MonitorListModel(
        id: json["Id"],
        name: json["Name"],
        statusId: json["StatusId"],
        statusName: json["StatusName"],
        enabled: json["Enabled"],
        methodTypeId: json["MethodTypeId"],
        url: json["Url"],
        verificationTypeId: json["VerificationTypeId"],
        verificationValue: json["VerificationValue"],
        timeout: json["Timeout"],
        scenarioId: json["ScenarioId"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "StatusId": statusId,
        "StatusName": statusName,
        "Enabled": enabled,
        "MethodTypeId": methodTypeId,
        "Url": url,
        "VerificationTypeId": verificationTypeId,
        "VerificationValue": verificationValue,
        "Timeout": timeout,
        "ScenarioId": scenarioId,
    };
}
