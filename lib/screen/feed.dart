import 'package:flutter/material.dart';
import '../data/NewFeedData.dart';

import 'create_farm_screen.dart';
import 'notification_screen.dart';
import 'evaluate_varieties_screes.dart';

class Feed extends StatefulWidget {
  final FarmFeed feed;

  const Feed({Key key, this.feed}) : super(key: key);
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  int _selectedIndex = 0;
  List<Widget> _pageWidget = <Widget>[
    CreateFarmScreen(),
    EvaluateVarityScreen(),
    NotificationScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => _pageWidget.elementAt(_selectedIndex)));
    });
  }

  Widget _farmFeedContent() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: feed.length,
        itemBuilder: (context, i) {
          return Card(
            child: Container(
              height: 350,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: feed[i].icon,
                    title: Text(feed[i].name),
                    subtitle: Text(feed[i].date),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(feed[i].content),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: feed[i].activity.length,
                    itemBuilder: (context, j) {
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(feed[i].activity[j]),
                      );
                    },
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: feed[i].bug.length,
                    itemBuilder: (context, j) {
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          feed[i].bug[j],
                          style: TextStyle(color: Colors.amber),
                        ),
                      );
                    },
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: feed[i].disease.length,
                    itemBuilder: (context, j) {
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          feed[i].disease[j],
                          style: TextStyle(color: Colors.red),
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
                          // Perform some action
                        },
                        child: const Text('จัดการกิจกรรม'),
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            title: Text('เพิ่มที่นาใหม่'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_available),
            title: Text('ประเมินพันธุ์'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_important),
            title: Text('การแจ้งเตือน'),
          ),
        ],
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
