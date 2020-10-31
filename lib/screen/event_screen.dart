import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:v2/style/constants.dart';

class EventScreen extends StatefulWidget {
  final dynamic farmName;
  final dynamic activitiesDate;
  final dynamic activities;
  final dynamic bugs;

  const EventScreen(
      {Key key, this.farmName, this.activitiesDate, this.activities, this.bugs})
      : super(key: key);
  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  var _activities;
  var _bugs;
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _activities = widget.activities.cast<String>();
    _bugs = widget.bugs.cast<String>();
    print(_activities);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          onPressed: () {
            Navigator.pop(context);
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
          Container(
            padding: const EdgeInsets.only(left: 14.0, top: 14.0),
            child: Text(
              'ที่นา : ' + 'ชื่อนา',
              style: kLabelStyle,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 14.0, top: 14.0),
            child: Text(
              'ประจำวันที่ ' + 'Day Month Year',
              style: kLabelStyle,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 14.0, top: 14.0),
            child: Text(
              'กิจกรรม',
              style: kTextStyle,
            ),
          ),
          CheckboxGroup(
            labels: _activities,
            //disabled: ["Wednesday", "Friday"],
            onChange: (bool isChecked, String label, int index) {
              print("isChecked: $isChecked   label: $label  index: $index");
            },
            onSelected: (List<String> checked) {
              print("checked: ${checked.toString()}");
            },
            labelStyle: kTextStyle,
          ),
          Container(
            padding: const EdgeInsets.only(left: 14.0, top: 14.0),
            child: Text(
              'เฝ้าระวัง',
              style: kTextStyle,
            ),
          ),
          CheckboxGroup(
            labels: _bugs,
            //disabled: ["Wednesday", "Friday"],
            onChange: (bool isChecked, String label, int index) {
              print("isChecked: $isChecked   label: $label  index: $index");
            },
            onSelected: (List<String> checked) {
              print("checked: ${checked.toString()}");
            },
            labelStyle: kTextStyle,
          ),
        ],
      ),
    );
    //
  }
}
