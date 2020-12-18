import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screen/account_user.dart';
import 'screen/create_farm_eval_varietie.dart';
import 'screen/create_farm_result_timeline.dart';
import 'screen/farm_profile_screen.dart';
import 'screen/google_map_screen.dart';
import 'screen/login_screen.dart';
import 'screen/main_screen.dart';
import 'screen/price_screen.dart';
import 'screen/registration_screen.dart';
import 'screen/rkb_information_screen.dart';
import 'screen/rkb_screen.dart';
import 'screen/varieties_detail_secreen.dart';
import 'screen/init_screen.dart';
// need this for `Intl.defaultLocale = "th";`
import 'package:intl/intl.dart';
// need this for initializeDateFormatting()

// This lets magic happen!
import 'package:buddhist_datetime_dateformat/buddhist_datetime_dateformat.dart';

void main() async {
  Intl.defaultLocale = "th";
  initializeDateFormatting();
  //SharedPreferences prefs = await SharedPreferences.getInstance();
  //var uid = prefs.getString('uid');
  //print(uid);
  //runApp(MaterialApp(home: uid != '' ? LoginScreen() : MainScreen()));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InitScreen(),
    );
  }
}
