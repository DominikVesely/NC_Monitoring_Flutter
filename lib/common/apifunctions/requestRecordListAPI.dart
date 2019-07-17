import 'dart:async';

import 'package:app/common/apifunctions/ncAPI.dart';
import 'package:app/common/functions/showDialogSingleButton.dart';
import 'package:app/model.json/RecordListModel.dart';
import 'package:flutter/material.dart';

Future<List<RecordListModel>> requestRecordListAPI(
    BuildContext context, String monitorId, int top) async {
  try {
    final response = await NCApi.requestGET(context, 'records/forMonitorLoad?monitorId=$monitorId&take=$top');

    if (response.statusCode == 200) {
      Iterable list = response.result ?? [];

      return list.map((model) => RecordListModel.fromJson(model)).toList();
    } else {
      showDialogSingleButton(context, "Unable to Login",
          "You may have supplied an invalid 'Username' / 'Password' combination. Please try again or contact your support representative.");
    }
  } catch (e) {
    print(e.toString());
  }

  return [];
}