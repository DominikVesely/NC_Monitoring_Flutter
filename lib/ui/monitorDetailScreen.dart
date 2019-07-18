import 'dart:async';

import 'package:app/common/apifunctions/requestMonitorDetailAPI.dart';
import 'package:app/common/platform/platformScaffold.dart';
import 'package:app/common/widgets/MonitorDetailFormWidget.dart';
import 'package:app/common/widgets/RecordsListWidget.dart';
import 'package:app/common/widgets/ncFutureBuilder.dart';
import 'package:app/model.json/MonitorDetailModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MonitorDetailScreen extends StatefulWidget {
  MonitorDetailScreen({Key key, @required this.monitorId}) : super(key: key);

  final String monitorId;
  final String appBarTitle = 'Monitor - detail';
  final int topRecords = 30;

  @override
  _MonitorDetailScreenState createState() => _MonitorDetailScreenState(monitorId);
}

class _MonitorDetailScreenState extends State<MonitorDetailScreen> {
  _MonitorDetailScreenState(this.monitorId);
  //Key _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  final String monitorId;
  Future<MonitorDetailModel> _monitor;  

  @override
  void initState() {
    _monitor = _getDetailData(context);
    //_records = _getRecordsData(context);
    super.initState();
  }

  Future<Null> _detailHandleRefresh() async {
    Completer<Null> completer = new Completer<Null>();

    setState(() {
      _getDetailData(context).then((monitor) {
        completer.complete();
      });
    });

    completer.future;
  }

  Future<MonitorDetailModel> _getDetailData(BuildContext context) async {
    _monitor = requestMonitorDetailAPI(context, monitorId);
    return _monitor;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: PlatformScaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            ),
            title: Text(widget.appBarTitle),
            bottom: TabBar(
              tabs: [
                Tab(text: 'Detail'),
                Tab(text: 'Records'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ncFutureBuilder<MonitorDetailModel>(
                  future: _monitor,
                  callback: (monitor) {
                    return RefreshIndicator(
                      key: widget.key,
                      onRefresh: _detailHandleRefresh,
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: MonitorDetailFormWidget(monitor: monitor),
                        ),
                      ),
                    );
                  }),
              RecordsListWidget(30, monitorId: monitorId)
            ],
          ),
        ),
      ),
    );
  }
}
