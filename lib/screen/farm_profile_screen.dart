import 'package:flutter/material.dart';
import 'package:v2/screen/farm_profile_information.dart';
import 'package:v2/style/constants.dart';

import 'farm_profile_profit.dart';
import 'farm_profile_timeline.dart';

class FarmProfileScreen extends StatefulWidget {
  @override
  _FarmProfileScreenState createState() => _FarmProfileScreenState();
}

class _FarmProfileScreenState extends State<FarmProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          backgroundColor: colorTheam,
          title: Text(
            'Farm Profile',
            style: kLabelStyle,
          ),
          bottom: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            labelStyle: kTextStyle,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.info),
              ),
              Tab(
                icon: Icon(Icons.monetization_on),
              ),
              Tab(
                icon: Icon(Icons.timeline),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                      'แชร์สำเร็จ',
                      style: kLabelStyle,
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
                  ),
                );
              },
            )
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            FarmInformaion(),
            FarmProfileProfit(),
            FarmTimeline(),
          ],
        ),
      ),
    );
  }
}
