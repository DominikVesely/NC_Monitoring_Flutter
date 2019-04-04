import 'package:uuid/uuid.dart';

class LoginModel {
  final String userName;
  final String token;
  final String email;
  final String userId;

  LoginModel(this.userName, this.token, this.email, this.userId);

  LoginModel.fromJson(Map<String, dynamic> json)
      : userName = json['Username'],
        token = json['Token'],
        email = json['Email'],
        userId = json['Id'];

  Map<String, dynamic> toJson() => {
        'Username': userName,
        'Token': token,
        'Email': email,
        'Id': userId,
      };
}
