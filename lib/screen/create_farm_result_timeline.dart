import 'package:flutter/material.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import '../data/TimelineData.dart';
import '../style/constants.dart';
import 'main_screen.dart';

class TimelinePage extends StatefulWidget {
  final Modeltimeline modeltimeline;

  const TimelinePage({Key key, this.modeltimeline}) : super(key: key);
  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  void _resetAndOpenPage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => MainScreen()),
      ModalRoute.withName('/home'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ผลการวิเคราะห์การปลูก',
          style: kLabelStyle,
        ),
        backgroundColor: colorTheam,
      ),
      body: timelineModel(TimelinePosition.Left),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 5,
        onPressed: () {
          _resetAndOpenPage();
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        icon: Icon(Icons.check),
        label: Text(
          'เสร็จสิ้น',
          style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.5,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  timelineModel(TimelinePosition position) => Timeline.builder(
      itemBuilder: centerTimelineBuilder,
      itemCount: modeltimeline.length,
      physics: BouncingScrollPhysics(),
      position: TimelinePosition.Left);

  TimelineModel centerTimelineBuilder(BuildContext context, int i) {
    final modeltimelines = modeltimeline[i];
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
                leading: modeltimelines.iconfarm,
                title: Text(
                  modeltimelines.name,
                  style: kTextStyle,
                ),
                subtitle: Text(
                  modeltimelines.date,
                  style: kTextStyle,
                ),
              ),
              if (modeltimelines.content != '')
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    modeltimelines
                        .content, //modeltimelines.content != '' ? modeltimelines.content : '',
                    style: kTextStyle,
                  ),
                ),
              if (modeltimelines.activity.length != 0)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: modeltimelines.activity.length,
                  itemBuilder: (context, j) {
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        modeltimelines.activity[j],
                        style: kTextStyle,
                      ),
                    );
                  },
                ),
              if (modeltimelines.bug.length != 0)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: modeltimelines.bug.length,
                  itemBuilder: (context, j) {
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        modeltimelines.bug[j],
                        style: TextStyle(color: Colors.amber, fontSize: 20),
                      ),
                    );
                  },
                ),
              if (modeltimelines.disease.length != 0)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: modeltimelines.disease.length,
                  itemBuilder: (context, j) {
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        modeltimelines.disease[j],
                        style: TextStyle(color: Colors.red, fontSize: 20),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
      isFirst: i == 0,
      isLast: i == modeltimeline.length,
      iconBackground: modeltimelines.iconeventcolor,
      icon: modeltimelines.iconevent,
    );
  }
}
