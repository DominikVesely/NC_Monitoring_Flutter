import 'package:app/ui/homeScreen.dart';
import 'package:app/ui/loginScreen.dart';
import 'package:fluro/fluro.dart';

final loginHandler = Handler(handlerFunc: (context, params) => LoginScreen());

final homeHandler = Handler(handlerFunc: (context, params) => HomeScreen());