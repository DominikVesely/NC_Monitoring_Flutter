import 'dart:async';

import 'package:app/common/apifunctions/ncAPI.dart';
import 'package:app/model.json/ScenarioListModel.dart';
import 'package:flutter/material.dart';

Future<List<ScenarioListModel>> requestScenarioListAPI(BuildContext context) async {
  return (await NCApi.requestModelFromJsonList(context, 'scenarios/load', 
        fromJson: (model) => ScenarioListModel.fromJson(model)));
}
