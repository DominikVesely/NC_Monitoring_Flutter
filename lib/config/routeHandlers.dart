import 'package:app/ui/homeScreen.dart';
import 'package:app/ui/loginScreen.dart';
import 'package:app/ui/monitorDetailScreen.dart';
import 'package:app/ui/monitorListScreen.dart';
import 'package:fluro/fluro.dart';

final loginHandler = Handler(handlerFunc: (context, params) => LoginScreen());

final homeHandler = Handler(handlerFunc: (context, params) => HomeScreen());

final monitorListHandler = Handler(handlerFunc: (context, params) => MonitorListScreen());

final monitorDetailHandler = Handler(handlerFunc: (context, params) => MonitorDetailScreen(id: params["id"][0]));

//final monitorDetailHandler = Handler(handlerFunc: (context, params) => MonitorDetailScreen());