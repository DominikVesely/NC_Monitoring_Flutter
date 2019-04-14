import 'dart:async';

import 'package:app/common/platform/platformScaffold.dart';
import 'package:app/model.json/MonitorListModel.dart';
import 'package:flutter/material.dart';
import 'package:app/common/apifunctions/requestMonitorsAPI.dart';

class MonitorListScreen extends StatefulWidget {
  @override
  _MonitorListScreenState createState() => _MonitorListScreenState();
}

class _MonitorListScreenState extends State<MonitorListScreen> {
  
  Future<List<MonitorListModel>> _list;
  Key _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  Future<List<MonitorListModel>> _getData(BuildContext context) async {
    _list = requestMonitorsAPI(context);
    return _list;
  }

  Widget getListView(List<MonitorListModel> monitors) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      child: ListView.builder(
        itemCount: monitors.length,
        itemBuilder: (BuildContext context, int index) {
          return new Column(
            children: <Widget>[
              new ListTile(
                title: new Text(monitors[index].name),
              ),
              new Divider(
                height: 2.0,
              )
            ],
          );
        }),
        onRefresh: () {
          setState(() {
            _getData(context); 
          });
          return _list;
        },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        body: FutureBuilder(
              future: _getData(context),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return new Text("loading....");
                  default:
                    if (snapshot.hasError)
                      return new Text('Error: ${snapshot.error}');
                    else
                      return getListView(snapshot.data);
                }
              },
      )
    );
  }
}