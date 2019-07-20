import 'dart:async';

import 'package:app/common/widgets/ncFutureBuilder.dart';
import 'package:flutter/material.dart';

typedef FutureByContext<T> = Future<List<T>> Function(BuildContext context);
typedef IndexedItemBuilder<T> = Widget Function(BuildContext, T, int);

class RefreshListWidget<T> extends StatefulWidget {
  RefreshListWidget({Key key, @required this.getData, @required this.listItem, this.noDataText = "Data not found."}) : super(key: key);

  final FutureByContext<T> getData;
  final IndexedItemBuilder<T> listItem;
  final String noDataText;

  @override
  _RefreshListWidgetState createState() => _RefreshListWidgetState<T>(getData, listItem);
}

class _RefreshListWidgetState<T> extends State<RefreshListWidget> {
  _RefreshListWidgetState(this.getData, this.listItem)
  {
    //dataFuture = getData(context);
  }
  
  final IndexedItemBuilder<T> listItem;
  final FutureByContext<T> getData;

  Future<List<T>> _data;
  //Future<List<T>> dataFuture;  

  @override
  void initState() {
    _data = getData(context);
    super.initState();
  }

  Future _handleRefresh() async {
    Completer<void> completer = new Completer<Null>();

    setState(() {
      _data = getData(context);      
    });

    completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return ncFutureBuilder<List<T>>(
        future: _data,        
        callback: (data) {

          Widget child;

          if (data.length == 0) {
            child = SingleChildScrollView(              
                    physics: AlwaysScrollableScrollPhysics(),                    
                    child: Container(
                      padding: EdgeInsets.only(top: 100),
                      child: Center(
                        child: Text(widget.noDataText),
                      ),
                    )
                  );
          } else {
            child = ListView.builder(              
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    widget.listItem(context, data[index], index),
                    Divider(
                      height: 2,
                    )
                  ],
                );
              }
            );
          }

          return RefreshIndicator(
            key: widget.key,
            child: child,
            onRefresh: _handleRefresh,
          );
        });
  }
}
