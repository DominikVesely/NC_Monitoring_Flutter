import 'dart:async';

import 'package:app/common/apifunctions/requestMonitorDetailAPI.dart';
import 'package:app/common/apifunctions/requestRecordListAPI.dart';
import 'package:app/common/apifunctions/updateMonitorDetailAPI.dart';
import 'package:app/common/platform/platformScaffold.dart';
import 'package:app/common/widgets/ncFutureBuilder.dart';
import 'package:app/model.json/MonitorDetailModel.dart';
import 'package:app/model.json/RecordListModel.dart';
import 'package:flutter/material.dart';
import 'package:app/common/utils/DateTimeFormatter.dart';

class MonitorDetailScreen extends StatefulWidget {
  MonitorDetailScreen({Key key, @required this.id}) : super(key: key);

  final String id;

  @override
  _MonitorDetailScreenState createState() => _MonitorDetailScreenState();
}

class _MonitorDetailScreenState extends State<MonitorDetailScreen> {
  //Key _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  MonitorDetailModel currentMonitor;

  Future<MonitorDetailModel> _monitor;
  Future<List<RecordListModel>> _records;
  String appBarTitle = 'Detail';
  final int topRecords = 30;

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
      _records = requestRecordListAPI(context, widget.id, topRecords);
    }
    return _records;
  }

  final Map<String, TextEditingController> controllers = {
    'Name': TextEditingController(),
    'Url': TextEditingController(),
  };

  void updateMonitorValue<T>(String name, T value) {
    updateMonitorDetailAPI(context, widget.id, {
      '$name': value,
    }).then((model) {      
      updateState(model);
    });
  }

  void updateState(MonitorDetailModel model) {
    setState(() {        
        currentMonitor.name = model.name;
        currentMonitor.statusName = model.statusName;        
        currentMonitor.verificationValue = model.verificationValue;        
        currentMonitor.timeout = model.timeout;        
        currentMonitor.scenarioId = model.scenarioId;        
      });
  }

  TextField createTextField(String name, String label, String value) {
    var controller = controllers[name];

    if (controller.text.isEmpty) {
      controller.text = value;
    }

    return TextField(
      decoration: InputDecoration(labelText: label),
      onSubmitted: (text) {
        //showDialogSingleButton(context, 'title', 'Yes man');
        updateMonitorValue(name, text);
      },
      controller: controller,
    );
  }

  void getScenarios() {

  }

  List<DropdownMenuItem<int>> getItems<T>() {
    return List.generate(5, (int index) {
      return DropdownMenuItem<int>(
        value: index,
        child: Container(
          child: Text('Item#$index'),
          width: 120,
        ),
      );
    });
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
            title: Text(appBarTitle),
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
                    currentMonitor = monitor;

                    return RefreshIndicator(
                      key: widget.key,
                      onRefresh: _detailHandleRefresh,
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Container(
                          child: Form(
                              child: Column(
                            children: <Widget>[
                              createTextField('Name', 'Name', currentMonitor.name),
                              Text(currentMonitor.scenarioName),
                              DropdownButtonFormField<int>(
                                value: currentMonitor.scenarioId,
                                items: getItems(),
                                onChanged: (int newValue) {

                                  updateMonitorValue('ScenarioId', newValue);
                                  // setState(() {
                                  //  currentMonitor.scenarioId = newValue; 
                                  // });
                                },
                              ),                              
                              Text(currentMonitor.statusName),
                              createTextField('Url', 'Url', currentMonitor.url),
                              Text(currentMonitor.timeout),
                              Text(currentMonitor.verificationTypeName),
                              Text(currentMonitor.verificationValue),
                            ],
                          )),
                        ),
                      ),
                    );
                  }),
              ncFutureBuilder<List<RecordListModel>>(
                  future: _getRecordsData(context),
                  callback: (record) {
                    return getRecordsListView(record);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget getRecordsListView(List<RecordListModel> records) {
    return RefreshIndicator(
      key: widget.key,
      onRefresh: _recordsHandleRefresh,
      child: ListView.builder(
          itemCount: records.length,
          itemBuilder: (BuildContext context, int index) {
            var record = records[index];

            return Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(5, 5, 8, 8),
                  child: Wrap(
                    runSpacing: 10,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(DateTimeFormatter.shortDateTime(
                              record.startDate)),
                          Text(DateTimeFormatter.shortDateTime(record.endDate)),
                        ],
                      ),
                      Text(record.note),
                    ],
                  ),
                ),
                Divider(
                  height: 2.0,
                )
              ],
            );
          }),
    );
  }
}
