import 'package:flutter/material.dart';
import 'package:v2/style/constants.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('การแจ้งเตือน'),
          backgroundColor: colorTheam,
        ),
        body: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, i) {
              return Card(
                child: Container(
                  height: 150,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.location_on,
                          size: 40,
                        ),
                        title: Text('$i'),
                        subtitle: Text('Date Month Year'),
                      ),
                      Text('มีกิจกรรมทั้งหมด 5 กิจกรรม')
                    ],
                  ),
                ),
              );
            }));
  }
}
