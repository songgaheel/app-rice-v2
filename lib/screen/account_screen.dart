import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:v2/data/FarmData.dart';
import 'package:v2/data/apiData.dart';
import 'package:v2/style/constants.dart';

import 'account_user.dart';
import 'farm_profile_screen.dart';

class AccountScreen extends StatefulWidget {
  final Farm farm;
  final dynamic userID;
  final dynamic username;
  final dynamic useraddress;
  final dynamic farmList;

  const AccountScreen({
    Key key,
    this.farm,
    this.username,
    this.useraddress,
    this.userID,
    this.farmList,
  }) : super(key: key);
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  dynamic _userID;
  dynamic _username;
  dynamic _useraddress;
  dynamic _farms;

  @override
  void initState() {
    print('main screen');

    super.initState();
    _userID = widget.userID;
    _username = widget.username;
    _useraddress = widget.useraddress;
    _farms = widget.farmList;
  }

  user_information(dynamic uid) async {
    var ip = ip_host.host;
    var url = ip + 'api/user/information';
    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8"
    };
    var json = jsonEncode(<String, String>{
      "uid": uid,
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

  farm_information(dynamic fid) async {
    var ip = ip_host.host;
    var url = ip + 'api/farm/information';
    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8"
    };
    var json = jsonEncode(<String, String>{
      "fid": fid,
    });

    print('json');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Card(
            child: FlatButton(
              onPressed: () async {
                print('user');
                var user = await user_information(_userID);
                print(user);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserScreen(
                      userAddress: _useraddress,
                      userName: _username,
                      userPhonenumber: user['uid']['phonenumber'],
                    ),
                  ),
                );
              },
              child: Container(
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.account_circle),
                      title: Text(
                        _username,
                        style: kTextStyle,
                      ),
                      subtitle: Text(
                        _useraddress == null ? '' : _useraddress,
                        style: kTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: _farms.length,
            itemBuilder: (context, i) {
              return Card(
                child: FlatButton(
                  onPressed: () async {
                    print('Click profile ${_farms[i]['_id']}');
                    var farmInfo = await farm_information(_farms[i]['_id']);
                    print(farmInfo['varietie']);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FarmProfileScreen(
                          farm: farmInfo,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.landscape),
                          title: Text(
                            _farms[i]['name'],
                            style: kTextStyle,
                          ),
                          subtitle: Text(
                            _farms[i]['location']['formattedAddress'],
                            style: kTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
