import 'package:flutter/material.dart';
import 'package:v2/style/constants.dart';

class FarmInformaion extends StatefulWidget {
  @override
  _FarmInformaionState createState() => _FarmInformaionState();
}

class _FarmInformaionState extends State<FarmInformaion> {
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
          'ตำแหน่งที่นา',
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
              hintText: 'ภาคกลาง : กรุงเทพ',
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
          'ชื่อที่นา',
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
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.landscape,
                  color: Colors.grey,
                ),
                hintText: 'นาองครักษ์ นครนายก',
                hintStyle: kHintTextStyle),
          ),
        ),
        SizedBox(height: 10),
        Text(
          'ขนาดที่นา',
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
                enabled: false,
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.landscape,
                  color: Colors.grey,
                ),
                hintText: '11.1 ไร่',
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
