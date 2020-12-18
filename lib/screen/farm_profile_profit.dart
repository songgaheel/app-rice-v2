import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:v2/data/apiData.dart';
import 'package:v2/style/constants.dart';

import 'varieties_detail_secreen.dart';

class FarmProfileProfit extends StatefulWidget {
  final dynamic evalproduct;
  final dynamic varieties;

  const FarmProfileProfit({Key key, this.evalproduct, this.varieties})
      : super(key: key);
  @override
  _FarmProfileProfitState createState() => _FarmProfileProfitState();
}

class _FarmProfileProfitState extends State<FarmProfileProfit> {
  dynamic _costV;
  dynamic _productV;
  dynamic _priceV;
  dynamic _profitV;
  dynamic _costS;
  dynamic _productS;
  dynamic _priceS;
  dynamic _profitS;
  dynamic _varietiesName;
  dynamic _varietiesID;

  @override
  void initState() {
    super.initState();
    _costV = widget.evalproduct['cost']['value'];
    _productV = widget.evalproduct['product']['value'];
    _priceV = widget.evalproduct['price']['value'];
    _profitV = widget.evalproduct['profit']['value'];
    //_costS = widget.evalproduct['cost']['status'];
    //_productS = widget.evalproduct['product']['status'];
    //_priceS = widget.evalproduct['price']['status'];
    //_profitS = widget.evalproduct['profit']['status'];
    _varietiesName = widget.varieties['rice_varieties_name'];
    _varietiesID = widget.varieties['ID'];
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
              'พันธุ์ข้าว',
              style: kLabelStyle,
            ),
            IconButton(
              onPressed: () async {
                print('varieties information');
                print(_varietiesID);
                var ret = await varieties_information(_varietiesID);

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
              contentPadding: EdgeInsets.only(
                left: 14,
              ),
              hintText: _varietiesName,
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
        SizedBox(height: 10),
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
                contentPadding: EdgeInsets.only(left: 14),
                /*prefixIcon: Icon(
                  Icons.thumbs_up_down,
                  color: Colors.amber,
                ),*/
                hintText: _costV == -1
                    ? 'ยังไม่ได้ดำเนินการ'
                    : NumberFormat("#,###.##").format(_costV) + ' บาท/ไร่',
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
                contentPadding: EdgeInsets.only(left: 14),
                /*prefixIcon: Icon(
                  Icons.thumbs_up_down,
                  color: Colors.amber,
                ),*/
                hintText: _productV == -1
                    ? 'ยังไม่ได้ดำเนินการ'
                    : NumberFormat("#,###.##").format(_productV) + ' กก./ไร่',
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
                contentPadding: EdgeInsets.only(left: 14),
                /*prefixIcon: Icon(
                  Icons.thumbs_up_down,
                  color: Colors.amber,
                ),*/
                hintText: _priceV == -1
                    ? 'ยังไม่ได้ดำเนินการ'
                    : NumberFormat("#,###.##").format(_priceV) + ' บาท/ตัน',
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
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 14),
                /*prefixIcon: Icon(
                  Icons.thumbs_up_down,
                  color: Colors.amber,
                ),*/
                hintText: _profitV == -1
                    ? 'ยังไม่ได้ดำเนินการ'
                    : NumberFormat("#,###.##").format(_profitV) + ' บาท/ไร่',
                hintStyle: kHintTextStyle),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
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
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
