import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:v2/data/apiData.dart';

import '../style/constants.dart';
import 'create_farm_result_timeline.dart';
import 'varieties_detail_secreen.dart';

class EvalResultProfit extends StatefulWidget {
  //result
  final dynamic result;
  //evaluate data
  final DateTime dateTime;
  final dynamic options; // code
  final dynamic varietieselected; //code

  // Farm data
  final String uid;
  final dynamic farm;
  final String farmName;
  final double farmSize;
  final String formattedAddress;
  final dynamic province;
  final dynamic latt; // or String
  final dynamic long; // or String

  const EvalResultProfit({
    Key key,
    this.result,
    this.farmName,
    this.dateTime,
    this.farmSize,
    this.uid,
    this.farm,
    this.formattedAddress,
    this.province,
    this.latt,
    this.long,
    this.options,
    this.varietieselected,
  }) : super(key: key);
  @override
  _EvalResultProfitState createState() => _EvalResultProfitState();
}

class _EvalResultProfitState extends State<EvalResultProfit> {
  var _cost;
  var _product;
  var _price;
  var _profit;
  var _costS;
  var _productS;
  var _priceS;
  var _profitS;
  dynamic _result;
  dynamic selectedVarieties;
  String _options;
  String _varietieselected;
  dynamic _varieties;
  dynamic _id;
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
    "พระนครศรีอยุธยา": 3,
    "ฉะเชิงเทรา": 4,
    "ราชบุรี": 5,
    "นครปฐม": 6,
  };

  Map<String, Icon> _status = {
    "1": Icon(
      Icons.thumb_down,
      color: Colors.redAccent,
    ),
    "2": Icon(
      Icons.thumbs_up_down,
      color: Colors.amber,
    ),
    "3": Icon(
      Icons.thumb_up,
      color: Colors.green,
    ),
  };

  String _uid;
  dynamic _farm;
  String _farmName;
  double _farmSize;
  String _formattedAddress;
  dynamic _province;
  dynamic _latt; // or String
  dynamic _long; // or String

  @override
  void initState() {
    super.initState();
    print('create farm profit result screen');
    _result = widget.result;
    _varieties = _result[0]['name'];
    _id = _result[0]['ID'];
    _cost = _result[0]['cost']['value'];
    _product = _result[0]['product']['value'];
    _price = _result[0]['price']['value'];
    _profit = _result[0]['profit']['value'];
    _costS = _result[0]['cost']['status'];
    _productS = _result[0]['product']['status'];
    _priceS = _result[0]['price']['status'];
    _profitS = _result[0]['profit']['status'];
    selectedVarieties = _result[0];

    /*print(selectedVarieties);
    print(_cost);
    print(_product);
    print(_price);
    print(_profit);*/

    _farmName = widget.farmName;
    _farmSize = widget.farmSize;
    _uid = widget.uid;
    _farm = widget.farm;
    _formattedAddress = widget.formattedAddress;
    _province = widget.province;
    _latt = widget.latt; // or String
    _long = widget.long; // or String
    _uid = widget.uid;
    _dateTime = widget.dateTime;
  }

  varieties_information(int vID) async {
    var ip = ip_host.host;
    var url = ip + 'api/init/ricevarityinfo';
    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8"
    };

    var json = jsonEncode(<String, dynamic>{
      "ID": vID,
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

  Widget _selectVarieties() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'พันธุ์ที่แนะนำ',
              style: kLabelStyle,
            ),
            IconButton(
              onPressed: () async {
                print(_id);
                var ret = await varieties_information(_id);

                if (ret['status'] == 'success') {
                  var riceVarityInfo = ret['riceVarityInfo'];
                  var disease4 = '';
                  var disease3 = '';
                  var disease2 = '';
                  var disease1 = '';
                  riceVarityInfo.forEach((key, value) {
                    if (key != 'rice_price_type' && key != 'ID') {
                      switch (value) {
                        case 4:
                          {
                            disease4 = disease4 + key.toString() + ' ';
                          }
                          break;
                        case 3:
                          {
                            disease3 = disease3 + key.toString() + ' ';
                          }
                          break;
                        case 2:
                          {
                            disease2 = disease2 + key.toString() + ' ';
                          }
                          break;
                        case 1:
                          {
                            disease1 = disease1 + key.toString() + ' ';
                          }
                          break;
                        default:
                      }
                    }
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VarietiesDetailScreen(
                        riceVarityInfo: riceVarityInfo,
                        disease4: disease4,
                        disease3: disease3,
                        disease2: disease2,
                        disease1: disease1,
                      ),
                    ),
                  );
                }
                if (ret['status'] == 'fail') {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          'ข้อผิดพลาด',
                          style: kLabelStyle,
                        ),
                        content: Text(
                          ret['msg'],
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
              icon: Icon(
                Icons.search,
              ),
            ),
          ],
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
                _varieties,
                style: kHintTextStyle,
              ),
            ),
            value: _varieties,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 42,
            underline: SizedBox(),
            isExpanded: true,
            onChanged: (String newValue) {
              setState(() {
                _varieties = newValue;
                for (var i = 0; i < _result.length; i++) {
                  if (_result[i]['name'] == _varieties) {
                    _id = _result[i]['ID'];
                    _cost = _result[i]['cost']['value'];
                    _product = _result[i]['product']['value'];
                    _price = _result[i]['price']['value'];
                    _profit = _result[i]['profit']['value'];
                    _costS = _result[i]['cost']['status'];
                    _productS = _result[i]['product']['status'];
                    _priceS = _result[i]['price']['status'];
                    _profitS = _result[i]['profit']['status'];
                    selectedVarieties = _result[i];
                  } else {}
                }
              });
            },
            items: _result.map<DropdownMenuItem<String>>(
              (value) {
                return DropdownMenuItem<String>(
                  value: value['name'],
                  child: Padding(
                    padding: EdgeInsets.only(left: 14),
                    child: Text(
                      value['name'],
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
              prefixIcon: _status[_costS],
              hintText: NumberFormat("#,###.##").format(_cost) + ' บาท/ไร่',
              hintStyle: kHintTextStyle,
            ),
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
                prefixIcon: _status[_productS],
                hintText:
                    NumberFormat("#,###.##").format(_product) + ' กก./ไร่',
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
                prefixIcon: _status[_priceS],
                hintText: NumberFormat("#,###.##").format(_price) + ' บาท/ตัน',
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
                prefixIcon: _status[_profitS],
                hintText: NumberFormat("#,###.##").format(_profit) + ' บาท/ไร่',
                hintStyle: kHintTextStyle),
          ),
        )
      ],
    );
  }

  Future _loadCharacterData() async {
    String data = await rootBundle.loadString("data/timeline.json");
    final timeline = json.decode(data);

    /*final jsonResult = CharacterData.fromJson(parsed);
  print(jsonResult.name);
  print(jsonResult.image);
  print(jsonResult.description);*/

    return timeline;
  }

  Widget _buildButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5,
        onPressed: () async {
          //print(selectedVarieties);
          var timeline = await _loadCharacterData();
          print('timeline');
          print(timeline);
          //selectedVarieties['timeline'] = timeline["timeline"];
          print('selectedVarieties');
          print(selectedVarieties);
          /*var tl = selectedVarieties['timeline'];
          var activities = tl[0]['activities'];
          var activities1 = activities[0]['array_code'];
          var activities2 = activities[1]['array_code'];
          var activity = [activities1, activities2].expand((x) => x).toList();

          print('tl');
          print(activity);*/

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TimelinePage(
                result: selectedVarieties,
                uid: _uid,
                farmName: _farmName,
                farm: _farm,
                farmSize: _farmSize,
                formattedAddress: _formattedAddress,
                province: _province,
                latt: _latt,
                long: _long,
                dateTime: _dateTime,
                options: _options,
                cost: _cost,
                product: _product,
                price: _price,
                profit: _profit,
              ),
            ),
          );

          /*Navigator.pushNamed(
            context,
            '/NewFeed/Eval/Result/Timeline',
            arguments: selectedVarieties,
          );*/
        },
        padding: EdgeInsets.symmetric(
          horizontal: 35,
          vertical: 15,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: Colors.white,
        child: Text(
          'ดูปฏิทินกิจกรรม',
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
