import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:v2/style/constants.dart';
import '../data/NewFeedData.dart';

import 'create_farm_screen.dart';
import 'event_screen.dart';
import 'notification_screen.dart';
import 'evaluate_varieties_screes.dart';

class Feed extends StatefulWidget {
  final FarmFeed feed;
  final dynamic feeds;

  const Feed({Key key, this.feed, this.feeds}) : super(key: key);
  @override
  _FeedState createState() => _FeedState();
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

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    this.label,
    this.padding,
    this.value,
    this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Expanded(child: Text(label)),
            Checkbox(
              value: value,
              onChanged: (bool newValue) {
                onChanged(newValue);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FeedState extends State<Feed> {
  bool checkboxValueCity = false;
  List<String> allCities = ['Alpha', 'Beta', 'Gamma'];
  List<String> selectedCities = [];

  dynamic _feeds;
  var _noti = List();
  var _todayFeed = List();
  var _aleart = false;
  var _aleartContent = List();
  final today = DateTime.now();

  void _onItemTapped(int index) {
    setState(() {
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotificationScreen(
                  notis: _feeds,
                ),
              ),
            );
          }

          break;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    _feeds = widget.feeds;

    for (var i = 0; i < _feeds.length; i++) {
      var notiDate = DateTime.parse(_feeds[i]['feedDate']);
      if (today.compareTo(notiDate) == 0) {
        _todayFeed.add(_feeds[i]);
        _aleart = true;
      } else {
        for (var j = 0; j < _feeds[i]['content'].length; j++) {
          if (_feeds[i]['content'][j] > 10) {
            _aleartContent.add(_feeds[i]['content'][j]);
            _noti.add(_feeds[i]);
            break;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _todayFeed.length == 0
          ? Center(
              child: Column(
                children: [
                  Text(
                    DateFormat('วันที่ dd MMMM yyyy').format(
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
              itemCount: _todayFeed.length,
              itemBuilder: (context, i) {
                return Card(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.landscape),
                          title: Text(
                            "ที่นา : " + _todayFeed[i]['name'],
                            style: kTextStyle,
                          ),
                          subtitle: Text(
                            DateFormat('dd MMMM yyyy').format(
                              DateTime.parse(_todayFeed[i]['feedDate']),
                            ),
                            style: kTextStyle,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: _todayFeed[i]['content'].length,
                          itemBuilder: (context, j) {
                            return Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                _codes[_todayFeed[i]['content'][j]],
                                style: kTextStyle,
                              ),
                            );
                          },
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.end,
                          children: [
                            RaisedButton(
                              color: Colors.blue,
                              onPressed: () {
                                var _activities = _todayFeed[i]['activities']
                                    .map((activitie) {
                                  if (activitie['content'] < 11) {
                                    return _codes[activitie['content']]
                                        .toString();
                                  }
                                }).toList();
                                var _bugs =
                                    _todayFeed[i]['bugs'].map((activitie) {
                                  if (activitie['content'] > 10) {
                                    return _codes[activitie['content']]
                                        .toString();
                                  }
                                }).toList();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EventScreen(
                                      activitiesDate: _todayFeed[i]
                                          ['activitiesDate'],
                                      activities: _activities,
                                      bugs: _bugs,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'จัดการกิจกรรม',
                                style: kTextStyle,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              padding: EdgeInsets.all(10),
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            title: Text(
              'เพิ่มที่นาใหม่',
              style: kTextStyle,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_available),
            title: Text(
              'ประเมินพันธุ์',
              style: kTextStyle,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notification_important,
              color: _feeds.length != 0 ? Colors.red : Colors.grey,
            ),
            title: Text(
              _noti.length.toString(),
              style: kTextStyle,
            ),
          ),
        ],
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.grey,
        //currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
