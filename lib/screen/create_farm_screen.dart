import 'package:flutter/material.dart';

import '../style/constants.dart';

class CreateFarmScreen extends StatefulWidget {
  @override
  _CreateFarmScreenState createState() => _CreateFarmScreenState();
}

class _CreateFarmScreenState extends State<CreateFarmScreen> {
  String _myActivity;
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
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.center,
          decoration: kBoxDecorationStyle,
          // dropdown below..
          child: DropdownButton<String>(
            hint: Padding(
              padding: EdgeInsets.only(left: 14.0),
              child: Text(
                'กรุณาเลือกตำแหน่ง',
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
              'ภาคกลาง : กรุงเทพมหานคร',
              'ภาคกลาง : นครนายก',
              'ภาคกลาง : ปทุมธานี',
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
            keyboardType: TextInputType.name,
            style: kTextStyle,
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.landscape,
                  color: Colors.grey,
                ),
                hintText: 'ตั้งชื่อให้ที่นาของคุณ',
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
            style: kTextStyle,
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.landscape,
                  color: Colors.grey,
                ),
                hintText: 'ไร่',
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
      child: RaisedButton(
        elevation: 5,
        onPressed: () => Navigator.pushNamed(context, '/NewFeed/Eval'),
        padding: EdgeInsets.symmetric(
          horizontal: 35,
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
              letterSpacing: 1.5,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'สร้างที่นาใหม่',
          style: kLabelStyle,
        ),
        backgroundColor: colorTheam,
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    'บันทึกข้อมูลที่นา',
                    style: kLabelStyle,
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
                ),
              );
            },
          ),
        ],
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
                  _buildFarmLocationDD(),
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
