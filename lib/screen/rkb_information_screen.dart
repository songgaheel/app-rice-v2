import 'package:flutter/material.dart';
import 'package:v2/style/constants.dart';

class RKBInformationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        backgroundColor: colorTheam,
        title: Text(
          'RKB information',
          style: kLabelStyle,
        ),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'พันธุ์ข้าว',
                style: kTextStyle,
              ),
              TextField(
                keyboardType: TextInputType.number,
                style: kTextStyle,
                decoration: InputDecoration(
                    enabled: false,
                    contentPadding: EdgeInsets.only(top: 10),
                    hintText: 'กข 15',
                    hintStyle: kTextStyle),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'สภาพภูมิประเทศที่เหมาะสม',
                style: kTextStyle,
              ),
              TextField(
                keyboardType: TextInputType.number,
                style: kTextStyle,
                decoration: InputDecoration(
                    enabled: false,
                    contentPadding: EdgeInsets.only(top: 10),
                    hintText: 'ภาคกลาง ภาคอีสาน ภาคเหนือ',
                    hintStyle: kTextStyle),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'ผลผลิต',
                style: kTextStyle,
              ),
              TextField(
                keyboardType: TextInputType.number,
                style: kTextStyle,
                decoration: InputDecoration(
                    enabled: false,
                    contentPadding: EdgeInsets.only(top: 10),
                    hintText: '1000 กก./ไร่',
                    hintStyle: kTextStyle),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'ข้อดี',
                style: kTextStyle,
              ),
              TextField(
                keyboardType: TextInputType.number,
                style: kTextStyle,
                decoration: InputDecoration(
                    enabled: false,
                    contentPadding: EdgeInsets.only(top: 10),
                    hintText: 'ใช้น้ำน้อย ทนโรคและแมลงได้ดี',
                    hintStyle: kTextStyle),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'ข้อเสีย',
                style: kTextStyle,
              ),
              TextField(
                keyboardType: TextInputType.number,
                style: kTextStyle,
                decoration: InputDecoration(
                    enabled: false,
                    contentPadding: EdgeInsets.only(top: 10),
                    hintText: 'ระยะเวลาให้ผลผลิตนาน',
                    hintStyle: kTextStyle),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
