import 'package:flutter/material.dart';
import 'package:v2/style/constants.dart';

class FarmProfileProfit extends StatefulWidget {
  @override
  _FarmProfileProfitState createState() => _FarmProfileProfitState();
}

class _FarmProfileProfitState extends State<FarmProfileProfit> {
  @override
  void initState() {
    super.initState();
  }

  Widget _selectVarieties() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'พันธุ์ข้าว',
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
              hintText: 'กข 15',
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
        SizedBox(height: 10),
        Text(
          'ต้นทุน',
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
                //contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.thumb_down,
                  color: Colors.redAccent,
                ),
                hintText: '1000 บาท/ไร่',
                hintStyle: kHintTextStyle),
          ),
        ),
        SizedBox(height: 10),
        Text(
          'ผลผลิต',
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
                //contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.thumbs_up_down,
                  color: Colors.amber,
                ),
                hintText: '800 กก./ไร่',
                hintStyle: kHintTextStyle),
          ),
        ),
        SizedBox(height: 10),
        Text(
          'ราคาขาย',
          style: kLabelStyle,
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60,
          child: TextField(
            enabled: false,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                //contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.thumb_up,
                  color: Colors.green,
                ),
                hintText: '2000 บาท/ตัน',
                hintStyle: kHintTextStyle),
          ),
        ),
        SizedBox(height: 10),
        Text(
          'กำไร',
          style: kLabelStyle,
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60,
          child: TextField(
            enabled: false,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                //contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.thumbs_up_down,
                  color: Colors.amber,
                ),
                hintText: '600 บาท/ไร่',
                hintStyle: kHintTextStyle),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  _selectVarieties(),
                  _buildFarmNameTB(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
