import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:v2/data/TimelineData.dart';
import 'package:v2/style/constants.dart';

import 'event_screen.dart';

class FarmTimeline extends StatefulWidget {
  final Modeltimeline modeltimeline;
  final dynamic timelineFuture;
  final dynamic timelinePast;

  const FarmTimeline({
    Key key,
    this.modeltimeline,
    this.timelineFuture,
    this.timelinePast,
  }) : super(key: key);
  @override
  _FarmTimelineState createState() => _FarmTimelineState();
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

class _FarmTimelineState extends State<FarmTimeline> {
  dynamic _timelinePast;
  dynamic _timelineFuture;
  int _tLpL;
  int _tLfL;
  int _tLL;
  List<String> selectedCities = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timelinePast = widget.timelinePast;
    _timelineFuture = widget.timelineFuture;
    _tLpL = _timelinePast.length;
    _tLfL = _timelineFuture.length;
    _tLL = _tLpL + _tLfL;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: timelineModel(TimelinePosition.Left),
    );
  }

  timelineModel(TimelinePosition position) => Timeline.builder(
        itemBuilder: centerTimelineBuilder,
        itemCount: _tLL == 0 ? 1 : _tLL,
        physics: BouncingScrollPhysics(),
        position: TimelinePosition.Left,
      );

  TimelineModel centerTimelineBuilder(BuildContext context, int i) {
    final tlfs = _timelineFuture[i];
    return TimelineModel(
      Card(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.landscape),
                title: Text(
                  tlfs['order'] == null ? 'พันธุ์ข้าว: ' : 'ที่นา: ',
                  style: kTextStyle,
                ),
                subtitle: Text(
                  DateFormat('dd MMMM yyyy')
                      .format(DateTime.parse(tlfs['activitiesDate'])),
                  style: kTextStyle,
                ),
              ),
              if (tlfs['activities'] != null)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: tlfs['activities'].length,
                  itemBuilder: (context, j) {
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        _codes[tlfs['activities'][j]['code']],
                        style: kTextStyle,
                      ),
                    );
                  },
                ),
              if (tlfs['bugs'] != null)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: tlfs['bugs'].length,
                  itemBuilder: (context, j) {
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        _codes[tlfs['bugs'][j]['code']],
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
                      var _activities = tlfs['activities'].map((activitie) {
                        return _codes[activitie['code']].toString();
                      }).toList();
                      var _bugs = tlfs['bugs'].map((activitie) {
                        return _codes[activitie['code']].toString();
                      }).toList();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventScreen(
                            activitiesDate: tlfs['activitiesDate'],
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
      ),
      isFirst: i == 0,
      isLast: i == _tLL,
      iconBackground: Colors.greenAccent,
      icon: Icon(Icons.star),
    );
    /* if (_tLpL != 0 && _tLfL != 0) {
      final tlfs = _timelineFuture[i];
      final tlps = _timelinePast[i];
    } else if (_tLfL != 0) {
      final tlfs = _timelineFuture[i];
      return TimelineModel(
        Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.landscape),
                  title: Text(
                    tlfs['order'] == null ? 'พันธุ์ข้าว: ' : 'ที่นา: ',
                    style: kTextStyle,
                  ),
                  subtitle: Text(
                    DateFormat('dd MMMM yyyy')
                        .format(DateTime.parse(tlfs['activitiesDate'])),
                    style: kTextStyle,
                  ),
                ),
                if (tlfs['activities'] != null)
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: tlfs['activities'].length,
                    itemBuilder: (context, j) {
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          _codes[tlfs['activities'][j]['code']],
                          style: kTextStyle,
                        ),
                      );
                    },
                  ),
                if (tlfs['bugs'] != null)
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: tlfs['bugs'].length,
                    itemBuilder: (context, j) {
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          _codes[tlfs['bugs'][j]['code']],
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
                        var _activities = tlfs['activities'].map((activitie) {
                          return _codes[activitie['code']].toString();
                        }).toList();
                        var _bugs = tlfs['bugs'].map((activitie) {
                          return _codes[activitie['code']].toString();
                        }).toList();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventScreen(
                              activitiesDate: tlfs['activitiesDate'],
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
        ),
        isFirst: i == 0,
        isLast: i == _tLL,
        iconBackground: Colors.greenAccent,
        icon: Icon(Icons.star),
      );
    } else if (_tLpL != 0) {
      final tlps = _timelinePast[i];
    } else {
      return TimelineModel(
        Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.landscape),
                  title: Text(
                    'ยังไม่ได้ดำเนินการ',
                    style: kTextStyle,
                  ),
                  subtitle: Text(
                    DateFormat('dd MMMM yyyy').format(DateTime.now()),
                    style: kTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
        isFirst: i == 0,
        isLast: i == _tLL,
        iconBackground: Colors.greenAccent,
        icon: Icon(Icons.star),
      );
    }*/
  }
}
