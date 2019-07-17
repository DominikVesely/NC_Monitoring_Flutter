import 'package:app/common/utils/DateTimeFormatter.dart';
import 'package:app/model.json/RecordListModel.dart';
import 'package:flutter/material.dart';

class RecordsListWidget extends StatelessWidget {
  RecordsListWidget(this.records);

  final List<RecordListModel> records;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                        Text(DateTimeFormatter.shortDateTime(record.startDate)),
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
        });
  }
}
