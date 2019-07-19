import 'package:app/common/apifunctions/requestRecordListAPI.dart';
import 'package:app/common/utils/DateTimeFormatter.dart';
import 'package:app/common/widgets/RefreshListWidget.dart';
import 'package:app/config/application.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class RecordsListWidget extends StatelessWidget {
  RecordsListWidget(this.top, {this.monitorId});

  final String monitorId;
  final int top;

  @override
  Widget build(BuildContext context) {
    return RefreshListWidget(
      getData: (context) => requestRecordListAPI(context, monitorId, top),
      listItem: (context, record, index) {

        Widget base = Container(
          padding: EdgeInsets.fromLTRB(5, 5, 8, 8),
          child: Wrap(
            runSpacing: 10,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(DateTimeFormatter.shortDateTime(record.startDate)),
                  Text(DateTimeFormatter.shortDateTime(record.endDate)),
                ],
              ),
              Text(record.note),
            ],
          ),
        );

        if (monitorId == null) {
          return GestureDetector(
            onTap: () {
              Application.router.navigateTo(
                  context, '/monitors/' + record.monitorId,
                  transition: TransitionType.fadeIn);
            },
            child: base,
          );
        }

        return base;
      },
    );
  }
}
