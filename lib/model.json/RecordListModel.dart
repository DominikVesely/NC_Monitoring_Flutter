import 'package:app/common/utils/DateTimeConverter.dart';

class RecordListModel {
  int id;
  String monitorId;
  String monitorName;
  DateTime startDate;
  DateTime endDate;
  String note;
  DateTime groupBy;

  RecordListModel(
      {this.id,
      this.monitorId,
      this.monitorName,
      this.startDate,
      this.endDate,
      this.note,
      this.groupBy
    });

  RecordListModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    monitorId = json['MonitorId'];
    monitorName = json['MonitorName'];
    startDate = const DateTimeConverter().fromJson(json['StartDate']);
    endDate = json['EndDate']==null ? null : const DateTimeConverter().fromJson(json['EndDate']);
    note = json['Note'];
    groupBy = const DateTimeConverter().fromJson(json['GroupBy']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['MonitorId'] = this.monitorId;
    data['MonitorName'] = this.monitorName;
    data['StartDate'] = const DateTimeConverter().toJson(this.startDate);
    data['EndDate'] = this.endDate==null ? null : const DateTimeConverter().toJson(this.endDate);
    data['Note'] = this.note;
    data['GroupBy'] = const DateTimeConverter().toJson(this.groupBy);
    return data;
  }
}
