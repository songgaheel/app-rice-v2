import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v2/data/apiData.dart';
import 'package:v2/screen/registration_screen.dart';

import '../style/constants.dart';

import 'main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart' as googleLocation;
import 'package:location/location.dart';
import 'loading.dart';

class LoginScreen extends StatefulWidget {
  final APIdata ip_host;

  const LoginScreen({Key key, this.ip_host}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  SharedPreferences logindata;
  var phonenumber;
  var password;
  var res;
  var rememberlogin = false;
  var province;
  LocationData _myLocation;
  var googlePlace =
      googleLocation.GooglePlace("AIzaSyAgIlwWm-g9ucv6fiYXLTq9Jj9G9zqrmnY");

  bool loading = false;
  dynamic _varieties;
  Map<int, String> _varietie = {0: 'เลือกพันธ์ข้าว'};
  Map<String, int> _varietieCode = {'เลือกพันธ์ข้าว': 0};

  @override
  void initState() {
    print('login screen');

    super.initState();
  }

  user_login(String phone, String password) async {
    print(phone);
    print(password);
    var ip = ip_host.host;
    var url = ip + 'api/user/login';
    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8"
    };
    var json = jsonEncode(<String, String>{
      "phonenumber": phone,
      "password": password.toString(),
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

  Widget _buildUserfrom() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'รหัสผ่าน',
          style: kLabelStyle,
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60,
          child: TextField(
            keyboardType: TextInputType.text,
            style: kTextStyle,
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 8),
                prefixIcon: Icon(
                  Icons.vpn_key,
                  color: Colors.grey,
                ),
                hintText: 'กรอกรหัสผ่าน',
                hintStyle: kHintTextStyle),
            obscureText: true,
            onChanged: (value) {
              password = value;
            },
          ),
        )
      ],
    );
  }

  Widget _buildPhonefrom() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'เบอร์โทร',
          style: kLabelStyle,
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60,
          child: TextField(
            keyboardType: TextInputType.phone,
            style: kTextStyle,
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 8),
                prefixIcon: Icon(
                  Icons.phone,
                  color: Colors.grey,
                ),
                hintText: 'หมายเลขโทรศัพท์',
                hintStyle: kHintTextStyle),
            onChanged: (value) {
              phonenumber = value;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRememberLogin() {
    return Container(
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          children: [
            Checkbox(
              value: rememberlogin,
              onChanged: (bool value) async {
                print(value);
                await _initLocation();

                setState(() {
                  rememberlogin = value;
                });
              },
            ),
            Text(
              "บันทึกการเข้าสู่ระบบ",
              style: kTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5,
        onPressed: () async {
          setState(() {
            loading = true;
          });
          if (phonenumber != null && password != null) {
            res = await user_login(phonenumber, password);
            print('res');
            print(res);
            if ((res['status'] == 'success')) {
              var initData = await _init_data();
              //var feed = await _loadCharacterData();
              //initData['feed'] = feed;
              setState(() {
                loading = false;
              });
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MainScreen(
                    initData: initData,
                  ),
                ),
              );
            } else {
              setState(() {
                loading = false;
              });
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      'ข้อผิดพลาด',
                      style: kLabelStyle,
                    ),
                    content: Text(
                      res['msg'],
                      style: kTextStyle,
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text(
                          'ยืนยัน',
                          style: kTextStyle,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
              print(res['status']);
            }
          } else {
            setState(() {
              loading = false;
            });
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    'ข้อผิดพลาด',
                    style: kLabelStyle,
                  ),
                  content: Text(
                    'กรุณากรอกข้อมูลให้ครบ',
                    style: kTextStyle,
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        'ยืนยัน',
                        style: kTextStyle,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: Colors.white,
        child: Text(
          'เข้าสู่ระบบ',
          style: kTextStyle,
        ),
      ),
    );
  }

  Future _loadCharacterData() async {
    String data = await rootBundle.loadString("data/feed.json");
    final timeline = json.decode(data);

    return timeline;
  }

  _init_data() async {
    if (rememberlogin) {
      var uid = await _uidkeeper();
    }

    await _initLocation();

    print(_myLocation);
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

    //var _updateFeed = _update_feed();
    var _initData = await _get_init_data(res['uid'], province);
    var price = await _get_price_currentMonth();
    await getvarieties();

    _initData['vname'] = _varietie;
    _initData['vcode'] = _varietieCode;
    _initData['price'] = price['rice_price_predict'];
    print(_initData['vname']);
    print(_initData['vcode']);
    print(_initData['price']);

    return _initData;
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

  void _initLocation() async {
    var location = new Location();
    try {
      _myLocation = await location.getLocation();
    } on Exception {
      _myLocation = null;
    }
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

  _uidkeeper() async {
    logindata = await SharedPreferences.getInstance();
    logindata.setString('uid', res['uid']);
    var uid = logindata.getString('uid');
    print(uid);
    return uid;
  }

  Widget _buildRegisterButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegistrationScreen()),
          );
          //apitest();
          /*Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
          );*/
        },
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: Colors.white,
        child: Text(
          'ลงทะเบียน',
          style: kTextStyle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.green[400],
            body: Stack(
              children: [
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 120,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Glas Rice',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 50),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            'เข้าสู่ระบบ',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        _buildPhonefrom(),
                        SizedBox(
                          height: 10,
                        ),
                        _buildUserfrom(),
                        _buildRememberLogin(),

                        //_buildRememberMe(),
                        SizedBox(
                          height: 50,
                        ),
                        _buildLoginButton(),
                        _buildRegisterButton()
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
