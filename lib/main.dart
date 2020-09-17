import 'package:flutter/material.dart';
import 'screen/create_farm_eval_varietie.dart';
import 'screen/create_farm_result_timeline.dart';
import 'screen/login_screen.dart';
import 'screen/main_screen.dart';

void main() {
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
        '/': (context) => LoginScreen(),
        '/home': (context) => MainScreen(),
        '/NewFeed/Eval': (context) => FarmEvaluateVarityScreen(),
        '/NewFeed/Eval/Result/Timeline': (context) => TimelinePage(),
      },
    );
  }
}
