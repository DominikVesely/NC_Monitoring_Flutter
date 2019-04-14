import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app/common/functions/getToken.dart';
import 'package:http/http.dart' as http;

import 'package:app/common/utils/StringUtils.dart';
import 'package:http/http.dart';

class NCApi {
  
  //static final Sring URL = 'https://monitoring.ncompany.cz/api/';
  static Url apiUrl() {
    //10.0.2.2
    return new Url("https://monitoring.ncompany.cz/api/");
    //return new Url("https://10.0.2.2:64966/api/");
  }

  static Future<NCApiResult> requestGET(String path) async {
    final response = await http.get(
        apiUrl().append(path).toString(), 
        headers: {HttpHeaders.authorizationHeader: 'Bearer ' + (await getToken())}
      );

    return NCApiResult(response);
  }

  static Future<NCApiResult> requestPOST(String path, Map<String, dynamic> data) async {

    final response = await http.post(
      apiUrl().append(path).toString(),
      body: json.encode(data),
      headers: {
        "Accept": "application/json",
        "Content-type": "application/json"
      }
    );

    return NCApiResult(response);    
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