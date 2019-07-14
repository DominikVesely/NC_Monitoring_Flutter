import 'package:uuid/uuid.dart';

class MonitorListModel {
  String _id;
  String _name;
  String _statusName;
  bool _enabled;
  int _methodTypeId;
  String _url;
  int _verificationTypeId;
  String _verificationValue;
  String _timeout;
  int _scenarioId;

  MonitorListModel(
      {String id,
      String name,
      String statusName,
      bool enabled,
      int methodTypeId,
      String url,
      int verificationTypeId,
      String verificationValue,
      String timeout,
      int scenarioId}) {
    this._id = id;
    this._name = name;
    this._statusName = statusName;
    this._enabled = enabled;
    this._methodTypeId = methodTypeId;
    this._url = url;
    this._verificationTypeId = verificationTypeId;
    this._verificationValue = verificationValue;
    this._timeout = timeout;
    this._scenarioId = scenarioId;
  }

  String get id => _id;
  set id(String id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  String get statusName => _statusName;
  set statusName(String statusName) => _statusName = statusName;
  bool get enabled => _enabled;
  set enabled(bool enabled) => _enabled = enabled;
  int get methodTypeId => _methodTypeId;
  set methodTypeId(int methodTypeId) => _methodTypeId = methodTypeId;
  String get url => _url;
  set url(String url) => _url = url;
  int get verificationTypeId => _verificationTypeId;
  set verificationTypeId(int verificationTypeId) =>
      _verificationTypeId = verificationTypeId;
  String get verificationValue => _verificationValue;
  set verificationValue(String verificationValue) =>
      _verificationValue = verificationValue;
  String get timeout => _timeout;
  set timeout(String timeout) => _timeout = timeout;
  int get scenarioId => _scenarioId;
  set scenarioId(int scenarioId) => _scenarioId = scenarioId;

  MonitorListModel.fromJson(Map<String, dynamic> json) {
    _id = json['Id'];
    _name = json['Name'];
    _statusName = json['StatusName'];
    _enabled = json['Enabled'];
    _methodTypeId = json['MethodTypeId'];
    _url = json['Url'];
    _verificationTypeId = json['VerificationTypeId'];
    _verificationValue = json['VerificationValue'];
    _timeout = json['Timeout'];
    _scenarioId = json['ScenarioId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this._id;
    data['Name'] = this._name;
    data['StatusName'] = this._statusName;
    data['Enabled'] = this._enabled;
    data['MethodTypeId'] = this._methodTypeId;
    data['Url'] = this._url;
    data['VerificationTypeId'] = this._verificationTypeId;
    data['VerificationValue'] = this._verificationValue;
    data['Timeout'] = this._timeout;
    data['ScenarioId'] = this._scenarioId;
    return data;
  }
}
