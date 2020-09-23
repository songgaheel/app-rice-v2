import 'package:flutter/material.dart';

import '../style/constants.dart';
import 'create_farm_result_profit.dart';

class FarmEvaluateVarityScreen extends StatefulWidget {
  @override
  _FarmEvaluateVarityScreen createState() => _FarmEvaluateVarityScreen();
}

class _FarmEvaluateVarityScreen extends State<FarmEvaluateVarityScreen> {
  String _myActivity;
  final formKey = new GlobalKey<FormState>();

  DateTime _dateTime;

  @override
  void initState() {
    super.initState();
    //_dateTime = DateTime.now();
  }

  Widget _buildOptionDD() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ตัวเลือกการประเมิน',
          style: kLabelStyle,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.center,
          decoration: kBoxDecorationStyle,
          // dropdown below..
          child: DropdownButton<String>(
            hint: Padding(
              padding: const EdgeInsets.only(left: 14),
              child: Text(
                'กรุณาเลือก',
                style: kHintTextStyle,
              ),
            ),
            value: _myActivity,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 42,
            underline: SizedBox(),
            isExpanded: true,
            onChanged: (String newValue) {
              setState(() {
                _myActivity = newValue;
              });
            },
            items: <String>[
              'พันธ์ที่ให้กำไรสูงสุด',
              'พันธ์ที่ให้ต้นทุนต่ำสุด',
              'พันธุ์ที่เลือก',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: kTextStyle,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildFarmLocationTB() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'วันเริ่มต้นทำนา',
          style: kLabelStyle,
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 100,
          child: Column(
            children: [
              FlatButton(
                child: Icon(
                  Icons.calendar_today,
                  color: Colors.grey,
                ),
                onPressed: () {
                  showDatePicker(
                          context: context,
                          initialDate:
                              _dateTime == null ? DateTime.now() : _dateTime,
                          firstDate: DateTime(2001),
                          lastDate: DateTime(2021))
                      .then((date) {
                    setState(() {
                      _dateTime = date;
                    });
                  });
                },
              ),
              TextField(
                enabled: false,
                keyboardType: TextInputType.datetime,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 14),
                    hintText: _dateTime == null
                        ? 'กรุณากำหนดวันเริ่มต้นทำนา'
                        : _dateTime.toString(),
                    hintStyle: kHintTextStyle),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
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
            keyboardType: TextInputType.emailAddress,
            style: kTextStyle,
            decoration: InputDecoration(
                border: InputBorder.none,
                //contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.landscape,
                  color: Colors.grey,
                ),
                hintText: 'นาองครักษ์นครนายก',
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
            enabled: false,
            keyboardType: TextInputType.number,
            style: kTextStyle,
            decoration: InputDecoration(
                border: InputBorder.none,
                //contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.landscape,
                  color: Colors.grey,
                ),
                hintText: '11.02 ไร่',
                hintStyle: kHintTextStyle),
          ),
        ),
        SizedBox(height: 10),
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
            enabled: false,
            keyboardType: TextInputType.emailAddress,
            style: kTextStyle,
            decoration: InputDecoration(
                border: InputBorder.none,
                //contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.landscape,
                  color: Colors.grey,
                ),
                hintText: 'ภาคกลาง : นครนายก',
                hintStyle: kHintTextStyle),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5,
        onPressed: () {
          if (_myActivity != '') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EvalResultProfit(),
              ),
            );
          }
          print('ประเมิน');
        },
        padding: EdgeInsets.symmetric(
          horizontal: 40,
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
      appBar: AppBar(
        title: Text(
          'วิเคราะห์พันธุ์ข้าว',
          style: kLabelStyle,
        ),
        backgroundColor: colorTheam,
      ),
      body: Stack(
        children: [
          SizedBox(height: 10),
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
                  _buildOptionDD(),
                  SizedBox(height: 10),
                  _buildFarmLocationTB(),
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
