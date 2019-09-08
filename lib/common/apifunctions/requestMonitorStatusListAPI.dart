import 'dart:async';

import 'package:app/common/apifunctions/ncAPI.dart';
import 'package:app/model.json/MonitorStatusModel.dart';
import 'package:flutter/material.dart';

Future<List<MonitorStatusModel>> requestMonitorStatusListAPI(BuildContext context, {
  int statusId
}) async {

  return (await NCApi.requestModelFromJsonList(context, 'monitors/statuses', 
    fromJson: (model) => MonitorStatusModel.fromJson(model)));
}
