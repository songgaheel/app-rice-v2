import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:v2/data/apiData.dart';
import '../style/constants.dart';
import 'event_screen.dart';
import 'init_screen.dart';
import 'main_screen.dart';
import 'package:google_place/google_place.dart' as googleLocation;

import 'package:buddhist_datetime_dateformat/buddhist_datetime_dateformat.dart';

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

Future _loadCharacterData() async {
  String data = await rootBundle.loadString("data/feed.json");
  final timeline = json.decode(data);

  /*final jsonResult = CharacterData.fromJson(parsed);
  print(jsonResult.name);
  print(jsonResult.image);
  print(jsonResult.description);*/

  return timeline;
}

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
    "timeline": tlFuture,
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

  String _uid;
  dynamic _farm;
  String _farmName;
  double _farmSize;
  String _formattedAddress;
  dynamic _province;
  dynamic _latt; // or String
  dynamic _long; // or String
  dynamic tl1;
  dynamic tl2;
  dynamic tl;
  dynamic _dateTime;

  var formatter = DateFormat('dd MMMM yyyy', 'th');

  var _cost;
  var _product;
  var _price;
  var _profit;
  var _costS;
  var _productS;
  var _priceS;
  var _profitS;
  var province;
  LocationData _myLocation;
  var googlePlace =
      googleLocation.GooglePlace("AIzaSyAgIlwWm-g9ucv6fiYXLTq9Jj9G9zqrmnY");

  void _initLocation() async {
    var location = new Location();
    try {
      _myLocation = await location.getLocation();
    } on Exception {
      _myLocation = null;
    }
  }

  _init_data() async {
    var uid = await _uidkeeper();
    await _initLocation();
    var political = await googlePlace.search.getNearBySearch(
      googleLocation.Location(
        lat: _myLocation.latitude,
        lng: _myLocation.longitude,
      ),
      100,
      language: "th",
      type: 'sublocality_level_1,sublocality,locality,political',
    );
    province = political.results.first.name;
    var _initData = _get_init_data(uid, province);
    return _initData;
  }

  _get_init_data(String uid, String province) async {
    var ip = ip_host.host;
    var url = ip + 'api/init/data';
    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8"
    };
    var json = jsonEncode(<String, dynamic>{"_id": uid, "Province": province});

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

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'สร้างที่นาสำเร็จ',
            style: kLabelStyle,
          ),
          /*content: Text(
                        'แชร์สำเร็จ',
                        style: kTextStyle,
                      ),*/
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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => InitScreen(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print('create farm timeline result screen');
    _result = widget.result;
    //print(_result);
    variety = _result['name'];
    tl = _result['timeline'];

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
    initializeDateFormatting();
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
      backgroundColor: Colors.grey[300],
      body: timelineModel(TimelinePosition.Left),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 5,
        onPressed: () async {
          print(_farmName);
          print(_farmSize);
          if (_farmName != null && _farmSize != null) {
            _resetAndOpenPage();
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => InitScreen(),
              ),
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
      /*bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        'ข้อผิดพลาด',
                        style: kLabelStyle,
                      ),
                      content: Text(
                        'แชร์สำเร็จ',
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
              },
            ),
          ],
        ),
      ),*/
    );
  }

  Widget _imageTimeline(dynamic activities) {
    //print(activities);
    var activity = List();
    double h;
    for (var item in activities) {
      for (var item in item['array_code']) {
        if (item['picture'] == 'red' ||
            item['picture'] == 'xx' ||
            item['picture'] == 'r' ||
            item['picture'] == null) {
          h = 0;
        } else {
          h = 300;
        }
        print('item');
        print(item);
        activity.add(item);
      }
    }
    print('activity');
    print(activity);

    return CarouselSlider.builder(
      itemCount: activity.length,
      itemBuilder: (context, i) {
        if (activity[i]['picture'] == 'red' ||
            activity[i]['picture'] == 'xx' ||
            activity[i]['picture'] == 'r' ||
            activity[i]['picture'] == null) {
          return SizedBox.shrink();
        } else {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Image(
                  height: 200,
                  fit: BoxFit.fill,
                  image: NetworkImage(activity[i]['picture']),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  color: Colors.blue,
                  child: Text(
                    '${i + 1}/${activity.length}',
                  ),
                ),
              ),
            ],
          );
        }
      },
      options: CarouselOptions(
        height: h,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: false,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget _activitiesTimeline(dynamic activities) {
    var activity = '';
    var warnning = '';

    for (var i = 0; i < activities.length; i++) {
      for (var j = 0; j < activities[i]['array_code'].length; j++) {
        if (100 < activities[i]['array_code'][j]['activityCode'] &&
            activities[i]['array_code'][j]['activityCode'] < 200)
          activity = activity +
              (j + 1).toString() +
              '. ' +
              activities[i]['array_code'][j]['activity'] +
              '\n';
        if (200 < activities[i]['array_code'][j]['activityCode'] &&
            activities[i]['array_code'][j]['activityCode'] < 300)
          warnning = warnning +
              (j + 1).toString() +
              '. ' +
              activities[i]['array_code'][j]['activity'] +
              '\n';
      }
    }

    if (activity == '') {
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          //color: Colors.red,
          padding: EdgeInsets.all(14),
          child: ReadMoreText(
            'แจ้งเตือน\n$warnning',
            trimLines: 5,
            colorClickableText: Colors.blue,
            trimMode: TrimMode.Line,
            trimCollapsedText: '...เพิ่มเติม',
            trimExpandedText: ' ซ่อน',
            style: kTextStyle,
          ),
        ),
      );
    } else if (warnning == '') {
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          //color: Colors.red,
          padding: EdgeInsets.all(14),
          child: ReadMoreText(
            'กิจกรรม\n$activity',
            trimLines: 5,
            colorClickableText: Colors.blue,
            trimMode: TrimMode.Line,
            trimCollapsedText: '...เพิ่มเติม',
            trimExpandedText: ' ซ่อน',
            style: kTextStyle,
          ),
        ),
      );
    } else {
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          //color: Colors.red,
          padding: EdgeInsets.all(14),
          child: ReadMoreText(
            'กิจกรรม\n$activity\nแจ้งเตือน\n$warnning',
            trimLines: 5,
            colorClickableText: Colors.blue,
            trimMode: TrimMode.Line,
            trimCollapsedText: '...เพิ่มเติม',
            trimExpandedText: ' ซ่อน',
            style: kTextStyle,
          ),
        ),
      );
    }
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
                leading: tls['farmPicture'] == null
                    ? Material(
                        elevation: 4.0,
                        shape: CircleBorder(),
                        clipBehavior: Clip.hardEdge,
                        color: Colors.transparent,
                        child: Ink.image(
                          image: AssetImage('assets/glas.png'),
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                          child: InkWell(
                            onTap: () {},
                          ),
                        ),
                      )
                    : IconButton(
                        icon: Icon(
                          Icons.landscape,
                          size: 40,
                        ),
                        onPressed: () {},
                      ),
                title: Text(
                  _farmName == null ? 'พันธุ์ข้าว: ' + variety : _farmName,
                  style: kTextStyle,
                ),
                subtitle: Text(
                  formatter.formatInBuddhistCalendarThai(
                      DateTime.parse(tls['activitiesDate'])),
                  style: kTextStyle,
                ),
              ),
              _imageTimeline(tls['activities']),
              Row(
                children: [
                  Text(
                    tls['activityLenght'] != 0
                        ? '${tls['activityLenght']} กิจกรรม '
                        : '',
                    style: kTextStyle,
                  ),
                  Text(
                    tls['warningLenght'] != 0
                        ? '${tls['warningLenght']} แจ้งเตือน'
                        : '',
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  ),
                ],
              ),
              _activitiesTimeline(tls['activities']),
              if (tls['caption'] != null)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    //color: Colors.red,
                    child: ReadMoreText(
                      tls['caption'] != null ? tls['caption'] : '',
                      trimLines: 1,
                      colorClickableText: Colors.blue,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: '...เพิ่มเติม',
                      trimExpandedText: ' ซ่อน',
                      style: kTextStyle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      isFirst: i == 0,
      isLast: i == tl.length,
      iconBackground: tls['warningLenght'] == 0 ? Colors.green : Colors.amber,
      icon: tls['warningLenght'] == 0
          ? Icon(
              Icons.landscape,
              color: Colors.white,
              size: 40,
            )
          : Icon(
              Icons.warning,
              color: Colors.white,
              size: 40,
            ),
    );
  }
}
