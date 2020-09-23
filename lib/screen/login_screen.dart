import '../style/constants.dart';

import 'main_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //bool _remenberMe = false;
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
            keyboardType: TextInputType.emailAddress,
            style: kTextStyle,
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.vpn_key,
                  color: Colors.grey,
                ),
                hintText: 'กรอกรหัสผ่าน',
                hintStyle: kHintTextStyle),
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
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.phone,
                  color: Colors.grey,
                ),
                hintText: 'หมายเลขโทรศัพท์',
                hintStyle: kHintTextStyle),
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
        onPressed: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
        ),
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

  Widget _buildRegisterButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5,
        onPressed: () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainScreen())),
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
