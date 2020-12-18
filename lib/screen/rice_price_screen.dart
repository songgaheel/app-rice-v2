import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:v2/data/apiData.dart';
import 'package:v2/style/constants.dart';
import 'package:buddhist_datetime_dateformat/buddhist_datetime_dateformat.dart';

import 'price_screen.dart';

class RicePriceScreen extends StatefulWidget {
  final dynamic price;
  final dynamic vname;
  final dynamic vcode;

  const RicePriceScreen({
    Key key,
    this.price,
    this.vname,
    this.vcode,
  }) : super(key: key);
  @override
  _RicePriceScreenState createState() => _RicePriceScreenState();
}

class _RicePriceScreenState extends State<RicePriceScreen> {
  DateTime _monthStart;
  DateTime _monthStop;
  String _varietieselected;
  dynamic _price;
  dynamic _varietie;
  dynamic _varietieCode;
  final today = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('varieties filter');
    _price = widget.price;
    _varietie = widget.vname;
    _varietieCode = widget.vcode;
    //_varietiesEncode();
  }

  _varietiesEncode() {
    _varietie = Map.fromIterable(_price,
        key: (varieties) => varieties['type'] as int,
        value: (varieties) => varieties['name'] as String);

    _varietieCode = Map.fromIterable(_price,
        key: (varieties) => varieties['name'] as String,
        value: (varieties) => varieties['type'] as int);
  }

  price_interval(dynamic vID, dynamic startMonth, dynamic stopMonth) async {
    var ip = ip_host.host;
    var url = ip + 'api/farm/ricepricepredict/interval';
    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8"
    };

    var json = jsonEncode(<String, dynamic>{
      "rice_ID": vID,
      "startMonth": startMonth,
      "Endmonth": stopMonth,
    });

    print(json);
    final Response response = await post(
      url,
      headers: headers,
      body: json,
    );

    if (response.statusCode == 200) {
      var res = response.body;
      var ret = jsonDecode(res);
      //print(ret);
      return ret;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Widget _buildFarmLocationTB() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ช่วงเวลาที่ต้องการดูราคา',
          style: kLabelStyle,
        ),
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FlatButton(
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate:
                      _monthStart == null ? DateTime.now() : _monthStart,
                  firstDate: DateTime(2010),
                  lastDate: DateTime(2021),
                ).then((date) {
                  setState(
                    () {
                      _monthStart = date;
                    },
                  );
                });
              },
              child: Container(
                alignment: Alignment.center,
                decoration: kBoxDecorationStyle,
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 10),
                      Text(
                        _monthStart == null
                            ? 'เดือนเริ่มต้น'
                            : DateFormat('MMM yyyy', 'th')
                                .formatInBuddhistCalendarThai(_monthStart),
                        style: kHintTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            FlatButton(
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: _monthStop == null ? DateTime.now() : _monthStop,
                  firstDate: DateTime(2010),
                  lastDate: DateTime(2022),
                ).then((date) {
                  setState(
                    () {
                      _monthStop = date;
                    },
                  );
                });
              },
              child: Container(
                alignment: Alignment.center,
                decoration: kBoxDecorationStyle,
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 10),
                      Text(
                        _monthStop == null
                            ? 'เดือนสิ้นสุด'
                            : DateFormat('MMM yyyy', 'th')
                                .formatInBuddhistCalendarThai(_monthStop),
                        style: kHintTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _selectVarieties() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'เลือกชนิดข้าว',
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
            value: _varietieselected,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 42,
            underline: SizedBox(),
            isExpanded: true,
            onChanged: (String newValue) {
              setState(() {
                _varietieselected = newValue;
              });
            },
            items: _varietie.values.toList().map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: EdgeInsets.only(left: 14),
                    child: Text(
                      value,
                      style: kTextStyle,
                    ),
                  ),
                );
              },
            ).toList(),
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
        onPressed: () async {
          if (_monthStart != null &&
              _monthStop != null &&
              _varietieselected != null) {
            var dateformatt = DateFormat('yyyy-MM-01' 'T' 'HH:mm:ss.sss');
            var smonth = dateformatt.format(_monthStart) + 'Z';
            var emonth = dateformatt.format(_monthStop) + 'Z';
            print(smonth);
            print(emonth);
            print(_varietieCode[_varietieselected]);
            var res = await price_interval(
                _varietieCode[_varietieselected], smonth, emonth);
            print(res);
            if (res['status'] == 'success') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PriceScreen(
                    rice_price_predict: res['rice_price_predict'],
                  ),
                ),
              );
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      'ข้อผิดพลาด',
                      style: kLabelStyle,
                    ),
                    content: Text(res['msg']),
                    actions: [
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
                  );
                },
              );
            }
            //Navigator.pushNamed(context, '/rice-price');
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    'ข้อผิดพลาด',
                    style: kLabelStyle,
                  ),
                  content: Text('กรุณากรอกข้อมูลให้ครบ'),
                  actions: [
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
                );
              },
            );
          }
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

  Widget _priceMonth() {
    if (_price.length > 0) {
      return Scrollbar(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _price.length,
          itemBuilder: (context, i) {
            return Card(
              child: FlatButton(
                onPressed: () async {},
                child: Container(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          _price[i]['name'],
                          style: kTextStyle,
                        ),
                        subtitle: Text(
                          'ราคา ${_price[i]['price']['Value']} ${_price[i]['price']['Unit']}',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    } else {
      return Text('ไม่มีข้อมูลราคาข้าว');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    DateFormat('ราคาข้าว\nประจำเดือน MMMM ปี yyyy', 'th')
                        .formatInBuddhistCalendarThai(
                            DateTime.parse(_price[0]['month'])),
                    style: kLabelStyle,
                  ),
                ),
              ),
              Expanded(child: _priceMonth()),
              _buildFarmLocationTB(),
              SizedBox(
                height: 10,
              ),
              _selectVarieties(),
              _buildRegisterButton(),

              /*Expanded(child: Text('ราคาข้าวประจำเดือน' + 'พฤศจิกายน 2563')),
              Expanded(child: _listVarietiesFilter()),*/
            ],
          ),
        ),
      ),
    );
  }
}
