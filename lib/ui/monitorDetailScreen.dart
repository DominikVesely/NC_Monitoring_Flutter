import 'dart:async';

import 'package:app/common/apifunctions/requestMonitorDetailAPI.dart';
import 'package:app/common/platform/platformScaffold.dart';
import 'package:app/common/widgets/ncFutureBuilder.dart';
import 'package:app/model.json/MonitorDetailModel.dart';
import 'package:flutter/material.dart';

class MonitorDetailScreen extends StatefulWidget {
  MonitorDetailScreen({Key key, @required this.id}) : super(key: key);

  final String id;

  @override
  _MonitorDetailScreenState createState() => _MonitorDetailScreenState();
}

class _MonitorDetailScreenState extends State<MonitorDetailScreen> {
  //Key _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  Future<MonitorDetailModel> _monitor;

  Future<Null> _handleRefresh() async {
    Completer<Null> completer = new Completer<Null>();

    setState(() {
      _getData(context).then((_) {
        completer.complete();
      });
    });

    completer.future;
  }

  Future<MonitorDetailModel> _getData(BuildContext context) async {
    _monitor = requestMonitorDetailAPI(context, widget.id);
    return _monitor;
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        body: ncFutureBuilder(
            future: _getData(context),
            callback: (monitor) {
              return RefreshIndicator(
                key: widget.key,
                child: Column(
                  children: <Widget>[
                    new Text(monitor.name),
                    new Text(monitor.scenarioName),
                    new Text(monitor.statusName),
                    new Text(monitor.url),
                    new Text(monitor.timeout),
                    new Text(monitor.verificationTypeName),
                    new Text(monitor.verificationValue),
                  ],
                ),
                onRefresh: _handleRefresh,
              );
            }));
  }
}
