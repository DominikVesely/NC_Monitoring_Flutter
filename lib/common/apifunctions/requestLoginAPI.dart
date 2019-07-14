import 'dart:async';

import 'package:app/common/apifunctions/ncAPI.dart';
import 'package:app/common/functions/saveCurrentLogin.dart';
import 'package:app/common/functions/showDialogSingleButton.dart';
import 'package:app/config/routes.dart';
import 'package:app/model.json/LoginModel.dart';
import 'package:flutter/material.dart';

Future<LoginModel> requestLoginAPI(
    BuildContext context, String username, String password) async {
  Map<String, String> data = {
    'username': username,
    'password': password,
  };

  try {
    final response = await NCApi.requestJsonPOST(context, 'authenticate', data);
    final responseJson = response.result;

    if (response.statusCode == 200) {
      saveCurrentLogin(responseJson);

      Navigator.of(context).pushReplacementNamed(Routes.Home);
      return LoginModel.fromJson(responseJson);
    } else {
      saveCurrentLogin(responseJson);
      showDialogSingleButton(context, "Unable to Login",
          "You may have supplied an invalid 'Username' / 'Password' combination. Please try again or contact your support representative.");
    }
  } catch (e) {
    print(e.toString());
    showDialogSingleButton(context, "Unable to Login",
          "You may have supplied an invalid 'Username' / 'Password' combination. Please try again or contact your support representative.");
  }
  return null;
}
