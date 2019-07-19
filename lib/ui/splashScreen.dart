import 'dart:async';

import 'package:app/common/functions/getToken.dart';
import 'package:app/common/platform/platformScaffold.dart';
import 'package:app/config/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final String splashLogo = 'images/splash.png';
  final int splashDuration = 2;

  countDownTime() async {    

    return Timer(Duration(seconds: splashDuration), () async {
      SystemChannels.textInput.invokeMethod(
          'TextInput.hide'); // donuti skryti klavesnice, kdyz se swapne z jine appky          

      try
      {
        var token = await getToken();   

        if (token != null && token.isNotEmpty)
        {          
          Navigator.of(context).pushReplacementNamed(Routes.Login);
          Navigator.of(context).pushReplacementNamed(Routes.MonitorList);
          return;
        }
      }
      catch(ex) {}

      Navigator.of(context).pushReplacementNamed(Routes.Login);
    });
  }

  @override
  void initState() {
    super.initState();
    countDownTime();
  }

  @override
  Widget build(BuildContext context) {
    final drawer = Drawer();

    return PlatformScaffold(
        drawer: drawer,
        body: Container(
            decoration: BoxDecoration(color: Colors.black),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(color: Colors.black),
                      //alignment: FractionalOffset(0.5, 0.3),
                      child:
                          //Text("TestApp", style: TextStyle(fontSize: 40.0, color: Colors.white),),
                          Image.asset(splashLogo)),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
                  child: Text(
                    "Copyright © 2019 Neuman Company s.r.o.",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )));
  }
}
