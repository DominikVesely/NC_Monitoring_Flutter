import 'package:app/common/functions/saveLogout.dart';
import 'package:app/config/routes.dart';
import 'package:flutter/material.dart';

void logout(BuildContext context) {
  saveLogout();  
  Navigator.of(context).pushNamedAndRemoveUntil(Routes.Login, (route) => false);
}