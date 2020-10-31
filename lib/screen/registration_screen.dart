import 'package:flutter/material.dart';
import 'package:v2/data/apiData.dart';
import 'package:v2/style/constants.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

// ignore: non_constant_identifier_names
user_register(String name, String phone, String password) async {
  print(name);
  print(phone);
  print(password);
  var ip = ip_host.host;
  var url = ip + 'api/user/create';
  Map<String, String> headers = {
    "Content-type": "application/json; charset=UTF-8"
  };
  var json = convert.jsonEncode(<String, String>{
    "name": name,
    "phonenumber": phone,
    "password": password.toString()
  });

  print(json);
  final http.Response response = await http.post(
    url,
    headers: headers,
    body: json,
  );

  if (response.statusCode == 200) {
    var res = response.body;
    print(res);
    return res;
  } else {
    //print('Request failed with status: ${response.statusCode}.');
  }
}

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  var name;
  var phonenumber;
  var password;
  var status;
  Widget _buildButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        onPressed: () async {
          status = await user_register(name, phonenumber, password);
          print(status);
          if (status == 'ok') {
            Navigator.pop(context);
          }
        },
        padding: EdgeInsets.symmetric(
          horizontal: 35,
          vertical: 15,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: Colors.white,
        child: Text(
          'ต่อไป',
          style: TextStyle(
              color: Colors.black,
              letterSpacing: 1.5,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildFarmNameTB() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ชื่อผู้ใช้',
          style: kLabelStyle,
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60,
          child: TextField(
            keyboardType: TextInputType.name,
            style: kTextStyle,
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 8),
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
                hintText: 'ชื่อ',
                hintStyle: kHintTextStyle),
            onChanged: (value) {
              name = value;
            },
          ),
        ),
        SizedBox(height: 10),
        Text(
          'เบอร์โทรศัพท์',
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
                hintText: 'หมายเลขเบอร์โทรศัพท์ 10 หลัก',
                hintStyle: kHintTextStyle),
            onChanged: (value) {
              phonenumber = value;
            },
          ),
        ),
        SizedBox(height: 10),
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
            keyboardType: TextInputType.visiblePassword,
            style: kTextStyle,
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 8),
                prefixIcon: Icon(
                  Icons.vpn_key,
                  color: Colors.grey,
                ),
                hintText: 'อย่างน้อย 6 ตัวอักษร',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ลงทะเบียนผู้ใช้',
          style: kLabelStyle,
        ),
        backgroundColor: colorTheam,
      ),
      body: Stack(
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 60,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildFarmNameTB(),
                  SizedBox(height: 10),
                  _buildButton(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
