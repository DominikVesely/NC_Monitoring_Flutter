import 'dart:async';

import 'package:app/common/apifunctions/ncAPI.dart';
import 'package:app/model.json/ScenarioListModel.dart';
import 'package:flutter/material.dart';

Future<List<ScenarioListModel>> requestScenarioListAPI(BuildContext context) async {
  try {
    final response = await NCApi.requestGET(context, 'scenarios/load');

    if (response.statusCode == 200) {      
      Iterable list = response.result ?? [];

      return list.map((model) => ScenarioListModel.fromJson(model)).toList();
    }

  } catch (e) {
    print(e.toString());
  }
  return [];
}
