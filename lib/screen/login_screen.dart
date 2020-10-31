import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v2/data/apiData.dart';

import '../style/constants.dart';

import 'main_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

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
  var status;

  user_login(String phone, String password) async {
    print(phone);
    print(password);
    var ip = ip_host.host;
    var url = ip + 'api/user/login';
    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8"
    };
    var json = convert.jsonEncode(<String, String>{
      "phonenumber": phone,
      "password": password.toString(),
    });

    print(json);
    final http.Response response = await http.post(
      url,
      headers: headers,
      body: json,
    );

    if (response.statusCode == 200) {
      var res = convert.jsonDecode(response.body);
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

  Widget _buildForgetSingInData() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('ลืมข้อมูลเข้าสู่ระบบ'),
        padding: EdgeInsets.only(right: 0),
        child: Text(
          'ลืมข้อมูลเข้าสู่ระบบ',
          style: kTextStyle,
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
          status = await user_login(phonenumber, password);

          if ((status['status'] == 'ok')) {
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
          } else {
            print(status['status']);
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

  _init_data() async {
    var uid = await _uidkeeper();
    var _initData = _get_init_data(uid);
    return _initData;
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

  _uidkeeper() async {
    logindata = await SharedPreferences.getInstance();
    logindata.setString('uid', status['uid']);
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
          Navigator.pushNamed(context, '/registration');
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
    return Scaffold(
      backgroundColor: Colors.green[400],
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 120,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ลงชื่อเข้าใช้',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  _buildPhonefrom(),

                  SizedBox(
                    height: 30,
                  ),
                  _buildUserfrom(),
                  _buildForgetSingInData(),
                  //_buildRememberMe(),
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
