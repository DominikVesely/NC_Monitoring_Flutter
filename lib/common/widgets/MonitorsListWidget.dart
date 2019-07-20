import 'package:app/common/apifunctions/requestMonitorListAPI.dart';
import 'package:app/common/widgets/MonitorListItem.dart';
import 'package:app/common/widgets/RefreshListWidget.dart';
import 'package:app/config/application.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class MonitorsListWidget extends StatefulWidget {

  @override
  _MonitorsListWidgetState createState() => _MonitorsListWidgetState();
}

class _MonitorsListWidgetState extends State<MonitorsListWidget> {  

  @override
  Widget build(BuildContext context) {
    return RefreshListWidget(
      getData: (context) => requestMonitorListAPI(context),
      listItem: (context, monitor, index) {
        return new FlatButton(
            onPressed: () {
              Application.router.navigateTo(
                  context, '/monitors/' + monitor.id,
                  transition: TransitionType.fadeIn);
            },
            child: MonitorListItem(monitor: monitor),
          );
      });
  }
}
