import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v2/data/apiData.dart';

import 'login_screen.dart';
import 'main_screen.dart';
import 'package:google_place/google_place.dart' as googleLocation;
import 'package:location/location.dart';

class InitScreen extends StatefulWidget {
  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  var province;
  LocationData _myLocation;
  var googlePlace =
      googleLocation.GooglePlace("AIzaSyAgIlwWm-g9ucv6fiYXLTq9Jj9G9zqrmnY");
  dynamic _varieties;
  Map<int, String> _varietie = {0: 'เลือกพันธ์ข้าว'};
  Map<String, int> _varietieCode = {'เลือกพันธ์ข้าว': 0};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _autologin();
  }

  getvarieties() async {
    _varieties = await varieties_get();

    _varietie = Map.fromIterable(_varieties,
        key: (varieties) => varieties['ID'] as int,
        value: (varieties) => varieties['rice_varieties_name'] as String);

    _varietieCode = Map.fromIterable(_varieties,
        key: (varieties) => varieties['rice_varieties_name'] as String,
        value: (varieties) => varieties['ID'] as int);
    print(_varietie.values.toList());
  }

  varieties_get() async {
    var ip = ip_host.host;
    var url = ip + 'api/varietie/get';
    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8"
    };

    print(json);
    final Response response = await get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var res = response.body;
      var ret = jsonDecode(res);
      //print(ret);
      return ret;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  _autologin() async {
    logindata = await SharedPreferences.getInstance();
    var uid = logindata.getString('uid');
    print(uid);
    if (uid != null) {
      await _initLocation();
      var political = await googlePlace.search.getNearBySearch(
        googleLocation.Location(
          lat: _myLocation.latitude,
          lng: _myLocation.longitude,
        ),
        100,
        language: "th",
        type: 'sublocality_level_1,sublocality,locality,political',
      );
      province = political.results.first.name;
      googleLocation.DetailsResponse result = await googlePlace.details.get(
        political.results.first.placeId.toString(),
        fields: "formatted_address,address_components",
        language: 'th',
      );
      print(political.results.first.placeId);
      print(result.result.addressComponents);
      for (var item in result.result.addressComponents) {
        print(item.longName);
      }
      for (var i = 0; i < result.result.addressComponents.length; i++) {
        if (result.result.addressComponents[i].types.toString() ==
            "[administrative_area_level_1, political]") {
          print('จังหวัด');
          print(result.result.addressComponents[i].longName);
          province = result.result.addressComponents[i].longName;
        }
      }

      var initData = await _get_init_data(uid, province);
      var price = await _get_price_currentMonth();
      await getvarieties();

      initData['vname'] = _varietie;
      initData['vcode'] = _varietieCode;
      initData['price'] = price['rice_price_predict'];
      print(initData['vname']);
      print(initData['vcode']);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(
            initData: initData,
          ),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    }
    //return uid;
  }

  _get_init_data(String uid, String province) async {
    var ip = ip_host.host;
    var url = ip + 'api/init/data';
    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8"
    };
    var json = jsonEncode(<String, dynamic>{
      "_id": uid,
      "Province": province,
    });
    print('json');
    print(json);
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

  _get_price_currentMonth() async {
    var ip = ip_host.host;
    var url = ip + 'api/farm/ricepricepredict';
    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8"
    };
    final Response response = await post(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      //print(res);
      return res;
    } else {
      //print('Request failed with status: ${response.statusCode}.');
    }
  }

  void _initLocation() async {
    var location = new Location();
    try {
      _myLocation = await location.getLocation();
    } on Exception {
      _myLocation = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[400],
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 250),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 250.0,
                height: 250.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/glas.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: SpinKitCircle(
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
