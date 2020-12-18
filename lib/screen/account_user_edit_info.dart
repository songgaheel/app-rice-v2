import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:v2/data/apiData.dart';
import 'package:v2/style/constants.dart';

import 'google_map_screen.dart';

class UserEditInforScreen extends StatefulWidget {
  final dynamic userID;
  final dynamic userName;
  final dynamic userAddress;
  final dynamic userPhonenumber;

  const UserEditInforScreen({
    Key key,
    this.userID,
    this.userName,
    this.userAddress,
    this.userPhonenumber,
  }) : super(key: key);
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserEditInforScreen> {
  final formKey = new GlobalKey<FormState>();

  dynamic _userID;
  dynamic _userName;
  dynamic _userAddress;
  dynamic _userPhonenumber;
  dynamic _userNameSave;
  dynamic _userAddressSave;

  @override
  void initState() {
    super.initState();
    _userID = widget.userID;
    _userName = widget.userName;
    _userAddress = widget.userAddress;
    _userPhonenumber = widget.userPhonenumber;
  }

  void updateInformation(String location) {
    setState(() => _userAddress = location);
  }

  void moveToSecondPage() async {
    final location = await Navigator.push(
      context,
      CupertinoPageRoute(
          fullscreenDialog: true, builder: (context) => MyMapPage()),
    );
    _userAddressSave = location;
    updateInformation(location["formattedAddress"]);
    //farmlocation = location == null ? null : location;
    print(location["formattedAddress"]);
  }

  Widget _buildUserLocation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ที่อยู่',
          style: kLabelStyle,
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          child: Row(
            children: [
              IconButton(
                color: Colors.black,
                onPressed: () {
                  moveToSecondPage();
                },
                icon: Icon(Icons.map),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    _userAddress == null
                        ? 'แตะเลือกตำแหน่งจากแผนที่'
                        : _userAddress,
                    style: kTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildFarmNameTB() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ชื่อ-นามสกุล',
          style: kLabelStyle,
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60,
          child: new TextFormField(
            onChanged: (value) {
              setState(() {
                _userName = value;
              });
            },
            initialValue: _userName,
            keyboardType: TextInputType.name,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 14),
              hintText: _userName,
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          'เบอร์โทร',
          style: kLabelStyle,
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60,
          child: TextFormField(
            initialValue: _userPhonenumber,
            enabled: false,
            keyboardType: TextInputType.number,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 14),
              hintText: _userPhonenumber,
              hintStyle: kHintTextStyle,
            ),
          ),
        )
      ],
    );
  }

  Widget _userProfile() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: new Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 140.0,
                height: 140.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/farmer.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 90.0, right: 100.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 25.0,
                  child: new Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  user_updateinfo(
    String uid,
    String name,
    String formattedAddress,
    int province,
    double latt,
    double long,
  ) async {
    print(name);
    var ip = ip_host.host;
    var url = ip + 'api/user/updateinfo';
    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8"
    };
    var json = jsonEncode(<String, dynamic>{
      "_id": uid,
      "name": name,
      "formattedAddress": formattedAddress,
      "province": province,
      "latt": latt,
      "long": long,
    });
    final Response response = await post(
      url,
      headers: headers,
      body: json,
    );

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      return res;
    } else {
      //print('Request failed with status: ${response.statusCode}.');
    }
  }

  Widget _buildButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      child: ButtonBar(
        alignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      'ยกเลิกการแก้ไขข้อมูล',
                      style: kLabelStyle,
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
            },
            padding: EdgeInsets.symmetric(
              horizontal: 35,
              vertical: 15,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            color: Colors.red,
            child: Text(
              'ยกเลิก',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          RaisedButton(
            onPressed: () async {
              print('send data');
              print(_userID);
              print(_userName);
              var res = await user_updateinfo(
                _userID,
                _userName,
                _userAddressSave == null
                    ? ''
                    : _userAddressSave['formattedAddress'],
                1,
                _userAddressSave == null ? 0 : _userAddressSave['latt'],
                _userAddressSave == null ? 0 : _userAddressSave['long'],
              );
              print('res');
              print(res);
              await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      res['msg'] == null ? 'แก้ไขข้อมูลเสร็จสิ้น' : res['msg'],
                      style: kLabelStyle,
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
              Navigator.pop(context, res);
            },
            padding: EdgeInsets.symmetric(
              horizontal: 35,
              vertical: 15,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            color: Colors.green,
            child: Text(
              'ยืนยัน',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          'แก้ไขข้อมูลผู้ใช้',
          style: kLabelStyle,
        ),
        backgroundColor: colorTheam,
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 40,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _userProfile(),
                  SizedBox(height: 10),
                  _buildFarmNameTB(),
                  SizedBox(height: 10),
                  _buildUserLocation(),
                  _buildButton()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
