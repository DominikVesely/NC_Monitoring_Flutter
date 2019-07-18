import 'package:app/common/apifunctions/requestLoginAPI.dart';
import 'package:app/common/platform/platformScaffold.dart';
import 'package:app/common/widgets/ncButton.dart';
import 'package:app/common/widgets/ncTextField.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ncTextField('Username', controller: _usernameController),
            ncTextField('Password',
                controller: _passwordController, 
                obscureText: true, 
                onSubmitted: (value) => requestLoginAPI(context, _usernameController.text, _passwordController.text)
            ),                
            ncButton('Login',
                onPressed: () => requestLoginAPI(context, _usernameController.text, _passwordController.text)),
          ],
        ),
      ),
    );
  }
}
