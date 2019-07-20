import 'package:app/common/functions/logout.dart';
import 'package:app/common/functions/saveLogout.dart';
import 'package:app/common/platform/platformScaffold.dart';
import 'package:app/common/widgets/MonitorsListWidget.dart';
import 'package:app/common/widgets/RecordsListWidget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class MonitorListScreen extends StatefulWidget {
  @override
  _MonitorListScreenState createState() => _MonitorListScreenState();
}

class _MonitorListScreenState extends State<MonitorListScreen> {  

  String textValue = 'TextValue';

  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: PlatformScaffold(
          appBar: AppBar(            
            title: const Text("NC Monitoring"),
            bottom: TabBar(
              tabs: [
                Tab(text: 'Monitors'),
                Tab(text: 'Records'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Column(
                children: <Widget>[
                  Expanded(
                    child: MonitorsListWidget(),                    
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: FlatButton(
                          //color: Color(0x2196f3),
                          color: Colors.blue[400],
                          child: Text("Logout",
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          onPressed: () => logout(context)
                        ))
                ],
              ),
              RecordsListWidget(50),              
            ],
          ),
        ),
      );
  }
}
