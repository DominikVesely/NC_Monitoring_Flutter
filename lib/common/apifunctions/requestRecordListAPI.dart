import 'dart:async';

import 'package:app/common/apifunctions/ncAPI.dart';
import 'package:app/model.json/RecordListModel.dart';
import 'package:flutter/material.dart';

Future<List<RecordListModel>> requestRecordListAPI(
    BuildContext context, String monitorId, int top) async {
  
    final String sort = '[{"selector": "StartDate", "desc": 1}]';

    if (monitorId == null) {      
      return (await NCApi.requestModelFromJsonList(context, 'records/load?take=$top&sort=$sort', 
        fromJson: (model) => RecordListModel.fromJson(model)));
    } else {      
      return (await NCApi.requestModelFromJsonList(context, 'records/forMonitorLoad?monitorId=$monitorId&take=$top&sort=$sort', 
        fromJson: (model) => RecordListModel.fromJson(model)));
    }
  
}