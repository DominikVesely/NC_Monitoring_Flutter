import 'package:app/common/apifunctions/requestLoginAPI.dart';
import 'package:app/common/platform/platformScaffold.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future testFuture;

  @override
  initState() {
    testFuture = null;
    super.initState();    
  }

  void onSubmit() {        
    if (_formKey.currentState.validate()) {
      String username = _usernameController.text;
      String password = _passwordController.text;      

      setState(() {    
        testFuture = requestLoginAPI(context, username, password);
      });
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              color: Colors.black                
            ),
          ),
          loginForm(),
          FutureBuilder(
            future: testFuture,
            builder: (BuildContext context, AsyncSnapshot snapshot) {              
              switch (snapshot.connectionState) {                
                case ConnectionState.waiting:
                  return Container(
                    decoration: new BoxDecoration(
                      color: Colors.white.withOpacity(0.8)
                    ),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );

                default:
                  return SizedBox.shrink();
              }
            },
          )
        ],
      ),
    );
  }

  Widget loginForm() {
    return Center(
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
          );
  }
}
