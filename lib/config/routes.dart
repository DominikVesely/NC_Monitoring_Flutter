import 'package:app/config/routeHandlers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class Routes
{
  static const String Home = MonitorList;
  static const String Login = "/login";

  static const String MonitorList = "/monitors";
  static const String MonitorDetail = "/monitors/:id";

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });
    
    router.define(Routes.Login, handler: loginHandler);

    //router.define(Routes.Home, handler: homeHandler);

    router.define(Routes.MonitorList, handler: monitorListHandler);
    router.define(Routes.MonitorDetail, handler: monitorDetailHandler);
  }
}