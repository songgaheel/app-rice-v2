import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';

import '../style/constants.dart';
import 'create_farm_result_profit.dart';

class FarmEvaluateVarityScreen extends StatefulWidget {
  @override
  _FarmEvaluateVarityScreen createState() => _FarmEvaluateVarityScreen();
}

class _FarmEvaluateVarityScreen extends State<FarmEvaluateVarityScreen> {
  String _myActivity;
  String _myActivityResult;
  final formKey = new GlobalKey<FormState>();

  DateTime _dateTime;

  @override
  void initState() {
    super.initState();
    _myActivity = '';
    _myActivityResult = '';
    _dateTime = DateTime.now();
  }

  Widget _buildFarmNameTB() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Container(
          alignment: Alignment.center,
          decoration: kBoxDecorationStyle,
          child: DropDownFormField(
            titleText: 'ตัวเลือกการประเมิน',
            hintText: 'กรุณาเลือก',
            value: _myActivity,
            onSaved: (value) {
              setState(() {
                _myActivity = value;
              });
            },
            onChanged: (value) {
              setState(() {
                _myActivity = value;
              });
            },
            dataSource: [
              {
                "display": "พันธ์ที่ให้กำไรสูงสุด",
                "value": "Profit",
              },
              {
                "display": "พันธ์ที่ให้ต้นทุนต่ำสุด",
                "value": "Cost",
              },
              {
                "display": "พันธุ์ที่เลือก",
                "value": "Varieties",
              }
            ],
            textField: 'display',
            valueField: 'value',
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
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.landscape,
                  color: Colors.grey,
                ),
                hintText: 'ชื่อที่นา',
                hintStyle: kHintTextStyle),
          ),
        ),
        SizedBox(height: 30),
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
                keyboardType: TextInputType.datetime,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 6),
                    hintText: _dateTime == null
                        ? 'กรุณากำหนดวันเริ่มต้นทำนา'
                        : _dateTime.toString(),
                    hintStyle: kHintTextStyle),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ButtonBar(
        alignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            elevation: 5,
            onPressed: () {
              if (_myActivity == 'Profit') {
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ประเมินพันธุ์'),
        backgroundColor: colorTheam,
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.white,
                  Colors.white,
                  Colors.white,
                ],
                stops: [0.1, 0.4, 0.7, 0.9],
              ),
            ),
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
                  SizedBox(
                    height: 30,
                  ),
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
