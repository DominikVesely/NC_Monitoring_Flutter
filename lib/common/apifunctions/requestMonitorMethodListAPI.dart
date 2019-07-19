import 'dart:async';

import 'package:app/common/apifunctions/ncAPI.dart';
import 'package:app/model.json/MonitorMethodModel.dart';
import 'package:flutter/material.dart';

Future<List<MonitorMethodModel>> requestMonitorMethodListAPI(BuildContext context) async {

  return (await NCApi.requestModelFromJsonList(context, 'monitors/methods', 
    fromJson: (model) => MonitorMethodModel.fromJson(model)));
}
