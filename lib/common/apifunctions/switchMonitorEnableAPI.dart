import 'dart:async';

import 'package:app/common/apifunctions/ncAPI.dart';
import 'package:app/common/functions/showDialogSingleButton.dart';
import 'package:app/model.json/MonitorListModel.dart';
import 'package:flutter/material.dart';

Future<MonitorListModel> switchMonitorEnableAPI(
    BuildContext context, String monitorId, bool enabled) async {
  try {
    final Map<String, dynamic> data = {
        'Enabled': enabled,
    };

    final response = await NCApi.requestPUT(context, 'monitors/put', monitorId, data);

    if (response.statusCode == 200) {
      return MonitorListModel.fromJson(response.result);
    } else {
      showDialogSingleButton(context, "Unable to Login",
          "You may have supplied an invalid 'Username' / 'Password' combination. Please try again or contact your support representative.");
    }
  } catch (e) {
    print(e.toString());
  }
  return null;
}