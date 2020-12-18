import 'package:flutter/material.dart';
import 'package:v2/style/constants.dart';

class VarietiesDetailScreen extends StatefulWidget {
  final dynamic riceVarityInfo;
  final dynamic disease4;
  final dynamic disease3;
  final dynamic disease2;
  final dynamic disease1;

  const VarietiesDetailScreen({
    Key key,
    this.riceVarityInfo,
    this.disease4,
    this.disease3,
    this.disease2,
    this.disease1,
  }) : super(key: key);
  @override
  _VarietiesDetailScreenState createState() => _VarietiesDetailScreenState();
}

class _VarietiesDetailScreenState extends State<VarietiesDetailScreen> {
  dynamic _riceVarityInfo;
  dynamic _disease4;
  dynamic _disease3;
  dynamic _disease2;
  dynamic _disease1;

  @override
  void initState() {
    super.initState();
    _riceVarityInfo = widget.riceVarityInfo;
    _disease4 = widget.disease4;
    _disease3 = widget.disease3;
    _disease2 = widget.disease2;
    _disease1 = widget.disease1;
  }

  Widget _varietiePicture() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: new Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: AssetImage('assets/farmer.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _varietiesName() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'ชื่อพันธ์',
            style: kLabelStyle,
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            _riceVarityInfo['rice_varieties_name'],
            style: kTextStyle,
          ),
        ),
      ],
    );
  }

  Widget _varietiesFlour() {
    return Row(
      children: [
        Text(
          'ชนิดแป้ง',
          style: kLabelStyle,
        ),
        SizedBox(width: 10),
        Text(
          _riceVarityInfo['rice_flour_types'],
          style: kTextStyle,
        ),
      ],
    );
  }

  Widget _varietiesLifeHeight() {
    return Row(
      children: [
        Text(
          'อายุ',
          style: kLabelStyle,
        ),
        SizedBox(width: 10),
        Text(
          _riceVarityInfo['rice_life_time'].toString() + ' วัน',
          style: kTextStyle,
        ),
        SizedBox(width: 10),
        Text(
          'ความสูง',
          style: kLabelStyle,
        ),
        SizedBox(width: 10),
        Text(
          _riceVarityInfo['rice_height'].toString() + ' ซม.',
          style: kTextStyle,
        ),
      ],
    );
  }

  Widget _varietiesCookQuality() {
    return Row(
      children: [
        Text(
          'คุณภาพหลังหุง',
          style: kLabelStyle,
        ),
        SizedBox(width: 10),
        Text(
          _riceVarityInfo['rice_cooking_qualities'],
          style: kTextStyle,
        ),
      ],
    );
  }

  Widget _varietiesAromaAmuloseLight() {
    return Row(
      children: [
        Text(
          'กลิ่น',
          style: kLabelStyle,
        ),
        SizedBox(width: 10),
        Text(
          _riceVarityInfo['rice_aroma'],
          style: kTextStyle,
        ),
        SizedBox(width: 10),
        Text(
          'ค่า amylose',
          style: kLabelStyle,
        ),
        SizedBox(width: 10),
        Text(
          _riceVarityInfo['rice_amylose_content'],
          style: kTextStyle,
        ),
      ],
    );
  }

  Widget _varietiesArea() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'ความไวต่อแสง',
              style: kLabelStyle,
            ),
            SizedBox(width: 10),
            Text(
              _riceVarityInfo['rice_light_refraction'],
              style: kTextStyle,
            ),
          ],
        ),
        SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: Text(
              'พื้นที่แนะนำ',
              style: kLabelStyle,
            ),
          ),
        ),
        SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: Text(
              _riceVarityInfo['rice_recommended_area'],
              style: kTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _varietiesDisease() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: Text(
              'โรคที่ต้านทาน',
              style: kLabelStyle,
            ),
          ),
        ),
        SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: Text(
              _disease4,
              style: kTextStyle,
            ),
          ),
        ),
        SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: Text(
              'โรคที่ค่อนข้างต้านทาน',
              style: kLabelStyle,
            ),
          ),
        ),
        SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: Text(
              _disease3,
              style: kTextStyle,
            ),
          ),
        ),
        SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: Text(
              'โรคที่ค่อนข้างอ่อนแอ',
              style: kLabelStyle,
            ),
          ),
        ),
        SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: Text(
              _disease2,
              style: kTextStyle,
            ),
          ),
        ),
        SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: Text(
              'โรคที่อ่อนแอ',
              style: kLabelStyle,
            ),
          ),
        ),
        SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: Text(
              _disease1,
              style: kTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          'ข้อมูลพันธุ์ข้าว',
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
                horizontal: 10,
                vertical: 10,
              ),
              child: Container(
                alignment: Alignment.centerLeft,
                decoration: kBoxDecorationStyle,
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //_varietiePicture(),
                    //SizedBox(height: 10),
                    _varietiesName(),
                    SizedBox(height: 10),
                    _varietiesFlour(),
                    SizedBox(height: 10),
                    _varietiesLifeHeight(),
                    SizedBox(height: 10),
                    _varietiesCookQuality(),
                    SizedBox(height: 10),
                    _varietiesAromaAmuloseLight(),
                    SizedBox(height: 10),
                    _varietiesArea(),
                    SizedBox(height: 10),
                    _varietiesDisease(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
