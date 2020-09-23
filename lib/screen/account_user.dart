import 'package:flutter/material.dart';
import 'package:v2/style/constants.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  Widget _buildFarmLocationDD() {
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
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              enabled: false,
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(
                left: 14,
              ),
              hintText: 'กรุงเทพ หนองจอก',
              hintStyle: kHintTextStyle,
            ),
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
          'ชื่อผู้ใช้',
          style: kLabelStyle,
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60,
          child: TextField(
            enabled: false,
            keyboardType: TextInputType.name,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 14),
                hintText: 'นายข้าว หอมมะลิ',
                hintStyle: kHintTextStyle),
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
          child: TextField(
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 14),
                hintText: '0889997777',
                hintStyle: kHintTextStyle),
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
          'ข้อมูลผู้ใช้',
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
                vertical: 60,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildFarmNameTB(),
                  SizedBox(height: 10),
                  _buildFarmLocationDD(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
