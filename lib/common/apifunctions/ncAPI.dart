import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app/common/functions/getToken.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:app/common/utils/StringUtils.dart';
import 'package:http/http.dart';

import 'package:app/config/routes.dart';
import 'package:app/common/functions/saveLogout.dart';

class NCApi {
  //static final Sring URL = 'https://monitoring.ncompany.cz/api/';
  static Url apiUrl() {
    //10.0.2.2
    return new Url("https://monitoring.ncompany.cz/api/");
    //return new Url("https://10.0.2.2:64966/api/");
  }

  static Future<String> getAuthorizationHeader() async {
    return 'Bearer ' + (await getToken());
  }

  static Future<NCApiResult> requestGET(
      BuildContext context, String path) async {
    final response = await http.get(apiUrl().append(path).toString(), headers: {
      HttpHeaders.authorizationHeader: await getAuthorizationHeader(),
    });

    ifUnauthorizedThanRouteToHome(context, response);

    return NCApiResult(response);
  }

  static Future<NCApiResult> requestPUT(BuildContext context, String path,
      String id, Map<String, dynamic> data) async {
    final body = {
      'key': id,
      'values': json.encode(data),
    };
    final response =
        await http.put(apiUrl().append(path).toString(), body: body, headers: {
      "Accept": "application/x-www-form-urlencoded",
      "Content-type": "application/x-www-form-urlencoded",
      HttpHeaders.authorizationHeader: await getAuthorizationHeader(),
    });

    ifUnauthorizedThanRouteToHome(context, response);

    return NCApiResult(response);
  }

  static Future<NCApiResult> requestPOST(
      BuildContext context, String path, Map<String, dynamic> data) async {
    final response = await http.post(apiUrl().append(path).toString(),
        body: json.encode(data),
        headers: {
          "Accept": "application/x-www-form-urlencoded",
          "Content-type": "application/x-www-form-urlencoded",
          HttpHeaders.authorizationHeader: await getAuthorizationHeader(),
        });

    ifUnauthorizedThanRouteToHome(context, response);

    return NCApiResult(response);
  }

  static Future<NCApiResult> requestJsonPOST(
      BuildContext context, String path, Map<String, dynamic> data) async {
    final response = await http.post(apiUrl().append(path).toString(),
        body: json.encode(data),
        headers: {
          "Accept": "application/json",
          "Content-type": "application/json",
          HttpHeaders.authorizationHeader: await getAuthorizationHeader(),
        });

    ifUnauthorizedThanRouteToHome(context, response);

    return NCApiResult(response);
  }

  static bool ifUnauthorizedThanRouteToHome(
      BuildContext context, Response response) {
    // if (response.statusCode == 401) {
    //   saveLogout();
    //   Navigator.of(context).pushReplacementNamed(Routes.Home);
    //   return true;
    // }
    return false;
  }
}

class Url {
  String _url;

  Url(String root) {
    append(root);
  }

  Url append(String part) {
    part = StringUtils.Trim(part, [' ', '/']);

    if (_url == null || _url.length == 0) {
      _url = part;
    } else {
      _url += '/' + part;
    }

    return this;
  }

  @override
  String toString() {
    return _url;
  }
}

class NCApiResult {
  final int statusCode;
  final dynamic result;

  NCApiResult._(this.statusCode, this.result);

  factory NCApiResult(Response response) {
    return NCApiResult._(response.statusCode, jsonDecode(response.body));
  }
}
