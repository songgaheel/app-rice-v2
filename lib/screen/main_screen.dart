import '../style/constants.dart';

import 'account_screen.dart';
import 'feed.dart';
import 'package:flutter/material.dart';

import 'rice_price_screen.dart';
import 'rkb_screen.dart';
import 'weather_screen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          backgroundColor: colorTheam,
          title: Center(
            child: Text(
              'แอพพลิเคชัน',
              style: kLabelStyle,
            ),
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
                icon: Icon(Icons.account_circle),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Feed(),
            RKBScreen(),
            WeatherScreen(),
            RicePriceScreen(),
            AccountScreen(),
          ],
        ),
      ),
    );
  }
}
