import 'package:flutter/material.dart';
import 'package:v2/style/constants.dart';

class RKBScreen extends StatefulWidget {
  @override
  _RKBScreenState createState() => _RKBScreenState();
}

class _RKBScreenState extends State<RKBScreen> {
  get kTextStyle => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                decoration: kBoxDecorationStyle,
                height: 60,
                child: TextField(
                  keyboardType: TextInputType.text,
                  style: kTextStyle,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      //contentPadding: EdgeInsets.only(left: 14),
                      prefixIcon: FlatButton(
                        onPressed: () {
                          print('search');
                          Navigator.pushNamed(context, '/rkb/information');
                        },
                        child: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                      ),
                      hintStyle: kHintTextStyle),
                ),
              ),
              Card(
                child: FlatButton(
                  onPressed: () {
                    print('user');
                    Navigator.pushNamed(context, '/rkb/information');
                  },
                  child: Container(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.landscape),
                          title: Text(
                            'องค์ความรู้เรื่องข้าว',
                            style: kTextStyle,
                          ),
                          subtitle: Text(
                            'คุณสมบัติของพันธุ์ข้าว',
                            style: kTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                child: FlatButton(
                  onPressed: () {
                    print('โรค แมลง และศัตรูพืช');
                    Navigator.pushNamed(context, '/rkb/information');
                  },
                  child: Container(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.bug_report),
                          title: Text(
                            'โรค แมลง และศัตรูพืช',
                            style: kTextStyle,
                          ),
                          subtitle: Text(
                            'วิธีป้องกัน และแก้ไขปัญหาเรื่อง โรค แมลง และศัตรูพืช',
                            style: kTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                child: FlatButton(
                  onPressed: () {
                    print('เทคโนโลยีการผลิตข้าว');
                    Navigator.pushNamed(context, '/rkb/information');
                  },
                  child: Container(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.settings),
                          title: Text(
                            'เทคโนโลยีการผลิตข้าว',
                            style: kTextStyle,
                          ),
                          subtitle: Text(
                            'เทคโนโลยีการผลิตข้าวในปัจจุบัน',
                            style: kTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
