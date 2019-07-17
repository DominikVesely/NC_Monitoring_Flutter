import 'dart:async';

import 'package:app/common/apifunctions/ncAPI.dart';
import 'package:app/model.json/MonitorMethodModel.dart';
import 'package:flutter/material.dart';

Future<List<MonitorMethodModel>> requestMonitorMethodListAPI(BuildContext context) async {
  try {
    final response = await NCApi.requestGET(context, 'monitors/methods');

    if (response.statusCode == 200) {      
      Iterable list = response.result ?? [];

      return list.map((model) => MonitorMethodModel.fromJson(model)).toList();
    }

  } catch (e) {
    print(e.toString());
  }
  return [];
}
