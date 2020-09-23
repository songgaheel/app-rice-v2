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
          title: Text(
            'การแจ้งเตือน',
            style: kLabelStyle,
          ),
          backgroundColor: colorTheam,
        ),
        body: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, i) {
              return Card(
                child: Container(
                  height: 150,
                  color: Colors.white,
                  child: FlatButton(
                    onPressed: () {
                      print('คลิ๊ก  $i');
                      Navigator.pushNamed(context, '/Account/Farm/Profile');
                    },
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.location_on,
                            size: 40,
                          ),
                          title: Text(
                            'ที่นาที่ $i',
                            style: kTextStyle,
                          ),
                          subtitle: Text(
                            '01 มกราคม 2564',
                            style: kTextStyle,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'มีกิจกรรมทั้งหมด $i กิจกรรม',
                            style: kTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
