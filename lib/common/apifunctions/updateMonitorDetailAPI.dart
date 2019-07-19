import 'dart:async';

import 'package:app/common/apifunctions/ncAPI.dart';
import 'package:app/model.json/MonitorDetailModel.dart';
import 'package:flutter/material.dart';

Future<MonitorDetailModel> updateMonitorDetailAPI(
    BuildContext context, String monitorId, Map<String, dynamic> data) async {

    return await NCApi.requestModelPUT(context, 'monitors/put', 
      key: monitorId,
      data: data,
      fromJson: (model) => MonitorDetailModel.fromJson(model));
}
