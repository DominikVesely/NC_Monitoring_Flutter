import 'dart:async';

import 'package:app/common/apifunctions/ncAPI.dart';
import 'package:app/model.json/MonitorListModel.dart';
import 'package:flutter/material.dart';

Future<List<MonitorListModel>> requestMonitorListAPI(
    BuildContext context) async {

      return (await NCApi.requestModelFromJsonList(context, 'monitors/load',
        fromJson: (model) => MonitorListModel.fromJson(model)));
}
