import 'package:flutter/material.dart';
import 'package:v2/style/constants.dart';
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
  int _selectedIndex = 0;
  bool checkboxValueCity = false;
  List<String> allCities = ['Alpha', 'Beta', 'Gamma'];
  List<String> selectedCities = [];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: feed.length,
        itemBuilder: (context, i) {
          return Card(
            child: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: feed[i].icon,
                    title: Text(
                      feed[i].name,
                      style: kTextStyle,
                    ),
                    subtitle: Text(feed[i].date),
                  ),
                  if (feed[i].content != '')
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        feed[i]
                            .content, //modeltimelines.content != '' ? modeltimelines.content : '',
                        style: kTextStyle,
                      ),
                    ),
                  if (feed[i].activity.length != 0)
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: feed[i].activity.length,
                      itemBuilder: (context, j) {
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            feed[i].activity[j],
                            style: kTextStyle,
                          ),
                        );
                      },
                    ),
                  if (feed[i].bug.length != 0)
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: feed[i].bug.length,
                      itemBuilder: (context, j) {
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            feed[i].bug[j],
                            style: TextStyle(color: Colors.amber, fontSize: 20),
                          ),
                        );
                      },
                    ),
                  if (feed[i].disease.length != 0)
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: feed[i].disease.length,
                      itemBuilder: (context, j) {
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            feed[i].disease[j],
                            style: TextStyle(color: Colors.red, fontSize: 20),
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
                          showDialog(
                            context: context,
                            builder: (context) {
                              return _MyDialog(
                                name: feed[i].name,
                                cities: feed[i].activity +
                                    feed[i].bug +
                                    feed[i].disease,
                                selectedCities: selectedCities,
                                onSelectedCitiesListChanged: (cities) {
                                  selectedCities = cities;
                                  print(selectedCities);
                                },
                              );
                            },
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
            icon: Icon(Icons.notification_important),
            title: Text(
              'การแจ้งเตือน',
              style: kTextStyle,
            ),
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

class _MyDialog extends StatefulWidget {
  _MyDialog({
    this.cities,
    this.selectedCities,
    this.name,
    this.onSelectedCitiesListChanged,
  });

  final List<String> cities;
  final List<String> selectedCities;
  final String name;
  final ValueChanged<List<String>> onSelectedCitiesListChanged;

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<_MyDialog> {
  List<String> _tempSelectedCities = [];

  @override
  void initState() {
    _tempSelectedCities = widget.selectedCities;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: <Widget>[
          Text(
            widget.name,
            style: kLabelStyle,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.cities.length,
              itemBuilder: (BuildContext context, int index) {
                final cityName = widget.cities[index];
                return Container(
                  child: CheckboxListTile(
                    title: Text(
                      cityName,
                      style: kTextStyle,
                    ),
                    value: _tempSelectedCities.contains(cityName),
                    onChanged: (bool value) {
                      if (value) {
                        if (!_tempSelectedCities.contains(cityName)) {
                          setState(() {
                            _tempSelectedCities.add(cityName);
                          });
                        }
                      } else {
                        if (_tempSelectedCities.contains(cityName)) {
                          setState(() {
                            _tempSelectedCities
                                .removeWhere((String city) => city == cityName);
                          });
                        }
                      }
                      widget.onSelectedCitiesListChanged(_tempSelectedCities);
                    },
                  ),
                );
              },
            ),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Done',
              style: kTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
