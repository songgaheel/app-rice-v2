import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v2/data/apiData.dart';
import 'package:v2/screen/farm_profile_screen.dart';
import 'package:v2/style/constants.dart';

class NotificationScreen extends StatefulWidget {
  final dynamic notis;

  const NotificationScreen({Key key, this.notis}) : super(key: key);
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

Map<int, String> _codes = {
  1: 'เริ่มปลูกข้าว',
  2: 'เก็บเกี่ยวข้าว',
  3: 'ให้น้ำ 3 cm',
  4: 'ให้น้ำ 7 cm',
  5: 'ให้น้ำ 10 cm',
  6: 'ระบายน้ำออก',
  7: 'กำจัดวัชพืช',
  8: 'ตัดพันธ์ปน',
  9: 'ใส่ปุ๋ยสูตร 16-20-0',
  10: 'ใส่ปุ๋ยสูตร 21-0-0',
  11: 'ระวัโรคไหม้ข้าว',
  12: 'ระวังเพลี้ยกระโดดสีน้ำตาล',
  13: 'เตือนภัยแล้ง',
  14: 'เตือนภัยน้ำท่วม',
};

class _NotificationScreenState extends State<NotificationScreen> {
  dynamic _notics;
  var _noti = List();
  var _aleart = false;
  var _aleartContent = List();
  SharedPreferences logindata;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _notics = widget.notis;
    var today = DateTime.now();
    print(_notics);
    for (var i = 0; i < _notics.length; i++) {
      var notiDate = DateTime.parse(_notics[i]['feedDate']);
      print(today);
      print(notiDate);
      print(today.compareTo(notiDate));
      if (today.compareTo(notiDate) == 0) {
        print('today feed');
        _noti.add(_notics[i]);
        _aleart = true;
      } else {
        for (var j = 0; j < _notics[i]['content'].length; j++) {
          if (_notics[i]['content'][j] > 10) {
            print(_notics[i]['content'][j]);
            _aleartContent.add(_notics[i]['content'][j]);
            _noti.add(_notics[i]);
            break;
          }
        }
      }
    }
    print(_noti);
  }

  farm_information(dynamic uid, dynamic farmname) async {
    var ip = ip_host.host;
    var url = ip + 'api/farm/information/name';
    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8"
    };
    var json = jsonEncode(<String, String>{
      "uid": uid,
      "farmname": farmname,
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

  _uidkeeper() async {
    logindata = await SharedPreferences.getInstance();
    var uid = logindata.getString('uid');
    print(uid);
    return uid;
  }

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
        itemCount: _noti.length,
        itemBuilder: (context, i) {
          return Card(
            child: Container(
              height: 150,
              color: Colors.white,
              child: FlatButton(
                onPressed: () async {
                  print('คลิ๊ก  $i');
                  var uid = await _uidkeeper();
                  var farmInfo = await farm_information(uid, _noti[i]['name']);
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
                        Icons.location_on,
                        size: 40,
                      ),
                      title: Text(
                        "ที่นา : " + _noti[i]['name'],
                        style: kTextStyle,
                      ),
                      subtitle: Text(
                        DateFormat('dd MMMM yyyy')
                            .format(DateTime.parse(_noti[i]['feedDate'])),
                        style: kTextStyle,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        (i == 0 && _aleart)
                            ? 'มีกิจกรรมทั้งหมด ${_noti[i]['content'].length} กิจกรรม'
                            : _codes[_aleartContent[i]],
                        style: kTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
