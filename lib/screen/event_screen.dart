import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:http/http.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:v2/data/apiData.dart';
import 'package:v2/style/constants.dart';

import 'package:buddhist_datetime_dateformat/buddhist_datetime_dateformat.dart';
import 'init_screen.dart';

class EventScreen extends StatefulWidget {
  final dynamic farmName;
  final dynamic fid;
  final dynamic status;
  final dynamic activitiesDate;
  final dynamic activity;

  const EventScreen({
    Key key,
    this.farmName,
    this.activitiesDate,
    this.fid,
    this.activity,
    this.status,
  }) : super(key: key);
  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  var _activities = List();
  var _bugs = List();
  var _activitiesCheck = List();
  var _bugsCheck = List();
  var _farmName;
  var _fid;
  var _activitiesDate;
  var _activity;
  var _status;

  var formatter = DateFormat('dd MMMM yyyy', 'th');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeDateFormatting();
    print('event screen');
    _activity = widget.activity;
    _farmName = widget.farmName;
    _fid = widget.fid;
    _activitiesDate = widget.activitiesDate;
    _status = widget.status;

    for (var i = 0; i < _activity.length; i++) {
      for (var j = 0; j < _activity[i]['array_code'].length; j++) {
        if (100 < _activity[i]['array_code'][j]['activityCode'] &&
            _activity[i]['array_code'][j]['activityCode'] < 200) {
          _activities.add(_activity[i]['array_code'][j]['activity']);
          if (_activity[i]['array_code'][j]['activate'])
            _activitiesCheck.add(_activity[i]['array_code'][j]['activity']);
        }
        if (200 < _activity[i]['array_code'][j]['activityCode'] &&
            _activity[i]['array_code'][j]['activityCode'] < 300) {
          _bugs.add(_activity[i]['array_code'][j]['activity']);
          if (_activity[i]['array_code'][j]['activate'])
            _bugsCheck.add(_activity[i]['array_code'][j]['activity']);
        }
      }
    }
    _activities = _activities.cast<String>();
    _bugs = _bugs.cast<String>();
    _activitiesCheck = _activitiesCheck.cast<String>();
    _bugsCheck = _bugsCheck.cast<String>();
  }

  Widget _listActivity() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 14.0, top: 14.0),
          child: Text(
            'กิจกรรม',
            style: kTextStyle,
          ),
        ),
        CheckboxGroup(
          labels: _activities == [''] ? [] : _activities,
          checked: _activitiesCheck,
          disabled: _status == '4' ? _bugs : [],
          onChange: (bool isChecked, String label, int index) {
            for (var i = 0; i < _activity.length; i++) {
              for (var j = 0; j < _activity[i]['array_code'].length; j++) {
                if (_activity[i]['array_code'][j]['activity'] == label) {
                  _activity[i]['array_code'][j]['activate'] = isChecked;
                  if (isChecked) {
                    _activitiesCheck
                        .add(_activity[i]['array_code'][j]['activity']);
                  } else {
                    _activitiesCheck
                        .remove(_activity[i]['array_code'][j]['activity']);
                  }
                }
              }
            }
            print(_activitiesCheck);
          },
          onSelected: (List<String> checked) {
            print("checked: ${checked.toString()}");
          },
          labelStyle: kTextStyle,
        ),
      ],
    );
  }

  Widget _listBug() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 14.0, top: 14.0),
          child: Text(
            'เฝ้าระวัง',
            style: kTextStyle,
          ),
        ),
        CheckboxGroup(
          labels: _bugs == [''] ? [] : _bugs,
          checked: _bugsCheck,
          disabled: _status == '4' ? _bugs : [],
          onChange: (bool isChecked, String label, int index) {
            for (var i = 0; i < _activity.length; i++) {
              for (var j = 0; j < _activity[i]['array_code'].length; j++) {
                if (_activity[i]['array_code'][j]['activity'] == label) {
                  _activity[i]['array_code'][j]['activate'] = isChecked;
                  if (isChecked) {
                    _bugsCheck.add(_activity[i]['array_code'][j]['activity']);
                  } else {
                    _bugsCheck
                        .remove(_activity[i]['array_code'][j]['activity']);
                  }
                }
              }
            }
          },
          onSelected: (List<String> checked) {
            print("checked: ${checked.toString()}");
          },
          labelStyle: kTextStyle,
        ),
      ],
    );
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

  farm_activate(dynamic fid, dynamic activitiesDate, dynamic activities) async {
    var ip = ip_host.host;
    var url = ip + 'api/farm/updateactivity';
    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8"
    };
    var json = jsonEncode(<String, dynamic>{
      "fid": fid,
      "activitiesDate": activitiesDate,
      "activities": activities
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          'จัดการกิจกรรม',
          style: kLabelStyle,
        ),
        backgroundColor: colorTheam,
      ),
      bottomNavigationBar: BottomAppBar(
        child: FlatButton.icon(
          textColor: Colors.black,
          onPressed: () async {
            if (_status != '4') {
              print(_activity);
              print(_fid);
              print(_activitiesDate);
              await farm_activate(_fid, _activitiesDate, _activity);
              var farmInfo = await farm_information(_fid);
              await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      'จัดการกิจกรรม',
                      style: kLabelStyle,
                    ),
                    content: Text(
                      'ดำเนินการเสร็จสิ้น',
                      style: kTextStyle,
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text(
                          'ยืนยัน',
                          style: kTextStyle,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
              if (farmInfo != null) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InitScreen(),
                  ),
                );
              } else {
                Navigator.pop(context, farmInfo);
              }
            } else {
              Navigator.pop(context);
            }
            // Respond to button press
          },
          icon: Icon(Icons.check, size: 24),
          label: Text(
            "ยืนยัน",
            style: kLabelStyle,
          ),
        ),
      ),
      body: ListView(
        children: [
          Card(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(14.0),
                  child: Text(
                    _farmName,
                    style: kLabelStyle,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(14.0),
                  child: Text(
                    formatter.formatInBuddhistCalendarThai(
                        DateTime.parse(_activitiesDate)),
                    style: kTextStyle,
                  ),
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                if (_activities.length != 0) _listActivity(),
                if (_bugs.length != 0) _listBug(),
              ],
            ),
          ),
        ],
      ),
    );
    //
  }
}
