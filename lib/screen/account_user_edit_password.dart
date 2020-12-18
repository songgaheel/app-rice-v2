import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:v2/data/apiData.dart';
import 'package:v2/style/constants.dart';

class UserEditPassScreen extends StatefulWidget {
  final dynamic userID;
  final dynamic phonenumber;

  const UserEditPassScreen({Key key, this.userID, this.phonenumber})
      : super(key: key);
  @override
  _UserEditPassScreenState createState() => _UserEditPassScreenState();
}

class _UserEditPassScreenState extends State<UserEditPassScreen> {
  var oldpassword;
  var newpassword;
  var newpasswordcf;
  Widget _buildFarmNameTB() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'รหัสผ่านเดิม',
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
              contentPadding: EdgeInsets.all(8),
              hintText: 'รหัสผ่านเดิม',
              hintStyle: kHintTextStyle,
            ),
            obscureText: true,
            onChanged: (value) {
              setState(() {
                oldpassword = value;
              });
            },
          ),
        ),
        SizedBox(height: 10),
        Text(
          'รหัสผ่านใหม่',
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
              contentPadding: EdgeInsets.all(8),
              hintText: 'อย่างน้อย 6 ตัวอักษร',
              hintStyle: kHintTextStyle,
            ),
            obscureText: true,
            onChanged: (value) {
              setState(() {
                newpassword = value;
              });
            },
          ),
        ),
        SizedBox(height: 10),
        Text(
          'ยืนยันรหัสผ่านใหม่',
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
                contentPadding: EdgeInsets.all(8),
                hintText: 'อย่างน้อย 6 ตัวอักษร',
                hintStyle: kHintTextStyle),
            obscureText: true,
            onChanged: (value) {
              setState(() {
                newpasswordcf = value;
              });
            },
          ),
        )
      ],
    );
  }

  user_resetpassword(
    String uid,
    String phonenumber,
    String oldpassword,
    String newpassword,
  ) async {
    var ip = ip_host.host;
    var url = ip + 'api/user/resetpassword';
    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8"
    };
    var json = jsonEncode(<String, String>{
      "_id": uid,
      "phonenumber": phonenumber,
      "password": oldpassword,
      "newPassword": newpassword,
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

  Widget _buildButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        onPressed: () async {
          var res;
          if (oldpassword == null &&
              newpassword == null &&
              newpasswordcf == null) {
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
          } else {
            if (newpassword == newpasswordcf) {
              res = await user_resetpassword(
                  widget.userID, widget.phonenumber, oldpassword, newpassword);
              print(res);
              if (res['status'] == 'success') {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        'เปลี่ยนรหัสผ่านสำเร็จ',
                        style: kLabelStyle,
                      ),
                      content: Text(
                        'กลับสู่หน้าข้อมูลผู้ใช้',
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
                Navigator.pop(context);
              } else {
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
              }
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      'ข้อผิดพลาด',
                      style: kLabelStyle,
                    ),
                    content: Text(
                      'รหัสผ่านใหม่ไม่ตรงกัน',
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
          'ยืนยัน',
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 1.5,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          'เปลี่ยนรหัสผ่าน',
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
