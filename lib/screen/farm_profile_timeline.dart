import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:v2/style/constants.dart';

import 'event_screen.dart';

import 'package:buddhist_datetime_dateformat/buddhist_datetime_dateformat.dart';

import 'farm_profile_screen.dart';

class FarmTimeline extends StatefulWidget {
  final dynamic timeline;
  final dynamic farmName;
  final dynamic fid;

  const FarmTimeline({
    Key key,
    this.timeline,
    this.farmName,
    this.fid,
  }) : super(key: key);
  @override
  _FarmTimelineState createState() => _FarmTimelineState();
}

class _FarmTimelineState extends State<FarmTimeline> {
  var today = DateTime.now().add(new Duration(days: 4));
  dynamic _timeline;
  dynamic _farmName;
  dynamic _fid;

  Map _buttomstatus = {
    '1': {'color': Colors.grey, 'label': 'จัดการกิจกรรม'},
    '2': {'color': Colors.amber, 'label': 'จัดการกิจกรรม'},
    '3': {'color': Colors.blue, 'label': 'จัดการกิจกรรม'},
    '4': {'color': Colors.grey, 'label': 'ตรวจสอบกิจกรรม'},
  };

  var formatter = DateFormat('dd MMMM yyyy', 'th');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _farmName = widget.farmName;
    _timeline = widget.timeline;
    _fid = widget.fid;
    print('timeline');
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: timelineModel(TimelinePosition.Left),
      backgroundColor: Colors.grey[300],
    );
  }

  timelineModel(TimelinePosition position) => Timeline.builder(
        itemBuilder: centerTimelineBuilder,
        itemCount: _timeline.length, //_tLL == 0 ? 1 : _tLL,
        physics: BouncingScrollPhysics(),
        position: TimelinePosition.Left,
      );

  Widget _imageTimeline(dynamic activities) {
    //print(activities);
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
        print('item');
        print(item);
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
                padding: const EdgeInsets.only(bottom: 8),
                child: Image(
                  height: 200,
                  fit: BoxFit.fill,
                  image: NetworkImage(activity[i]['picture']),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  color: Colors.blue,
                  child: Text(
                    '${i + 1}/${activity.length}',
                  ),
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
          padding: EdgeInsets.all(14),
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

  TimelineModel centerTimelineBuilder(BuildContext context, int i) {
    final tls = _timeline[i];
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
                leading: tls['farmPicture'] == null
                    ? Material(
                        elevation: 4.0,
                        shape: CircleBorder(),
                        clipBehavior: Clip.hardEdge,
                        color: Colors.transparent,
                        child: Ink.image(
                          image: AssetImage('assets/glas.png'),
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
                  _farmName,
                  style: kTextStyle,
                ),
                subtitle: Text(
                  formatter.formatInBuddhistCalendarThai(
                      DateTime.parse(tls['activitiesDate'])),
                  style: kTextStyle,
                ),
              ),
              _imageTimeline(tls['activities']),
              Row(
                children: [
                  Text(
                    tls['activityLenght'] != 0
                        ? '${tls['activityLenght']} กิจกรรม '
                        : '',
                    style: kTextStyle,
                  ),
                  Text(
                    tls['warningLenght'] != 0
                        ? '${tls['warningLenght']} แจ้งเตือน'
                        : '',
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                ],
              ),
              _activitiesTimeline(tls['activities']),
              if (tls['caption'] != '')
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    //color: Colors.red,
                    child: ReadMoreText(
                      tls['caption'] != null ? tls['caption'] : '',
                      trimLines: 1,
                      colorClickableText: Colors.blue,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: '...เพิ่มเติม',
                      trimExpandedText: ' ซ่อน',
                      style: kTextStyle,
                    ),
                  ),
                ),
              ButtonTheme(
                minWidth: MediaQuery.of(context).size.width,
                child: OutlineButton(
                  onPressed: () async {
                    var activities = tls['activities'];

                    var ret = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventScreen(
                          farmName: _farmName,
                          activitiesDate: tls['activitiesDate'],
                          fid: _fid,
                          activity: activities,
                          status: tls['status'],
                        ),
                      ),
                    );
                    print(ret);
                    if (ret != null) {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FarmProfileScreen(
                            farm: ret,
                          ),
                        ),
                      );
                    }
                  },
                  textColor: _buttomstatus[tls['status']]['color'],
                  borderSide: BorderSide(
                      color: _buttomstatus[tls['status']]['color'],
                      width: 1.0,
                      style: BorderStyle.solid),
                  child: Text(
                    _buttomstatus[tls['status']]['label'],
                    style: kTextStyle,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      isFirst: i == 0,
      isLast: i == _timeline.length,
      iconBackground: tls['warningLenght'] == 0 ? Colors.green : Colors.amber,
      icon: tls['warningLenght'] == 0
          ? Icon(
              Icons.landscape,
              color: Colors.white,
              size: 40,
            )
          : Icon(
              Icons.warning,
              color: Colors.white,
              size: 40,
            ),
    );
  }
}
