import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'package:app/common/utils/StringUtils.dart';

class NCApi {
  
  //static final Sring URL = 'https://monitoring.ncompany.cz/api/';
  static Url apiUrl() {
    return new Url("https://ncmonitoring20190122042034.azurewebsites.net/api/");
  }

  static Future<NCApiResult> requestGET(String path) async {
    final response = await http.get(apiUrl().append(path).toString());

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