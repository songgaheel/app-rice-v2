import 'package:flutter/material.dart';

import '../style/constants.dart';

class EvalResultProfit extends StatefulWidget {
  @override
  _EvalResultProfitState createState() => _EvalResultProfitState();
}

class _EvalResultProfitState extends State<EvalResultProfit> {
  String _myActivity;

  @override
  void initState() {
    super.initState();
  }

  Widget _selectVarieties() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'พันธุ์ที่แนะนำ',
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
                'กข 105',
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
              'กข 105',
              'กข 10',
              'กข 15',
              'กข 20',
              'กข 30',
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
            style: kTextStyle,
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

  Widget _buildButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5,
        onPressed: () =>
            Navigator.pushNamed(context, '/NewFeed/Eval/Result/Timeline'),
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
          style: kTextStyle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ผลการวิเคราะห์ผลผลิต',
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
                  _selectVarieties(),
                  _buildFarmNameTB(),
                  SizedBox(
                    height: 10,
                  ),
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
