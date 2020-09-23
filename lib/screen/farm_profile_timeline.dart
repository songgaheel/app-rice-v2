import 'package:flutter/material.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:v2/data/TimelineData.dart';
import 'package:v2/style/constants.dart';

class FarmTimeline extends StatefulWidget {
  final Modeltimeline modeltimeline;

  const FarmTimeline({Key key, this.modeltimeline}) : super(key: key);
  @override
  _FarmTimelineState createState() => _FarmTimelineState();
}

class _FarmTimelineState extends State<FarmTimeline> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: timelineModel(TimelinePosition.Left),
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
