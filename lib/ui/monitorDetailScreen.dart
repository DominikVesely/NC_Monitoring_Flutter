import 'dart:async';

import 'package:app/common/apifunctions/requestMonitorDetailAPI.dart';
import 'package:app/common/apifunctions/requestRecordListAPI.dart';
import 'package:app/common/platform/platformScaffold.dart';
import 'package:app/common/widgets/MonitorDetailFormWidget.dart';
import 'package:app/common/widgets/RecordsListWidget.dart';
import 'package:app/common/widgets/ncFutureBuilder.dart';
import 'package:app/model.json/MonitorDetailModel.dart';
import 'package:app/model.json/RecordListModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MonitorDetailScreen extends StatefulWidget {
  MonitorDetailScreen({Key key, @required this.id}) : super(key: key);

  final String id;
  final String appBarTitle = 'Detail';
  final int topRecords = 30;

  @override
  _MonitorDetailScreenState createState() => _MonitorDetailScreenState();
}

class _MonitorDetailScreenState extends State<MonitorDetailScreen> {
  //Key _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  Future<MonitorDetailModel> _monitor;
  Future<List<RecordListModel>> _records;

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
    _monitor = requestMonitorDetailAPI(context, widget.id);
    return _monitor;
  }

  Future<Null> _recordsHandleRefresh() async {
    Completer<Null> completer = new Completer<Null>();

    setState(() {
      _getRecordsData(context).then((monitor) {
        completer.complete();
      });
    });

    completer.future;
  }

  Future<List<RecordListModel>> _getRecordsData(BuildContext context) async {
    if (_records == null) {
      _records = requestRecordListAPI(context, widget.id, widget.topRecords);
    }
    return _records;
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
              ncFutureBuilder<List<RecordListModel>>(
                  future: _getRecordsData(context),
                  callback: (records) {
                    return RefreshIndicator(
                      key: widget.key,
                      onRefresh: _recordsHandleRefresh,
                      child: RecordsListWidget(records),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
