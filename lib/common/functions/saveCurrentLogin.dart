import 'package:app/model.json/LoginModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

saveCurrentLogin(Map responseJson) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  var user;
  if ((responseJson != null && responseJson.isNotEmpty)) {
    user = LoginModel.fromJson(responseJson).userName;
  } else {
    user = "";
  }
  
  String token = (responseJson != null && responseJson.isNotEmpty) ? LoginModel.fromJson(responseJson).token : "";
  String email = (responseJson != null && responseJson.isNotEmpty) ? LoginModel.fromJson(responseJson).email : "";
  String pk = (responseJson != null && responseJson.isNotEmpty) ? LoginModel.fromJson(responseJson).userId : "";

  await preferences.setString('LastUser', (user != null && user.length > 0) ? user : "");
  await preferences.setString('LastToken', (token != null && token.length > 0) ? token : "");
  await preferences.setString('LastEmail', (email != null && email.length > 0) ? email : "");
  await preferences.setString('LastUserId', (pk != null && pk.length > 0) ? pk : "");

}