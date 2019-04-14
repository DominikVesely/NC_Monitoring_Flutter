import 'dart:async';

import 'package:app/common/platform/platformScaffold.dart';
import 'package:app/common/widgets/ncFutureBuilder.dart';
import 'package:app/config/application.dart';
import 'package:app/config/routes.dart';
import 'package:app/model.json/MonitorListModel.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:app/common/apifunctions/requestMonitorListAPI.dart';

class MonitorListScreen extends StatefulWidget {
  @override
  _MonitorListScreenState createState() => _MonitorListScreenState();
}

class _MonitorListScreenState extends State<MonitorListScreen> {
  Future<List<MonitorListModel>> _list;
  Key _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

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
      key: _refreshIndicatorKey,
      child: ListView.builder(
          itemCount: monitors.length,
          itemBuilder: (BuildContext context, int index) {
            var monitor = monitors[index];

            return new FlatButton(
              onPressed: () {
                print(monitor.id);
                Application.router.navigateTo(context, '/monitors/'+monitor.id, transition: TransitionType.fadeIn);
              },
              child: Column(
                children: <Widget>[
                  new ListTile(
                    title: new Text(monitor.name),
                  ),
                  new Divider(
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
        body: ncFutureBuilder(
            future: _getData(context),
            callback: (data) {
              return getListView(data);
            }));
  }
}
