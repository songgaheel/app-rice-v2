import 'package:v2/style/constants.dart';

import 'feed.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          backgroundColor: colorTheam,
          title: Center(child: const Text('แอพพลิเคชัน')),
          bottom: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            labelStyle: TextStyle(fontSize: 10.0),
            tabs: <Widget>[
              Tab(
                text: 'กิจกรรม',
                icon: Icon(Icons.assignment),
              ),
              Tab(
                text: 'RKB',
                icon: Icon(Icons.book),
              ),
              Tab(
                text: 'สภาพอากาศ',
                icon: Icon(Icons.cloud),
              ),
              Tab(
                text: 'ราคาข้าว',
                icon: Icon(Icons.store),
              ),
              Tab(
                text: 'บัญชี',
                icon: Icon(Icons.account_circle),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Feed(),
            Text('2'),
            Text('3'),
            Text('4'),
            Text('5'),
          ],
        ),
      ),
    );
  }
}
