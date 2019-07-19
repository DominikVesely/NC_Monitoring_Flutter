import 'dart:async';

import 'package:app/common/apifunctions/ncAPI.dart';
import 'package:app/model.json/MonitorListModel.dart';
import 'package:flutter/material.dart';

Future<MonitorListModel> switchMonitorEnableAPI(
    BuildContext context, String monitorId, bool enabled) async {

  final Map<String, dynamic> data = {
      'Enabled': enabled,
  };

  return await NCApi.requestModelPUT(context, 'monitors/put', 
    key: monitorId,
    data: data,
    fromJson: (model) => MonitorListModel.fromJson(model));
}
