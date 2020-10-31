import 'package:flutter/material.dart';
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

void main() async {
  /*SharedPreferences prefs = await SharedPreferences.getInstance();
  var uid = prefs.getString('uid');
  print(uid);
  runApp(MaterialApp(home: uid != '' ? LoginScreen() : MainScreen()));*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        //'/': (context) => MyMapPage(),
        '/': (context) => LoginScreen(),
        '/home': (context) => MainScreen(),
        '/NewFeed/Eval': (context) => FarmEvaluateVarityScreen(),
        '/NewFeed/Eval/Result/Timeline': (context) => TimelinePage(),
        '/Account/Farm/Profile': (context) => FarmProfileScreen(),
        '/rkb': (context) => RKBScreen(),
        '/rkb/information': (context) => RKBInformationScreen(),
        '/Account/User/Profile': (context) => UserScreen(),
        '/rice-price': (context) => PriceScreen(),
        '/registration': (context) => RegistrationScreen(),
      },
    );
  }
}
