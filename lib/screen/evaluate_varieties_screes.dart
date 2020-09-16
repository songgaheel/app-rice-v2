import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';

import '../style/constants.dart';

class EvaluateVarityScreen extends StatefulWidget {
  @override
  _EvaluateVarityScreenState createState() => _EvaluateVarityScreenState();
}

class _EvaluateVarityScreenState extends State<EvaluateVarityScreen> {
  String _myActivity;
  String _myActivityResult;
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _myActivity = '';
    _myActivityResult = '';
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
                hintText: 'ภาค',
                hintStyle: kHintTextStyle),
          ),
        ),
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
                hintText: 'จังหวัด',
                hintStyle: kHintTextStyle),
          ),
        )
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
            onPressed: () => Navigator.pop(context),
            padding: EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 15,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            color: Colors.white,
            child: Text(
              'เสร็จสิ้น',
              style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 1.5,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          RaisedButton(
            elevation: 5,
            onPressed: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Text('ประเมิณ'))),
            padding: EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 15,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            color: Colors.white,
            child: Text(
              'ประเมิน',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
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
                  Text(
                    'ประเมิณพันธุ์',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
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
