import 'dart:async';

import 'package:app/common/apifunctions/ncAPI.dart';
import 'package:app/model.json/MonitorVerificationModel.dart';
import 'package:flutter/material.dart';

Future<List<MonitorVerificationModel>> requestMonitorVerificationListAPI(BuildContext context) async {
  return (await NCApi.requestModelFromJsonList(context, 'monitors/verifications', 
    fromJson: (model) => MonitorVerificationModel.fromJson(model)));
}
