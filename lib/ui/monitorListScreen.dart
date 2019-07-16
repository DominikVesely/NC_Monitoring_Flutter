import 'dart:async';

import 'package:app/common/controls/monitorListItem.dart';
import 'package:app/common/functions/saveLogout.dart';
import 'package:app/common/platform/platformScaffold.dart';
import 'package:app/common/widgets/ncFutureBuilder.dart';
import 'package:app/config/application.dart';
import 'package:app/config/routes.dart';
import 'package:app/model.json/MonitorListModel.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:app/common/apifunctions/requestMonitorListAPI.dart';

class MonitorListScreen extends StatefulWidget {
  @override
  _MonitorListScreenState createState() => _MonitorListScreenState();
}

class _MonitorListScreenState extends State<MonitorListScreen> {
  Future<List<MonitorListModel>> _list;
  //Key _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  String textValue = 'TextValue';

  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
    firebaseMessaging.configure(onLaunch: (Map<String, dynamic> msg) {
      print("onLaunch called");
    }, onResume: (Map<String, dynamic> msg) {
      print("onResume called");
    }, onMessage: (Map<String, dynamic> msg) {
      print("onMessage called");
    });

    firebaseMessaging
        .requestNotificationPermissions(const IosNotificationSettings(
      sound: true,
      alert: true,
      badge: true,
    ));

    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print('IOS Setting Registered.');
    });

    firebaseMessaging.getToken().then((token) {
      //update(token);
    });
  }

  // update(String token) {
  //   print(token);
  //   textValue = token;
  //   setState(() {});
  // }

  Future<List<MonitorListModel>> _getData(BuildContext context) async {
    _list = requestMonitorListAPI(context);
    return _list;
  }

  Future<Null> _handleRefresh() async {
    Completer<Null> completer = new Completer<Null>();

    // Future.delayed(new Duration(seconds: 2)).then((_){
    //   setState(() {
    //     _getData(context).then((_){
    //       completer.complete();
    //     });
    //   });
    // });

    setState(() {
      _getData(context).then((_) {
        completer.complete();
      });
    });

    completer.future;
  }

  Widget getListView(List<MonitorListModel> monitors) {
    return RefreshIndicator(
      key: widget.key,
      child: ListView.builder(
          itemCount: monitors.length,
          itemBuilder: (BuildContext context, int index) {
            var monitor = monitors[index];

            return new FlatButton(
              onPressed: () {
                print(monitor.id);
                Application.router.navigateTo(
                    context, '/monitors/' + monitor.id,
                    transition: TransitionType.fadeIn);
              },
              child: Column(
                children: <Widget>[
                  MonitorListItem(monitor: monitor),
                  Divider(
                    height: 2.0,
                  )
                ],
              ),
            );
          }),
      onRefresh: _handleRefresh,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        appBar: AppBar(
          title: Text('Monitor list'),
        ),
        body: Column(          
          children: <Widget>[
            Flexible(
              child: ncFutureBuilder<List<MonitorListModel>>(
                  future: _getData(context),
                  callback: (data) {
                    return getListView(data);
                  }),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: FlatButton(
                //color: Color(0x2196f3),
                color: Colors.blue[400],                
                child: Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.white,
                  )
                  ),
                onPressed: () {
                  saveLogout();
                  Application.router.navigateTo(context, Routes.Login);
                })
            )
          ],
        ));
  }
}
