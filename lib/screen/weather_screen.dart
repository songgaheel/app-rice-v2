import 'package:flutter/material.dart';
import 'package:v2/style/constants.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // DateTime _dateTime;
  String _myActivity;
  /*Widget _buildFarmLocationTB() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ช่วงเวลาที่ต้องการดูสภา',
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
  }*/

  Widget _selectVarieties() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'ตำแหน่ง',
            style: kLabelStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.center,
            decoration: kBoxDecorationStyle,
            // dropdown below..
            child: DropdownButton<String>(
              hint: Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Text(
                  'ภาคกลาง : กรุงเทพ',
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
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            //_buildFarmLocationTB(),
            _selectVarieties(),
            SizedBox(
              height: 30,
            ),
            Container(
              child: Column(
                children: [
                  Icon(
                    Icons.wb_sunny,
                    size: 200,
                    color: Colors.yellow,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Sunny, 32 Celsius',
                    style: kLabelStyle,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
