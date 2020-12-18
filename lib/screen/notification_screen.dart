import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v2/data/apiData.dart';
import 'package:v2/screen/farm_profile_screen.dart';
import 'package:v2/style/constants.dart';
import 'package:buddhist_datetime_dateformat/buddhist_datetime_dateformat.dart';

class NotificationScreen extends StatefulWidget {
  final dynamic notis;

  const NotificationScreen({Key key, this.notis}) : super(key: key);
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  dynamic _notics;
  var _activity;
  var _warning;

  var formatter = DateFormat('dd MMMM yyyy', 'th');
  SharedPreferences logindata;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _notics = widget.notis;
    _activity = _notics['activities'];
    _warning = _notics['warning'];
    print('avtivities');
    print(_activity);
    print('warning');
    print(_warning);
    if (_activity[0]['fname'] == null && _warning[0]['fname'] == null)
      print(true);
    print(_activity[0]['fname']);
    print(_warning[0]['fname']);
  }

  farm_information(dynamic fid) async {
    var ip = ip_host.host;
    var url = ip + 'api/farm/information';
    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8"
    };
    var json = jsonEncode(<String, String>{
      "fid": fid,
    });

    print('json');
    final Response response = await post(
      url,
      headers: headers,
      body: json,
    );

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      print(res);
      return res;
    } else {
      //print('Request failed with status: ${response.statusCode}.');
    }
  }

  Widget _notiActivity() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _activity.length,
      itemBuilder: (context, i) {
        if (_activity[i]['activityLenght'] != 0) {
          return Card(
            child: Container(
              height: 120,
              color: Colors.white,
              child: FlatButton(
                onPressed: () async {
                  print('คลิ๊ก  $i');

                  var farmInfo = await farm_information(_activity[i]['fid']);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FarmProfileScreen(
                        farm: farmInfo,
                      ),
                    ),
                  );
                },
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.landscape,
                        size: 40,
                      ),
                      title: Text(
                        _activity[i]['fname'],
                        style: kTextStyle,
                      ),
                      subtitle: Text(
                        formatter.formatInBuddhistCalendarThai(
                            DateTime.parse(_activity[i]['activitiesDate'])),
                        style: kTextStyle,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'มีกิจกรรมทั้งหมด ${_activity[i]['activityLenght']} กิจกรรม',
                        style: kTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }

  Widget _notiWarning() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _warning.length,
      itemBuilder: (context, i) {
        if (_warning[i]['activityLenght'] != 0) {
          return Card(
            child: Container(
              height: 120,
              color: Colors.white,
              child: FlatButton(
                onPressed: () async {
                  print('คลิ๊ก  $i');

                  var farmInfo = await farm_information(_warning[i]['fid']);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FarmProfileScreen(
                        farm: farmInfo,
                      ),
                    ),
                  );
                },
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.warning,
                        size: 40,
                        color: Colors.amber,
                      ),
                      title: Text(
                        _warning[i]['fname'],
                        style: kTextStyle,
                      ),
                      subtitle: Text(
                        formatter.formatInBuddhistCalendarThai(
                            DateTime.parse(_warning[i]['activitiesDate'])),
                        style: kTextStyle,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'มีการเตือนภัย ${_warning[i]['warningLenght']} เหตุการณ์',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          'การแจ้งเตือน',
          style: kLabelStyle,
        ),
        backgroundColor: colorTheam,
      ),
      body: Column(
        //scrollDirection: Axis.vertical,
        children: [
          if (_activity != null)
            Text(
              'กิจกรรมทั้งหมด ${_activity.length}',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          if (_activity != null)
            Expanded(child: Scrollbar(child: _notiActivity())),
          if (_warning != null)
            Text(
              'เตือนภัยทั้งหมด ${_warning.length}',
              style: TextStyle(
                fontSize: 20,
                color: Colors.red,
              ),
            ),
          if (_warning != null)
            Expanded(child: Scrollbar(child: _notiWarning())),
        ],
      ),
    );
  }
}
