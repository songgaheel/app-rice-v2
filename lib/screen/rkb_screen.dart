import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:v2/data/apiData.dart';
import 'package:v2/style/constants.dart';

import 'varieties_filter_screen.dart';

class RKBScreen extends StatefulWidget {
  @override
  _RKBScreenState createState() => _RKBScreenState();
}

class _RKBScreenState extends State<RKBScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              /*Container(
                alignment: Alignment.centerLeft,
                decoration: kBoxDecorationStyle,
                height: 60,
                child: TextField(
                  keyboardType: TextInputType.text,
                  style: kTextStyle,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      //contentPadding: EdgeInsets.only(left: 14),
                      prefixIcon: FlatButton(
                        onPressed: () {
                          print('search');
                          Navigator.pushNamed(context, '/rkb/information');
                        },
                        child: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                      ),
                      hintStyle: kHintTextStyle),
                ),
              ),*/
              Card(
                child: FlatButton(
                  onPressed: () async {
                    print('list all varieties');
                    var ret = await varieties_information(0);
                    //print(ret);
                    if (ret['status'] == 'success') {
                      for (var item in ret['riceVarityInfo']) {
                        print(item);
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VarietiesFilter(
                            varieties: ret['riceVarityInfo'],
                          ),
                        ),
                      );
                    } else {
                      print(ret['status']);
                      print(ret['msg']);
                    }
                    //Navigator.pushNamed(context, '/rkb/information');
                  },
                  child: Container(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.landscape,
                            size: 40,
                          ),
                          title: Text(
                            'องค์ความรู้เรื่องข้าว',
                            style: kTextStyle,
                          ),
                          subtitle: Text(
                            'คุณสมบัติของพันธุ์ข้าว',
                            style: kTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              /*Card(
                child: FlatButton(
                  onPressed: () {
                    print('โรค แมลง และศัตรูพืช');
                    Navigator.pushNamed(context, '/rkb/information');
                  },
                  child: Container(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.bug_report),
                          title: Text(
                            'โรค แมลง และศัตรูพืช',
                            style: kTextStyle,
                          ),
                          subtitle: Text(
                            'วิธีป้องกัน และแก้ไขปัญหาเรื่อง โรค แมลง และศัตรูพืช',
                            style: kTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                child: FlatButton(
                  onPressed: () {
                    print('เทคโนโลยีการผลิตข้าว');
                    Navigator.pushNamed(context, '/rkb/information');
                  },
                  child: Container(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.settings),
                          title: Text(
                            'เทคโนโลยีการผลิตข้าว',
                            style: kTextStyle,
                          ),
                          subtitle: Text(
                            'เทคโนโลยีการผลิตข้าวในปัจจุบัน',
                            style: kTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
