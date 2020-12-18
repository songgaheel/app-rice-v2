import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:v2/data/apiData.dart';

import '../style/constants.dart';
import 'create_farm_result_profit.dart';
import 'loading.dart';

class FarmEvaluateVarityScreen extends StatefulWidget {
  final String uid;
  final dynamic farm;
  final String farmName;
  final double farmSize;
  final String formattedAddress;
  final dynamic province;
  final dynamic latt; // or String
  final dynamic long; // or String

  const FarmEvaluateVarityScreen({
    Key key,
    this.farmName,
    this.farmSize,
    this.formattedAddress,
    this.province,
    this.latt,
    this.long,
    this.uid,
    this.farm,
  }) : super(key: key);
  @override
  _FarmEvaluateVarityScreen createState() => _FarmEvaluateVarityScreen();
}

class _FarmEvaluateVarityScreen extends State<FarmEvaluateVarityScreen> {
  String _options;
  String _varietieselected;
  dynamic _varieties;
  Map<int, String> _varietie = {0: 'เลือกพันธ์ข้าว'};
  Map<String, int> _varietieCode = {'เลือกพันธ์ข้าว': 0};
  DateTime _dateTime;

  Map _optionCode = {
    'พันธุ์ข้าวที่ให้กำไรสูงสุด': 1,
    'พันธุ์ข้าวที่ให้ต้นทุนที่ดีที่สุด': 2,
    'เลือกพันธุ์ข้าวเอง': 3
  };

  Map provinceCode = {
    "กรุงเทพมหานคร": 1,
    "นนทบุรี": 2,
    "จังหวัดพระนครศรีอยุธยา": 3,
    "ฉะเชิงเทรา": 4,
    "ราชบุรี": 5,
    "นครปฐม": 6,
  };

  String _uid;
  dynamic _farm;
  String _farmName;
  double _farmSize;
  String _formattedAddress;
  dynamic _province;
  dynamic _latt; // or String
  dynamic _long; // or String

  var result;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    print('create farm eval screen');
    _varietie = {0: 'เลือกพันธ์ข้าว'};
    _farmName = widget.farmName;
    _farmSize = widget.farmSize;
    _uid = widget.uid;
    _farm = widget.farm;
    _formattedAddress = widget.formattedAddress;
    _province = widget.province;
    _latt = widget.latt; // or String
    _long = widget.long; // or String
    _uid = widget.uid;

    getvarieties();
    initializeDateFormatting();
  }

  getvarieties() async {
    _varieties = await varieties_get();

    _varietie = Map.fromIterable(_varieties,
        key: (varieties) => varieties['ID'] as int,
        value: (varieties) => varieties['rice_varieties_name'] as String);

    _varietieCode = Map.fromIterable(_varieties,
        key: (varieties) => varieties['rice_varieties_name'] as String,
        value: (varieties) => varieties['ID'] as int);
    print(_varietie.values.toList());
  }

  Widget _buildOptionSelector() {
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
            value: _options,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 42,
            underline: SizedBox(),
            isExpanded: true,
            onChanged: (String newValue) {
              setState(() {
                _options = newValue;
              });
            },
            items: <String>[
              'พันธุ์ข้าวที่ให้กำไรสูงสุด',
              'พันธุ์ข้าวที่ให้ต้นทุนที่ดีที่สุด',
              'เลือกพันธุ์ข้าวเอง',
            ].map<DropdownMenuItem<String>>(
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

  Widget _buildVarietiesSelector() {
    if (_options == 'เลือกพันธุ์ข้าวเอง') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'เลือกพันธุ์ข้าวที่ต้องการ',
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
          SizedBox(height: 10),
        ],
      );
    }
    return SizedBox(height: 10);
  }

  Widget _buildStartDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'วันเริ่มต้นทำนา',
          style: kLabelStyle,
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.center,
          decoration: kBoxDecorationStyle,
          height: 100,
          child: Padding(
            padding: EdgeInsets.all(14),
            child: FlatButton(
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: _dateTime == null ? DateTime.now() : _dateTime,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                ).then((date) {
                  setState(
                    () {
                      _dateTime = date;
                    },
                  );
                });
              },
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          _dateTime == null
                              ? 'กรุณากำหนดวันเริ่มต้นทำนา'
                              : DateFormat('dd MMMM yyyy', 'th')
                                  .format(_dateTime),
                          style: kHintTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 14.0),
                  child: Text(
                    _farmName,
                    style: kTextStyle,
                  ),
                ),
              ),
            ],
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
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 14.0),
                  child: Text(
                    _farmSize.toString() + ' ไร่',
                    style: kTextStyle,
                  ),
                ),
              ),
            ],
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
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 14.0),
                  child: Text(
                    _formattedAddress,
                    style: kTextStyle,
                  ),
                ),
              ),
            ],
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
        onPressed: () async {
          setState(() {
            loading = true;
          });
          var validateOption;
          var validateDate;
          _options == null ? validateOption = false : validateOption = true;
          _dateTime == null ? validateDate = false : validateDate = true;
          if (validateOption && validateDate) {
            var dateformatt = DateFormat('yyyy-MM-dd' 'T' 'HH:mm:ss.sss');
            var sdate = dateformatt.format(_dateTime) + 'Z';
            print(sdate);
            print('eval');
            result = await varieties_eval(
              provinceCode[_province] == null ? 1 : provinceCode[_province],
              _optionCode[_options],
              _varietieCode[_varietieselected] == null
                  ? 0
                  : _varietieCode[_varietieselected],
              sdate,
            );
            print(result);
            var resultList = jsonDecode(result) as List;
            setState(() {
              loading = false;
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EvalResultProfit(
                  result: resultList,
                  dateTime: _dateTime,
                  options: _options,
                  varietieselected: _varietieCode[_varietieselected],
                  uid: _uid,
                  farmName: _farmName,
                  farm: _farm,
                  farmSize: _farmSize,
                  formattedAddress: _formattedAddress,
                  province: _province,
                  latt: _latt,
                  long: _long,
                ),
              ),
            );
          } else {
            setState(() {
              loading = false;
            });
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    'ข้อผิดพลาด',
                    style: kLabelStyle,
                  ),
                  content: Text(
                    'กรุณากรอกข้อมูลให้ครบ',
                    style: kTextStyle,
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
                );
              },
            );
          }
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
          'เริ่มการประเมิน',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  varieties_eval(
    int location,
    int evaltype,
    int varieties,
    String startDate,
  ) async {
    var ip = ip_host.host;
    var url = ip + 'api/varieties/eval';
    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8"
    };
    var json = jsonEncode(<String, dynamic>{
      "province": location,
      "evaltype": evaltype,
      "varietie": varieties,
      "startDate": startDate.toString(),
    });
    final Response response = await post(
      url,
      headers: headers,
      body: json,
    );

    if (response.statusCode == 200) {
      var res = response.body;
      //print(res);
      return res;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  varieties_get() async {
    var ip = ip_host.host;
    var url = ip + 'api/varietie/get';
    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8"
    };

    print(json);
    final Response response = await get(
      url,
      headers: headers,
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

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
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
                        _buildOptionSelector(),
                        SizedBox(height: 10),
                        _buildVarietiesSelector(),
                        _buildStartDate(),
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
