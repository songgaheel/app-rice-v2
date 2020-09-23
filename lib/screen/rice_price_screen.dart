import 'package:flutter/material.dart';
import 'package:v2/style/constants.dart';

class RicePriceScreen extends StatefulWidget {
  @override
  _RicePriceScreenState createState() => _RicePriceScreenState();
}

class _RicePriceScreenState extends State<RicePriceScreen> {
  DateTime _dateTime;
  String _myActivity;
  Widget _buildFarmLocationTB() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ช่วงเวลาที่ต้องการดูราคา',
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
                        ? 'กรุณากำหนดวัน'
                        : _dateTime.toString(),
                    hintStyle: kHintTextStyle),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _selectVarieties() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'เลือกพันธุ์',
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
                'เลือกทั้งหมด',
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

  Widget _buildRegisterButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5,
        onPressed: () {
          Navigator.pushNamed(context, '/rice-price');
        },
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: Colors.white,
        child: Text(
          'ดูราคาข้าว',
          style: kTextStyle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _buildFarmLocationTB(),
              SizedBox(
                height: 10,
              ),
              _selectVarieties(),
              _buildRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }
}
