import 'dart:async';
import 'dart:convert';

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

    return await NCApi.requestModelFromResponse(context, 'authenticate', 
      method: HttpMethod.POST,
      requestDataType: HttpRequestDataType.Json,
      data: data,
      fromResponse: (response) {
        try {    
          if (response.statusCode == 200) {
            final responseJson = jsonDecode(response.body);
            saveCurrentLogin(responseJson);

            Navigator.of(context).pushReplacementNamed(Routes.Home);
            return LoginModel.fromJson(responseJson);

          } else {
            saveCurrentLogin(null);
            showDialogSingleButton(context, "Unable to Login",
                "You may have supplied an invalid 'Username' / 'Password' combination. Please try again or contact your support representative.");
          }
        } catch (e) {
          showDialogSingleButton(context, "Application error", "Something went wrong.");
        }

        return null;

      });
}
