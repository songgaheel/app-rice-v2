//import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:v2/style/constants.dart';

import 'package:buddhist_datetime_dateformat/buddhist_datetime_dateformat.dart';

class WeatherScreen extends StatefulWidget {
  final dynamic weather;

  const WeatherScreen({Key key, this.weather}) : super(key: key);
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // DateTime _dateTime;
  var _weatherToday;
  var _weather;
  var _province;

  var formatter = DateFormat('dd MMMM yyyy', 'th');
  final today = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _weatherToday = widget.weather['SevenDaysForecast'][0];
    _weather = widget.weather['SevenDaysForecast'];
    _province = widget.weather['ProvinceNameTh'];
    print(widget.weather);
  }

  Widget _weatherDesIcon() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: new Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 150.0,
                height: 150.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/${_weatherToday['WeatherDescriptionEn']}.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 0, left: 200),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    DateTime tempDate = DateFormat('dd/MM/yyyy', 'th')
                        .parse(_weatherToday['Date']);
                    print(tempDate);
                  },
                  child: new CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 15.0,
                    child: new Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _weatherDesIconWeek(dynamic des) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: new Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: AssetImage('assets/${des}.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 0, left: 200),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    DateTime tempDate = DateFormat('dd/MM/yyyy', 'th')
                        .parse(_weatherToday['Date']);
                    print(tempDate);
                  },
                  child: new CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 15.0,
                    child: new Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _weatherWeek() {
    if (_weather.length > 0) {
      return Scrollbar(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: _weather.length - 1,
          itemBuilder: (context, i) {
            var inputFormat = DateFormat("dd/MM/yyyy");
            var _weatherdateTime = inputFormat.parse(_weather[i + 1]['Date']);
            //var dateTime = DateTime.parse(_weather[i]['Date']);
            return Container(
              height: 100,
              width: 200,
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            DateFormat('dd MMM yyyy', 'th')
                                .formatInBuddhistCalendarThai(DateTime.parse(
                                    _weatherdateTime.toString())),
                          ),
                          Text(
                            '$_province',
                            style: kTextStyle,
                          ),
                          _weatherDesIconWeek(
                              _weather[i + 1]['WeatherDescriptionEn']),
                          Text(
                            '${_weather[i + 1]['WeatherDescription']}',
                            style: kTextStyle,
                          ),
                          Text(
                            '${_weather[i + 1]['MaxTemperature']['Value']}/${_weather[i + 1]['MinTemperature']['Value']}°C',
                            style: kTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    } else {
      return Text('ไม่มีข้อมูล');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        DateFormat('dd MMM yyyy', 'th')
                            .formatInBuddhistCalendarThai(
                                DateTime.parse(today.toString())),
                      ),
                      Text(
                        '$_province',
                        style: kTextStyle,
                      ),
                      _weatherDesIcon(),
                      Text(
                        '${_weatherToday['WeatherDescription']}',
                        style: kTextStyle,
                      ),
                      Text(
                        '${_weatherToday['MaxTemperature']['Value']}/${_weatherToday['MinTemperature']['Value']}°C',
                        style: kTextStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: _weatherWeek())
        ],
      ),
    );
  }
}
