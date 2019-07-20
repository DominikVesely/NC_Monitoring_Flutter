
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';

showDurationPicker(BuildContext context, {@required void Function(Duration) onConfirm, Duration initValue}) {
    
    int hours, minutes, seconds;

    if (initValue != null) {
      hours = initValue.inHours;
      minutes = initValue.inMinutes.remainder(60);
      seconds = initValue.inSeconds.remainder(60);
    }

    Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(begin: 0, end: 23, initValue: hours),
          NumberPickerColumn(begin: 0, end: 59, initValue: minutes),
          NumberPickerColumn(begin: 0, end: 59, initValue: seconds),
        ]),
        delimiter: [
          PickerDelimiter(child: Container(
            width: 30.0,
            alignment: Alignment.center,
            child: new Text(':'),
          )),          
          PickerDelimiter(
            column: 3,
            child: Container(
              width: 30.0,
              alignment: Alignment.center,
              child: new Text(':'),
          )),
        ],
        hideHeader: true,
        title: new Text("Please Select"),
        onConfirm: (Picker picker, List value) {
          final values = picker.getSelectedValues();
          onConfirm(Duration(hours: values[0], minutes: values[1], seconds: values[2]));
        }
    ).showDialog(context);
  }
