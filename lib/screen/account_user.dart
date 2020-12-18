import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:v2/style/constants.dart';

import 'account_user_edit_info.dart';
import 'account_user_edit_password.dart';
import 'google_map_screen.dart';

class UserScreen extends StatefulWidget {
  final dynamic userID;
  final dynamic userName;
  final dynamic userAddress;
  final dynamic userPhonenumber;

  const UserScreen({
    Key key,
    this.userID,
    this.userName,
    this.userAddress,
    this.userPhonenumber,
  }) : super(key: key);
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
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
    //farmlocation = location;
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
          height: 60,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 14.0),
                  child: Text(
                    _userAddress,
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
            initialValue: _userName,
            enabled: false,
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

  void choiceAction(String choice) async {
    if (choice == 'แก้ไขข้อมูล') {
      print('แก้ไขข้อมูล');
      var ret = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserEditInforScreen(
            userID: _userID,
            userAddress: _userAddress,
            userName: _userName,
            userPhonenumber: _userPhonenumber,
          ),
        ),
      );
      print(ret);
      if (ret != null) {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserScreen(
              userID: ret['uid'],
              userAddress: ret['address']['formattedAddress'],
              userName: ret['name'],
              userPhonenumber: ret['phonenumber'],
            ),
          ),
        );
      }
    }
    if (choice == 'เปลี่ยนรหัสผ่าน') {
      print('เปลี่ยนรหัสผ่าน');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserEditPassScreen(
            userID: _userID,
            phonenumber: _userPhonenumber,
          ),
        ),
      );
    }
  }

  List<String> choices = <String>['แก้ไขข้อมูล', 'เปลี่ยนรหัสผ่าน'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          'ข้อมูลผู้ใช้',
          style: kLabelStyle,
        ),
        backgroundColor: colorTheam,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(
                    choice,
                    style: kTextStyle,
                  ),
                );
              }).toList();
            },
          )
        ],
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
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
