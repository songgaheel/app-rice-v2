import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v2/data/FarmData.dart';
import 'package:v2/data/apiData.dart';

import '../style/constants.dart';

import 'account_screen.dart';
import 'feed.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'rice_price_screen.dart';
import 'rkb_screen.dart';
import 'weather_screen.dart';

class MainScreen extends StatefulWidget {
  final dynamic initData;

  const MainScreen({Key key, this.initData}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

SharedPreferences logindata;

class _MainScreenState extends State<MainScreen> {
  dynamic _initData;
  var today;
  @override
  void initState() {
    print('main screen');

    super.initState();
    _initData = widget.initData;
    print(_initData['feed']['feed']);
  }

  midnight_test(dynamic uid, dynamic today) async {
    var ip = ip_host.host;
    var url = ip + 'api/test/midnight';
    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8"
    };
    var json = jsonEncode(<String, String>{
      "uid": uid,
      "today": today,
    });
    print(json);
    final Response response = await post(
      url,
      headers: headers,
      body: json,
    );

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      print(res);
      return res;
    } else {
      //print('Request failed with status: ${response.statusCode}.');
    }
  }

  _init_data() async {
    var _initData0 = _get_init_data(_initData['userData']['name']['_id']);
    return _initData0;
  }

  _get_init_data(String uid) async {
    var ip = ip_host.host;
    var url = ip + 'api/init/data';
    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8"
    };
    var json = jsonEncode(<String, dynamic>{
      "_id": uid,
    });

    //print(json);
    final Response response = await post(
      url,
      headers: headers,
      body: json,
    );

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      //print(res);
      return res;
    } else {
      //print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, //5
      child: Scaffold(
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          backgroundColor: colorTheam,
          title: Text(
            'GLAS RICE',
            style: kLabelStyle,
          ),
          bottom: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            labelStyle: kTextStyle,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.assignment),
              ),
              /*Tab(
                icon: Icon(Icons.book),
              ),
              Tab(
                icon: Icon(Icons.cloud),
              ),
              Tab(
                icon: Icon(Icons.store),
              ),*/
              Tab(
                icon: Icon(Icons.account_circle),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () async {
                var uid = _initData['userData']['name']['_id'];
                today = DateTime.now().add(Duration(days: 1));
                var dateformatt = DateFormat('yyyy-MM-dd' 'T' 'HH:mm:ss.sss');
                var sdate = dateformatt.format(today) + 'Z';
                print(today);
                var midnight = await midnight_test(uid, sdate.toString());
                var initData = await _init_data();
                print(initData);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreen(
                      initData: initData,
                    ),
                  ),
                );
              },
            )
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            Feed(
              feeds: _initData['feed']['feed'],
            ),
            //RKBScreen(),
            //WeatherScreen(),
            //RicePriceScreen(),
            AccountScreen(
              userID: _initData['userData']['name']['_id'],
              username: _initData['userData']['name']['name'],
              useraddress: _initData['userData']['address']['formattedAddress'],
              farmList: _initData['farms']['farms'],
            )
          ],
        ),
      ),
    );
  }
}
