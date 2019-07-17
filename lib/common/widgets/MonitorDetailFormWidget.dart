import 'package:app/common/apifunctions/requestMonitorMethodListAPI.dart';
import 'package:app/common/apifunctions/requestMonitorVerificationListAPI.dart';
import 'package:app/common/apifunctions/requestScenarioListAPI.dart';
import 'package:app/common/apifunctions/updateMonitorDetailAPI.dart';
import 'package:app/common/utils/DurationFormatter.dart';
import 'package:app/model.json/MonitorDetailModel.dart';
import 'package:app/model.json/MonitorMethodModel.dart';
import 'package:app/model.json/MonitorVerificationModel.dart';
import 'package:app/model.json/ScenarioListModel.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class MonitorDetailFormWidget extends StatefulWidget {

  MonitorDetailFormWidget({Key key, @required this.monitor}) : super(key: key);

  final MonitorDetailModel monitor;

  @override
  _MonitorDetailFormWidgetState createState() => _MonitorDetailFormWidgetState(monitor);
}

class _MonitorDetailFormWidgetState extends State<MonitorDetailFormWidget> {

  MonitorDetailModel monitor;

  List<ScenarioListModel> scenarioList = [];
  List<MonitorMethodModel> methodList = [];
  List<MonitorVerificationModel> verificationList = [];

  _MonitorDetailFormWidgetState(this.monitor)
  {
    requestScenarioListAPI(context).then((x) {      
      setState(() {
        scenarioList = x;
      });
    });
    requestMonitorMethodListAPI(context).then((x) {
      setState(() {
        methodList = x;
      });
    });

    requestMonitorVerificationListAPI(context).then((x) {
      setState(() {
        verificationList = x;
      });
    });
  }

  final Map<String, TextEditingController> controllers = {
    'Name': TextEditingController(),
    'Url': TextEditingController(),
    'VerificationValue': TextEditingController(),
    'Timeout': TextEditingController(),
  };

  void updateMonitorValue<T>(String name, T value) {
    updateMonitorDetailAPI(context, monitor.id, {
      '$name': value,
    }).then((model) {
      updateState(model);
    });
  }

  void updateState(MonitorDetailModel model) {
    bool updateMonitor = model != null;
    if (model == null) {
      model = monitor;
    }

    controllers['Name'].text = model.name;
    controllers['Url'].text = model.url;
    controllers['VerificationValue'].text = model.verificationValue;
    controllers['Timeout'].text = DurationFormatter.ToTimeSpan(model.timeout);

  if (!updateMonitor) {
    return;
  }

    setState(() {      
      monitor.name = model.name;
      monitor.timeout = model.timeout;
      monitor.verificationValue = model.verificationValue;            

      monitor.statusName = model.statusName;
      monitor.enabled = model.enabled;      
      monitor.scenarioId = model.scenarioId;
      monitor.verificationTypeId = model.verificationTypeId;      
    });
  }

  TextFormField createTextField(String name, String label, String value, {String Function(String) validator}) {
    var controller = controllers[name];

    if (controller.text.isEmpty) {
      controller.text = value;
    }

    return TextFormField(
      decoration: InputDecoration(labelText: label),
      validator: validator,
      keyboardType: TextInputType.url,
      onFieldSubmitted: (text) {        
        updateMonitorValue(name, text);        
      },
      controller: controller,
    );
  }

  DropdownButtonFormField<TResult> createDropDownButtom<T, TResult>(List<T> items, TResult Function(T) value, String Function(T) text, String modelPropertyName, {
    TResult initValue,
    String label    
  }) {
    return DropdownButtonFormField<TResult>(
            decoration: InputDecoration(
              labelText: label,
            ),
            value: initValue,
            items: getItems<T, TResult>(items, value, text),
            onChanged: (TResult newValue) {
              updateMonitorValue(modelPropertyName, newValue);
            },
      );
  }

  List<DropdownMenuItem<TResult>> getItems<T, TResult>(List<T> items, TResult Function(T) value, String Function(T) text) {
    return items.map((itm) => DropdownMenuItem(
        value: value(itm),
        child: Container(
          child: Text(text(itm)),
          //width: 120,
        ),
    )).toList();
  }

  @override
  Widget build(BuildContext context) {   

    return Container(      
      child: Form(
        key: widget.key,
        autovalidate: true,
          child: Column(
        children: <Widget>[      

          SwitchListTile(            
            title: const Text('Enabled:'),
            value: monitor.enabled,
            onChanged: (value) {
              updateMonitorValue("Enabled", value);
            },                
          ),  

          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,              
              children: <Widget>[
                Text('Status:'),
                Container(
                  padding: EdgeInsets.only(right: 15),
                  child: Text(monitor.statusName),
                ),
              ],
            ),            
          ),

          createTextField('Name', 'Name', monitor.name),          
          
          createDropDownButtom<ScenarioListModel, int>(scenarioList, (x) => x.id, (x) => x.name, "ScenarioId",
              initValue: monitor.scenarioId, 
              label: "Scenario"),  

          createDropDownButtom<MonitorMethodModel, int>(methodList, (x) => x.id, (x) => x.name, "MethodTypeId", 
              initValue: monitor.methodTypeId, 
              label: "Method"),

          createTextField('Url', 'Url', monitor.url, validator: (value) {
            return isURL(value) ? null : "Not valid URL.";
          }),

          createDropDownButtom<MonitorVerificationModel, int>(verificationList, (x) => x.id, (x) => x.name, "VerificationTypeId", 
              initValue: monitor.verificationTypeId, 
              label: "Verification"),

          createTextField('VerificationValue', 'Verification value', monitor.verificationValue),
          
          createTextField('Timeout', 'Timeout', DurationFormatter.ToTimeSpan(monitor.timeout)),          
        ],
      )),
    );
  }
}
