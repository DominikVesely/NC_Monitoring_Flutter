import 'dart:async';

import 'package:app/common/apifunctions/ncAPI.dart';
import 'package:app/common/functions/showDialogSingleButton.dart';
import 'package:app/model.json/MonitorDetailModel.dart';
import 'package:flutter/material.dart';

Future<MonitorDetailModel> updateMonitorDetailAPI(
    BuildContext context, String monitorId, Map<String, dynamic> data) async {
  try {
    final response = await NCApi.requestPUT(context, 'monitors/put', monitorId, data);

    if (response.statusCode == 200) {
      return MonitorDetailModel.fromJson(response.result);
    } else {
      showDialogSingleButton(context, "Unable to Login",
          "You may have supplied an invalid 'Username' / 'Password' combination. Please try again or contact your support representative.");
    }
  } catch (e) {
    print(e.toString());
  }
  return null;
}
