import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:v2/data/EvalData.dart';
import 'package:v2/data/EvalResultData.dart';
import 'package:v2/data/apiData.dart';
import '../data/TimelineData.dart';
import '../style/constants.dart';
import 'main_screen.dart';

class TimelinePage extends StatefulWidget {
  //result
  final dynamic result;
  //evaluate data
  final dynamic dateTime;
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

  final dynamic cost;
  final dynamic product;
  final dynamic price;
  final dynamic profit;

  const TimelinePage({
    Key key,
    this.result,
    this.farmName,
    this.dateTime,
    this.options,
    this.varietieselected,
    this.uid,
    this.farm,
    this.farmSize,
    this.formattedAddress,
    this.province,
    this.latt,
    this.long,
    this.cost,
    this.product,
    this.price,
    this.profit,
  }) : super(key: key);
  @override
  _TimelinePageState createState() => _TimelinePageState();
}

Map provinceCode = {
  "กรุงเทพมหานคร": 1,
  "นนทบุรี": 2,
  "พระนครศรีอยุธยา": 3,
  "ฉะเชิงเทรา": 4,
  "ราชบุรี": 5,
  "นครปฐม": 6,
};

// ignore: non_constant_identifier_names
fram_create_tl({
  String uid,
  String farmName,
  double farmSize,
  String address,
  dynamic province,
  double latt,
  double long,
  dynamic dateTime,
  dynamic option,
  dynamic varietie,
  dynamic tlFuture,
  dynamic cost,
  dynamic product,
  dynamic price,
  dynamic profit,
  dynamic costS,
  dynamic productS,
  dynamic priceS,
  dynamic profitS,
}) async {
  var ip = ip_host.host;
  var url = ip + 'api/farm/create/tl';
  Map<String, String> headers = {
    "Content-type": "application/json; charset=UTF-8"
  };
  var dateformatt = DateFormat('yyyy-MM-dd' 'T' 'HH:mm:ss.sss');
  var sdate = dateformatt.format(dateTime) + 'Z';
  print(sdate.toString());
  var json = jsonEncode(<String, dynamic>{
    "uid": uid,
    "name": farmName,
    "size": farmSize,
    "formattedAddress": address,
    "province": province,
    "latt": latt, // or String
    "long": long, // or String
    "varieties": varietie,
    "cost": cost,
    "product": product,
    "price": price,
    "profit": profit,
    "costS": costS,
    "productS": productS,
    "priceS": priceS,
    "profitS": profitS,
    "startDate": sdate.toString(),
    "timelineFuture": tlFuture,
  });

  //print(json);
  final Response response = await post(
    url,
    headers: headers,
    body: json,
  );

  if (response.statusCode == 200) {
    var res = response.body;
    //print(res);
    return jsonDecode(res);
  } else {
    //print('Request failed with status: ${response.statusCode}.');
  }
}

class _TimelinePageState extends State<TimelinePage> {
  String farmName;
  String variety;
  String farmlocation;
  dynamic _result;
  Map<int, String> _codes = {
    1: 'เริ่มปลูกข้าว',
    2: 'เก็บเกี่ยวข้าว',
    3: 'ให้น้ำ 3 cm',
    4: 'ให้น้ำ 7 cm',
    5: 'ให้น้ำ 10 cm',
    6: 'ระบายน้ำออก',
    7: 'กำจัดวัชพืช',
    8: 'ตัดพันธ์ปน',
    9: 'ใส่ปุ๋ยสูตร 16-20-0',
    10: 'ใส่ปุ๋ยสูตร 21-0-0',
    11: 'ระวัโรคไหม้ข้าว',
    12: 'ระวังเพลี้ยกระโดดสีน้ำตาล',
    13: 'เตือนภัยแล้ง',
    14: 'เตือนภัยน้ำท่วม',
  };

  String _uid;
  dynamic _farm;
  String _farmName;
  double _farmSize;
  String _formattedAddress;
  dynamic _province;
  dynamic _latt; // or String
  dynamic _long; // or String
  dynamic tl;
  dynamic _dateTime;

  var _cost;
  var _product;
  var _price;
  var _profit;
  var _costS;
  var _productS;
  var _priceS;
  var _profitS;

  _init_data() async {
    var uid = await _uidkeeper();
    var _initData = _get_init_data(uid);
    return _initData;
  }

  _get_init_data(String uid) async {
    var ip = ip_host.host;
    var url = ip + 'api/init/data';
    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8"
    };
    var json = jsonEncode(<String, dynamic>{
      "_id": uid,
    });

    //print(json);
    final Response response = await post(
      url,
      headers: headers,
      body: json,
    );

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      //print(res);
      return res;
    } else {
      //print('Request failed with status: ${response.statusCode}.');
    }
  }

  _uidkeeper() async {
    logindata = await SharedPreferences.getInstance();
    var uid = logindata.getString('uid');
    print(uid);
    return uid;
  }

  void _resetAndOpenPage() async {
    var ret = await fram_create_tl(
      uid: _uid,
      farmName: _farmName,
      farmSize: _farmSize,
      address: _formattedAddress,
      province: provinceCode[_province],
      latt: _latt,
      long: _long,
      dateTime: _dateTime,
      option: options,
      varietie: _result['ID'],
      tlFuture: tl,
      cost: _cost,
      product: _product,
      price: _price,
      profit: _profit,
      costS: _costS,
      productS: _productS,
      priceS: _priceS,
      profitS: _profitS,
    );
    print(ret['status']);
    var initData = await _init_data();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => MainScreen(
          initData: initData,
        ),
      ),
      ModalRoute.withName('/home'),
    );
  }

  @override
  void initState() {
    super.initState();
    print('create farm timeline result screen');
    _result = widget.result;
    //print(_result);
    variety = _result['name'];
    tl = _result['tl'];
    //print(tl);

    _cost = _result['cost']['value'];
    _product = _result['product']['value'];
    _price = _result['price']['value'];
    _profit = _result['profit']['value'];
    _costS = _result['cost']['status'];
    _productS = _result['product']['status'];
    _priceS = _result['price']['status'];
    _profitS = _result['profit']['status'];

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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ผลการวิเคราะห์การปลูก',
          style: kLabelStyle,
        ),
        backgroundColor: colorTheam,
      ),
      body: timelineModel(TimelinePosition.Left),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 5,
        onPressed: () async {
          if (_farmName != null && _farmSize != null) {
            _resetAndOpenPage();
          } else {
            var initData = await _init_data();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => MainScreen(
                  initData: initData,
                ),
              ),
              ModalRoute.withName('/home'),
            );
          }
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        icon: Icon(Icons.check),
        label: Text(
          'เสร็จสิ้น',
          style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.5,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  timelineModel(TimelinePosition position) => Timeline.builder(
      itemBuilder: centerTimelineBuilder,
      itemCount: tl.length,
      physics: BouncingScrollPhysics(),
      position: TimelinePosition.Left);

  TimelineModel centerTimelineBuilder(BuildContext context, int i) {
    final tls = tl[i];
    return TimelineModel(
      Card(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.landscape),
                title: Text(
                  _farmName == null
                      ? 'พันธุ์ข้าว: ' + variety
                      : 'ที่นา: ' + _farmName,
                  style: kTextStyle,
                ),
                subtitle: Text(
                  DateFormat('dd MMMM yyyy')
                      .format(DateTime.parse(tls['activitiesDate'])),
                  style: kTextStyle,
                ),
              ),
              if (tls['activities'] != null)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: tls['activities'].length,
                  itemBuilder: (context, j) {
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        _codes[tls['activities'][j]['code']],
                        style: kTextStyle,
                      ),
                    );
                  },
                ),
              if (tls['bugs'] != null)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: tls['bugs'].length,
                  itemBuilder: (context, j) {
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        _codes[tls['bugs'][j]['code']],
                        style: kTextStyle,
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
      isFirst: i == 0,
      isLast: i == modeltimeline.length,
      iconBackground: Colors.greenAccent,
      icon: Icon(Icons.star),
    );
  }
}
