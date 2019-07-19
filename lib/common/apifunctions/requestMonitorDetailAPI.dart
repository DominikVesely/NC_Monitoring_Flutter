import 'dart:async';

import 'package:app/common/apifunctions/ncAPI.dart';
import 'package:app/model.json/MonitorDetailModel.dart';
import 'package:flutter/material.dart';

Future<MonitorDetailModel> requestMonitorDetailAPI(
    BuildContext context, String id) async {
  return await NCApi.requestModelFromJson(context, 'monitors/'+id,
    fromJson: (json) {
      return MonitorDetailModel.fromJson(json);
    }
  );
}
