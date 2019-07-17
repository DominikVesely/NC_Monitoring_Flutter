import 'dart:async';

import 'package:app/common/apifunctions/ncAPI.dart';
import 'package:app/model.json/MonitorVerificationModel.dart';
import 'package:flutter/material.dart';

Future<List<MonitorVerificationModel>> requestMonitorVerificationListAPI(BuildContext context) async {
  try {
    final response = await NCApi.requestGET(context, 'monitors/verifications');

    if (response.statusCode == 200) {      
      Iterable list = response.result ?? [];

      return list.map((model) => MonitorVerificationModel.fromJson(model)).toList();
    }

  } catch (e) {
    print(e.toString());
  }
  return [];
}
