import 'package:app/common/apifunctions/requestLoginAPI.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void onSubmit() {    
    if (_formKey.currentState.validate()) {
      String username = _usernameController.text;
      String password = _passwordController.text;      
      requestLoginAPI(context, username, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              color: Colors.black
                // image: new DecorationImage(
                //     fit: BoxFit.cover,
                //     image: new NetworkImage(
                //         'https://i.pinimg.com/originals/c2/47/e9/c247e913a0214313045a8a5c39f8522b.jpg')
                // )
            ),
          ),
          Center(
            child: Form(
              key: _formKey,                            
              child: SingleChildScrollView(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 58.0,
                      child: Image.asset('images/splash.png'),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: _usernameController,
                      validator: (value) {
                        if (value == null || value.trim() == '') {
                          return 'Username is required.';
                        }
                        return null;
                      },                    
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.black45,
                          ),
                          hintStyle: TextStyle(color: Colors.black45),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Username'),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(            
                      controller: _passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value == '') {
                          return 'Password is required.';
                        }
                        return null;
                      },                      
                      onFieldSubmitted: (value) {
                        onSubmit();
                      },
                      decoration: InputDecoration(                        
                          filled: true,
                          prefixIcon: Icon(Icons.lock, color: Colors.black45),
                          hintStyle: TextStyle(color: Colors.black45),
                          fillColor: Colors.white,
                          hintText: 'Password'),
                    ), 
                    SizedBox(
                      height: 10.0,
                    ),                  
                    RaisedButton(
                      onPressed: () => onSubmit(),
                      child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text('LOGIN')),
                      color: Colors.blue[400],
                      textColor: Colors.white,
                    ),                                    
                    SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Divider(
                            color: Colors.white,
                            height: 8.0,
                          ),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          'Copyright © 2019',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.white,
                            height: 8.0,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        // TODO Social Icons
                      ],
                    ),
                  ],
                ),
              ),
            )
          ),
        ],
      ),
    );
  }
}
