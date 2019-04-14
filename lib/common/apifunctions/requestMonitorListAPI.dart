import 'dart:async';

import 'package:app/common/apifunctions/ncAPI.dart';
import 'package:app/common/functions/showDialogSingleButton.dart';
import 'package:app/model.json/MonitorListModel.dart';
import 'package:flutter/material.dart';

Future<List<MonitorListModel>> requestMonitorListAPI(
    BuildContext context) async {
  try {
    final response = await NCApi.requestGET('monitors/load');

    if (response.statusCode == 200) {
      Iterable list = response.result;

      return list.map((model) => MonitorListModel.fromJson(model)).toList();
    } else {
      showDialogSingleButton(context, "Unable to Login",
          "You may have supplied an invalid 'Username' / 'Password' combination. Please try again or contact your support representative.");
    }
  } catch (e) {
    print(e.toString());
  }

  return null;
}
