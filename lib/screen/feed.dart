import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v2/data/apiData.dart';
import 'package:v2/style/constants.dart';

import 'create_farm_screen.dart';
import 'event_screen.dart';
import 'main_screen.dart';
import 'notification_screen.dart';
import 'evaluate_varieties_screes.dart';

import 'package:buddhist_datetime_dateformat/buddhist_datetime_dateformat.dart';
import 'package:google_place/google_place.dart' as googleLocation;

class Feed extends StatefulWidget {
  final dynamic feeds;
  final dynamic notifications;

  const Feed({
    Key key,
    this.feeds,
    this.notifications,
  }) : super(key: key);
  @override
  _FeedState createState() => _FeedState();
}

varieties_information(int vID) async {
  var ip = ip_host.host;
  var url = ip + 'api/init/ricevarityinfo';
  Map<String, String> headers = {
    "Content-type": "application/json; charset=UTF-8"
  };

  var json = jsonEncode(<String, dynamic>{
    "ID": vID,
  });

  final Response response = await post(
    url,
    headers: headers,
    body: json,
  );

  if (response.statusCode == 200) {
    var res = response.body;
    var ret = jsonDecode(res);
    //print(ret);
    return ret;
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}

class _FeedState extends State<Feed> {
  bool checkboxValueCity = false;
  List<String> allCities = ['Alpha', 'Beta', 'Gamma'];
  List<String> selectedCities = [];
  var formatter = DateFormat('dd MMMM yyyy', 'th');
  Map _buttomstatus = {
    '1': {'color': Colors.grey, 'label': 'จัดการกิจกรรม'},
    '2': {'color': Colors.amber, 'label': 'จัดการกิจกรรม'},
    '3': {'color': Colors.blue, 'label': 'จัดการกิจกรรม'},
    '4': {'color': Colors.grey, 'label': 'ตรวจสอบกิจกรรม'},
  };

  dynamic _feeds;
  var _noti;
  final today = DateTime.now();
  var province;
  LocationData _myLocation;
  var googlePlace =
      googleLocation.GooglePlace("AIzaSyAgIlwWm-g9ucv6fiYXLTq9Jj9G9zqrmnY");

  void _onItemTapped(int index) async {
    setState(
      () {
        switch (index) {
          case 0:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateFarmScreen(),
                ),
              );
            }

            break;
          case 1:
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EvaluateVarityScreen(),
                ),
              );
            }

            break;

          case 2:
            {
              if (_noti['activities'][0]['fname'] != null &&
                  _noti['warning'][0]['fname'] != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationScreen(
                      notis: _noti,
                    ),
                  ),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        'การแจ้งเตือน',
                        style: kLabelStyle,
                      ),
                      content: Text(
                        'คุณไม่มีการแจ้งเตือน',
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
              }
            }

            break;
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    initializeDateFormatting();

    _feeds = widget.feeds;
    _noti = widget.notifications;
  }

  Widget _imageTimeline(dynamic activities) {
    var activity = List();
    double h;
    for (var item in activities) {
      for (var item in item['array_code']) {
        if (item['picture'] == 'red' ||
            item['picture'] == 'xx' ||
            item['picture'] == 'r' ||
            item['picture'] == null) {
          h = 0;
        } else {
          h = 300;
        }
        activity.add(item);
      }
    }

    return CarouselSlider.builder(
      itemCount: activity.length,
      itemBuilder: (context, i) {
        if (activity[i]['picture'] == 'red' ||
            activity[i]['picture'] == 'xx' ||
            activity[i]['picture'] == 'r' ||
            activity[i]['picture'] == null) {
          return SizedBox.shrink();
        } else {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Image(
                  height: 200,
                  fit: BoxFit.fill,
                  image: NetworkImage(activity[i]['picture']),
                ), //Image.network(activity[i]['picture']),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${i + 1}/${activity.length}',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          );
        }
      },
      options: CarouselOptions(
        height: h,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: false,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget _activitiesTimeline(dynamic activities) {
    var activity = '';
    var warnning = '';

    for (var i = 0; i < activities.length; i++) {
      for (var j = 0; j < activities[i]['array_code'].length; j++) {
        if (100 < activities[i]['array_code'][j]['activityCode'] &&
            activities[i]['array_code'][j]['activityCode'] < 200)
          activity = activity +
              (j + 1).toString() +
              '. ' +
              activities[i]['array_code'][j]['activity'] +
              '\n';
        if (200 < activities[i]['array_code'][j]['activityCode'] &&
            activities[i]['array_code'][j]['activityCode'] < 300)
          warnning = warnning +
              (j + 1).toString() +
              '. ' +
              activities[i]['array_code'][j]['activity'] +
              '\n';
      }
    }

    if (activity == '') {
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          //color: Colors.red,
          padding: EdgeInsets.only(left: 14),
          child: ReadMoreText(
            'แจ้งเตือน\n$warnning',
            trimLines: 5,
            colorClickableText: Colors.blue,
            trimMode: TrimMode.Line,
            trimCollapsedText: '...เพิ่มเติม',
            trimExpandedText: ' ซ่อน',
            style: kTextStyle,
          ),
        ),
      );
    } else if (warnning == '') {
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          //color: Colors.red,
          padding: EdgeInsets.all(14),
          child: ReadMoreText(
            'กิจกรรม\n$activity',
            trimLines: 5,
            colorClickableText: Colors.blue,
            trimMode: TrimMode.Line,
            trimCollapsedText: '...เพิ่มเติม',
            trimExpandedText: ' ซ่อน',
            style: kTextStyle,
          ),
        ),
      );
    } else {
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          //color: Colors.red,
          padding: EdgeInsets.all(14),
          child: ReadMoreText(
            'กิจกรรม\n$activity\nแจ้งเตือน\n$warnning',
            trimLines: 5,
            colorClickableText: Colors.blue,
            trimMode: TrimMode.Line,
            trimCollapsedText: '...เพิ่มเติม',
            trimExpandedText: ' ซ่อน',
            style: kTextStyle,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: _feeds.length == 0
          ? Center(
              child: Column(
                children: [
                  Text(
                    DateFormat('วันที่ dd MMMM yyyy', 'th')
                        .formatInBuddhistCalendarThai(
                      DateTime.parse(today.toString()),
                    ),
                    style: kTextStyle,
                  ),
                  Text(
                    ' : ที่นาของคุณไม่มีกิจกรรมที่ต้องดำเนินการ',
                    style: kTextStyle,
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _feeds.length,
              itemBuilder: (context, i) {
                var children2 = <Widget>[
                  ListTile(
                    leading: _feeds[i]['feedPicture'] != null
                        ? Material(
                            elevation: 4.0,
                            shape: CircleBorder(),
                            clipBehavior: Clip.hardEdge,
                            color: Colors.transparent,
                            child: Ink.image(
                              image: NetworkImage(_feeds[i]['feedPicture']),
                              fit: BoxFit.cover,
                              width: 50,
                              height: 50,
                              child: InkWell(
                                onTap: () {},
                              ),
                            ),
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.landscape,
                              size: 40,
                            ),
                            onPressed: () {},
                          ),
                    title: Text(
                      _feeds[i]['name'],
                      style: kTextStyle,
                    ),
                    subtitle: Text(
                      formatter.formatInBuddhistCalendarThai(
                          DateTime.parse(_feeds[i]['activitiesDate'])),
                      //.format(DateTime.parse(_feeds[i]['activitiesDate'])),
                      style: kTextStyle,
                    ),
                  ),
                  _imageTimeline(_feeds[i]['activities']),
                  if (_feeds[i]['feedType'] == 1)
                    Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: Row(
                        children: [
                          Text(
                            _feeds[i]['activityLenght'] != 0
                                ? '${_feeds[i]['activityLenght']} กิจกรรม '
                                : '',
                            style: kTextStyle,
                          ),
                          Text(
                            _feeds[i]['warningLenght'] != 0
                                ? '${_feeds[i]['warningLenght']} แจ้งเตือน'
                                : '',
                            style: TextStyle(fontSize: 16, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  if (_feeds[i]['feedType'] == 1)
                    _activitiesTimeline(_feeds[i]['activities']),
                  if (_feeds[i]['caption'] != '')
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        //color: Colors.red,
                        padding: EdgeInsets.all(14),
                        child: ReadMoreText(
                          _feeds[i]['caption'] != null
                              ? _feeds[i]['caption']
                              : '',
                          trimLines: 5,
                          colorClickableText: Colors.blue,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: '...เพิ่มเติม',
                          trimExpandedText: ' ซ่อน',
                          style: kTextStyle,
                        ),
                      ),
                    ),
                  if (_feeds[i]['feedType'] == 1)
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width,
                        child: OutlineButton(
                          onPressed: () async {
                            var activities = _feeds[i]['activities'];

                            var ret = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EventScreen(
                                  activity: activities,
                                  fid: _feeds[i]['farmID'],
                                  farmName: _feeds[i]['name'],
                                  activitiesDate: _feeds[i]['activitiesDate'],
                                  status: _feeds[i]['status'],
                                ),
                              ),
                            );
                            print(ret);
                            if (ret != null) {
                              await _initLocation();
                              var political =
                                  await googlePlace.search.getNearBySearch(
                                googleLocation.Location(
                                  lat: _myLocation.latitude,
                                  lng: _myLocation.longitude,
                                ),
                                100,
                                language: "th",
                                type:
                                    'sublocality_level_1,sublocality,locality,political',
                              );
                              province = political.results.first.name;
                              var uid = await _uidkeeper();

                              print(_myLocation);
                              var initData =
                                  await _get_init_data(uid, province);
                              //var feed = await _loadCharacterData();
                              //initData['feed'] = feed;
                              print('weather');
                              print(initData['weatherForecast7Days'].length);
                              print(initData['weatherForecast7Days']);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainScreen(
                                    initData: initData,
                                  ),
                                ),
                              );
                            }
                          },
                          textColor: _buttomstatus[_feeds[i]['status']]
                              ['color'],
                          borderSide: BorderSide(
                              color: _buttomstatus[_feeds[i]['status']]
                                  ['color'],
                              width: 1.0,
                              style: BorderStyle.solid),
                          child: Text(
                            _buttomstatus[_feeds[i]['status']]['label'],
                            style: kTextStyle,
                          ),
                        ),
                      ),
                    )
                ];
                return Card(
                  child: Column(
                    children: children2,
                  ),
                );
              },
              padding: EdgeInsets.all(10),
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'เพิ่มที่นาใหม่',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_available),
            label: 'ประเมินพันธุ์',
          ),
          /*BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'ข้อมูลพันธ์ข้าว',
          ),*/
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notification_important,
              color: (_noti['activities'][0]['fname'] != null &&
                      _noti['warning'][0]['fname'] != null)
                  ? Colors.red
                  : Colors.grey,
            ),
            label: (_noti['activities'][0]['fname'] != null &&
                    _noti['warning'][0]['fname'] != null)
                ? (_noti['activities'].length + _noti['warning'].length)
                        .toString() +
                    ' การแจ้งเตือน'
                : 'ไม่มีการแจ้งเตือน',
          ),
        ],
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.grey,
        //currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _initLocation() async {
    var location = new Location();
    try {
      _myLocation = await location.getLocation();
    } on Exception {
      _myLocation = null;
    }
  }

  _get_init_data(String uid, String province) async {
    var ip = ip_host.host;
    var url = ip + 'api/init/data';
    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8"
    };
    var json = jsonEncode(<String, dynamic>{
      "_id": uid,
      "Province": province,
    });
    print('json');
    print(json);
    final Response response = await post(
      url,
      headers: headers,
      body: json,
    );

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      //print(res);
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
}
