import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app/common/functions/getToken.dart';
import 'package:app/common/functions/logout.dart';
import 'package:app/common/functions/showDialogSingleButton.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:app/common/utils/StringUtils.dart';
import 'package:http/http.dart';

enum HttpMethod { GET, POST, PUT, DELETE }
enum HttpRequestDataType { Form, Json }

class NCApi {
  
  static Url apiUrl() {
    //10.0.2.2
    return new Url("https://monitoring.ncompany.cz/api/");
    //return new Url("https://10.0.2.2:64966/api/");
  }

  static Future<String> getAuthorizationHeader() async {
    return 'Bearer ' + (await getToken());
  }

  static Future<Map<String, String>> getHeaders(HttpRequestDataType requestDataType) async {
    var headers = {      
      HttpHeaders.authorizationHeader: await getAuthorizationHeader()
    };

    switch (requestDataType) {      
      case HttpRequestDataType.Json:
        headers["Accept"] = "application/json";
        headers["Content-type"] = "application/json";
        break;

      default:
        headers["Accept"] = "application/x-www-form-urlencoded";
        headers["Content-type"] = "application/x-www-form-urlencoded";
    }

    return headers;
  }


  static Future<T> requestModelPUT<T>(BuildContext context, String path, {
    @required String key,
    @required T Function(Map) fromJson,
    Map<String, dynamic> data}) async {
      
      return await requestModelFromJson(context, path, fromJson: fromJson,
        method: HttpMethod.PUT,
        requestDataType: HttpRequestDataType.Form,
        data: {
          'key': key,
          'values': json.encode(data),
        }); 
  }

  static Future<List<T>> requestModelFromJsonList<T>(BuildContext context, String path, {@required T Function(Map) fromJson,
      HttpRequestDataType requestDataType, HttpMethod method, Map<String, dynamic> data}) async {

        return _requestModel(context, path, requestDataType, method, data, null, (response) {
          if (validateResponse(context, response)) {
            final jsonResponse = jsonDecode(response.body);
            Iterable list = jsonResponse;

            return list.map((model) => fromJson(model)).toList();
          }

          return [];
        });
  }

  static Future<T> requestModelFromJson<T>(BuildContext context, String path, {@required T Function(Map) fromJson,
      HttpRequestDataType requestDataType, HttpMethod method, Map<String, dynamic> data}) async {

        return _requestModel(context, path, requestDataType, method, data, fromJson, null);
  }

  static Future<T> requestModelFromResponse<T>(BuildContext context, String path, { @required T Function(Response) fromResponse,
      HttpRequestDataType requestDataType, HttpMethod method, Map<String, dynamic> data}) async {

        return _requestModel(context, path, requestDataType, method, data, null, fromResponse);
  }

  static Future<T> _requestModel<T>(BuildContext context, String path, 
    HttpRequestDataType requestDataType, HttpMethod method, Map<String, dynamic> data,
    T Function(Map) fromJson, 
    T Function(Response) fromResponse) async {

        if (fromJson == null && fromResponse == null) {
          throw new Exception("One parameter of 'fromJson' or 'onResponse' or 'fromJsonList' can not be null.");
        }

    try {
      final url = apiUrl().append(path).toString();      
      final headers = await getHeaders(requestDataType);
      
      Response response;

      dynamic body;

      if (data != null) {

        switch (requestDataType) {          
            case HttpRequestDataType.Json:
              body = json.encode(data);
              break;
            default: 
              body = data;
              break;
        }
      }

      switch (method) {
        case HttpMethod.POST:
          response = await http.post(url, headers: headers, body: body);
          break;
        case HttpMethod.PUT:
          response = await http.put(url, headers: headers, body: body);
          break;
        case HttpMethod.DELETE:
          response = await http.delete(url, headers: headers);
          break;
          
        default:
          response = await http.get(url, headers: headers);
          break;
      }

      if (fromResponse != null) {
        return fromResponse(response);
      }

      if (validateResponse(context, response)) {
        final jsonResponse = jsonDecode(response.body);
        return fromJson(jsonResponse);
      }

    } catch (e) {      
      showDialogSingleButton(context, "Application error", "Something went wrong.");
    }

    // if (T is List<dynamic>) { // nefunguje
    //   return [] as T;
    // }

    return null;
}

  static bool validateResponse(BuildContext context, Response response) {
    final statusCode = response.statusCode;

      if (statusCode <= 299) {
        if (response.body != null && response.body.trim() != '') {
          // success
          return true;          
        }
      } else if (statusCode == 401) {
        // Unauthenticated
        showDialogSingleButton(context, "Unauthenticated", "You have been logged out due to inactivity",
          buttonLabel: 'Login',
          onPressed: () => logout(context));
      } else if (statusCode == 403) { // 403 vraci azure pokud se zastavi Web service
        showDialogSingleButton(context, "API problem", "Server API was stopped.");
      } else if (statusCode <= 499){
        showDialogSingleButton(context, "Bad request ($statusCode)", "Something went wrong.");
      } else {
        showDialogSingleButton(context, "Server problem ($statusCode)", "Server is unavailable.");
      }

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
  // final int statusCode;
  // final dynamic result;

  // NCApiResult._(this.statusCode, this.result);

  // factory NCApiResult(Response response) {
  //   return NCApiResult._(response.statusCode, jsonDecode(response.body));
  // }
}
