import 'package:app/common/apifunctions/switchMonitorEnableAPI.dart';
import 'package:app/common/functions/showSnackBar.dart';
import 'package:app/model.json/MonitorListModel.dart';
import 'package:flutter/material.dart';

class MonitorListItem extends StatefulWidget {
  MonitorListItem({Key key, @required this.monitor}) : super(key: key);

  final MonitorListModel monitor;

  @override
  _MonitorListItemState createState() {
    var state = _MonitorListItemState();

    state.monitor = monitor;

    return state;
  }
}

class _MonitorListItemState extends State<MonitorListItem> {
  MonitorListModel monitor;

  @override
  Widget build(BuildContext context) {
    Color textColor;
    switch (monitor.statusId) {
      case 1: // InActive
        textColor = Colors.grey;        
        break;
      case 2: // OK
        textColor = Colors.green;
        break;      
      case 3: // Error
        textColor = Colors.red;
        break;
      default:
        textColor = Colors.black;
        break;
    }

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Text(
              monitor.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: textColor,
              ),
            ),
          ),
          Switch(
            value: monitor.enabled,
            onChanged: (value) {
              switchMonitorEnableAPI(context, monitor.id, value).then((x) {
                setState(() {
                  monitor = x;
                  final status = (x.enabled ? 'enabled' : 'disabled');
                  showSnackBar(context,
                      text: 'Monitor was $status', type: SnackBarType.Success);
                });
              });
            },
          )
        ],
      ),
    );
  }
}
