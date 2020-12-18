import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    //print(_initData['feed']['feed']);
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

  /*_init_data() async {
    var _initData0 = _get_init_data(_initData['userData']['name']['_id']);
    return _initData0;
  }*/

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
      length: 5, //5
      child: Scaffold(
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          backgroundColor: colorTheam,
          title: Text(
            'GLAS RICE',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          bottom: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            labelStyle: kTextStyle,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.assignment),
              ),
              Tab(
                icon: Icon(Icons.book),
              ),
              Tab(
                icon: Icon(Icons.cloud),
              ),
              Tab(
                icon: Icon(Icons.store),
              ),
              Tab(
                icon: Icon(Icons.view_list),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                logindata = await SharedPreferences.getInstance();
                await logindata.clear();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
            ),
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            Feed(
              feeds: _initData['feed'],
              notifications: _initData['notification'],
            ),
            RKBScreen(),
            WeatherScreen(
              weather: _initData['weatherForecast7Days'],
            ),
            RicePriceScreen(
              price: _initData['price'],
              vname: _initData['vname'],
              vcode: _initData['vcode'],
            ),
            AccountScreen(
              userID: _initData['userData']['uid'],
              username: _initData['userData']['name'],
              useraddress: _initData['userData']['address']['formattedAddress'],
              userphonenumber: _initData['userData']['phonenumber'],
              farmList: _initData['farms'],
            )
          ],
        ),
      ),
    );
  }
}
