import 'package:app/common/platform/platformScaffold.dart';
import 'package:app/common/widgets/ncButton.dart';
import 'package:app/common/widgets/ncTextField.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {

  final onLogin = () => {
    
  };

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Container(        
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ncTextField('Username'),
              ncTextField('Password', obscureText: true),
              ncButton('Login', onPressed: onLogin),
            ],
          ),
      ),
    );
  }
}
