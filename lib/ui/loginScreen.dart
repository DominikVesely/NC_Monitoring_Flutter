import 'package:app/common/platform/platformScaffold.dart';
import 'package:app/common/widgets/ncTextField.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Expanded(
        child: Center(
          child: Column(
            children: <Widget>[
              buildTextField(hintText: 'Username'),
              buildTextField(hintText: 'Password', obscureText: true),
            ],
          ),
        ),
      ),
    );
  }
}
