import 'package:app/common/utils/DurationConverter.dart';

class MonitorDetailModel {
    String id;
    String name;
    int scenarioId;
    String scenarioName;
    int statusId;
    String statusName;
    bool enabled;
    int methodTypeId;
    String methodTypeName;
    String url;
    int verificationTypeId;
    String verificationTypeName;
    String verificationValue;
    Duration timeout;

    MonitorDetailModel({
        this.id,
        this.name,
        this.scenarioId,
        this.scenarioName,
        this.statusId,
        this.statusName,
        this.enabled,
        this.methodTypeId,
        this.methodTypeName,
        this.url,
        this.verificationTypeId,
        this.verificationTypeName,
        this.verificationValue,
        this.timeout,
    });

    factory MonitorDetailModel.fromJson(Map<String, dynamic> json) => new MonitorDetailModel(
        id: json["Id"],
        name: json["Name"],
        scenarioId: json["ScenarioId"],
        scenarioName: json["ScenarioName"],
        statusId: json["StatusId"],
        statusName: json["StatusName"],
        enabled: json["Enabled"],
        methodTypeId: json["MethodTypeId"],
        methodTypeName: json["MethodTypeName"],
        url: json["Url"],
        verificationTypeId: json["VerificationTypeId"],
        verificationTypeName: json["VerificationTypeName"],
        verificationValue: json["VerificationValue"],
        timeout: const DurationConverter().fromJson(json["Timeout"]),
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "ScenarioId": scenarioId,
        "ScenarioName": scenarioName,
        "StatusId": statusId,
        "StatusName": statusName,
        "Enabled": enabled,
        "MethodTypeId": methodTypeId,
        "MethodTypeName": methodTypeName,
        "Url": url,
        "VerificationTypeId": verificationTypeId,
        "VerificationTypeName": verificationTypeName,
        "VerificationValue": verificationValue,
        "Timeout": const DurationConverter().toJson(timeout),
    };
}
