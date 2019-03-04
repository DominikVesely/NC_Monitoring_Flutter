import 'package:app/config/application.dart';
import 'package:app/config/routes.dart';
import 'package:app/ui/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  MyApp() {
    final router = Router();
    Routes.configureRoutes(router);    
    Application.router = router;
  }
  
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Splash and Token Authentication",
      onGenerateRoute: Application.router.generator,
      home: SplashScreen(),
    );
  }
}