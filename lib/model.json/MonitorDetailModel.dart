class MonitorDetailModel {
  String id;
  String name;
  String statusName;
  String methodTypeName;
  String url;
  String verificationTypeName;
  String verificationValue;
  String timeout;
  int scenarioId;
  String scenarioName;

  MonitorDetailModel(
      {this.id,
      this.name,
      this.statusName,
      this.methodTypeName,
      this.url,
      this.verificationTypeName,
      this.verificationValue,
      this.timeout,
      this.scenarioId,
      this.scenarioName});

  MonitorDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    statusName = json['StatusName'];
    methodTypeName = json['MethodTypeName'];
    url = json['Url'];
    verificationTypeName = json['VerificationTypeName'];
    verificationValue = json['VerificationValue'];
    timeout = json['Timeout'];
    scenarioId = json['ScenarioId'];
    scenarioName = json['ScenarioName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['StatusName'] = this.statusName;
    data['MethodTypeName'] = this.methodTypeName;
    data['Url'] = this.url;
    data['VerificationTypeName'] = this.verificationTypeName;
    data['VerificationValue'] = this.verificationValue;
    data['Timeout'] = this.timeout;
    data['ScenarioId'] = this.scenarioId;
    data['ScenarioName'] = this.scenarioName;
    return data;
  }
}
