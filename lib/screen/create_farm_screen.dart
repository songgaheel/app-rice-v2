import 'dart:convert' as convert;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v2/data/apiData.dart';
import 'package:v2/screen/google_map_screen.dart';

import '../style/constants.dart';
import 'create_farm_eval_varietie.dart';

class CreateFarmScreen extends StatefulWidget {
  @override
  _CreateFarmScreenState createState() => _CreateFarmScreenState();
}

class _CreateFarmScreenState extends State<CreateFarmScreen> {
  Map farmlocation;
  String farmName;
  double farmSize;
  bool savedFarm;
  Icon saveIcon;
  bool validateName;
  bool validateSize;
  bool validateLocate;
  SharedPreferences logindata;
  var farm;

  @override
  void initState() {
    super.initState();
    savedFarm = false;
    validateName = false;
    validateSize = false;
    validateLocate = false;
    saveIcon = Icon(Icons.save);
  }

  String _location = 'แตะเลือกตำแหน่งจากแผนที่';

  void updateInformation(String location) {
    setState(() => _location = location);
  }

  void moveToSecondPage() async {
    final location = await Navigator.push(
      context,
      CupertinoPageRoute(
          fullscreenDialog: true, builder: (context) => MyMapPage()),
    );
    //farmlocation = location;
    updateInformation(location["formattedAddress"]);
    farmlocation = location == null ? null : location;
    print(location["formattedAddress"]);
  }

  Widget _buildFarmLocation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'กำหนดตำแหน่งที่นา',
          style: kLabelStyle,
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  moveToSecondPage();
                },
                icon: Icon(Icons.map),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    _location == null ? 'แตะเลือกตำแหน่งจากแผนที่' : _location,
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

  Widget _buildFarmNameTB() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ชื่อที่นา',
          style: kLabelStyle,
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60,
          child: TextField(
            enabled: !(validateName && validateSize && validateLocate),
            keyboardType: TextInputType.name,
            style: kTextStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 8),
              prefixIcon: Icon(
                Icons.landscape,
                color: Colors.grey,
              ),
              hintText: 'ตั้งชื่อให้ที่นาของคุณ',
              hintStyle: kHintTextStyle,
            ),
            onChanged: (String newValue) {
              setState(() {
                farmName = newValue;
              });
            },
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
          child: TextField(
            enabled: !(validateName && validateSize && validateLocate),
            keyboardType: TextInputType.number,
            style: kTextStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 8),
              prefixIcon: Icon(
                Icons.landscape,
                color: Colors.grey,
              ),
              hintText: 'ไร่',
              hintStyle: kHintTextStyle,
            ),
            onChanged: (String newValue) {
              setState(() {
                farmSize = double.parse(newValue);
              });
            },
          ),
        )
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
          farmName == null ? validateName = false : validateName = true;
          farmSize == null ? validateSize = false : validateSize = true;
          farmlocation == null ? validateLocate = false : validateLocate = true;
          if (validateName && validateSize && validateLocate) {
            var uid = await _uidkeeper();
            print(farm);
            if (farm != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FarmEvaluateVarityScreen(
                    uid: uid,
                    farmName: farm,
                  ),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FarmEvaluateVarityScreen(
                    uid: uid,
                    farmName: farmName,
                    farmSize: farmSize,
                    formattedAddress: farmlocation['formattedAddress'],
                    province: farmlocation["province"],
                    latt: farmlocation['latt'],
                    long: farmlocation['long'],
                  ),
                ),
              );
            }
          }
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
          'ต่อไป',
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 1.5,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _saveFarm() {
    return IconButton(
      icon: saveIcon,
      onPressed: () async {
        farmName == null ? validateName = false : validateName = true;
        farmSize == null ? validateSize = false : validateSize = true;
        farmlocation == null ? validateLocate = false : validateLocate = true;

        if (savedFarm) {
          savedFarmDialog(context);
        } else {
          if (validateName && validateSize && validateLocate) {
            var uid = await _uidkeeper();
            var status = await create_farm_only(
              uid: uid,
              farmName: farmName,
              farmSize: farmSize,
              address: farmlocation['formattedAddress'],
              province: farmlocation["province"],
              latt: farmlocation['latt'],
              long: farmlocation['long'],
            );
            print(status['status']);
            farm = status['farm'];
            print(farm);
            if (status['status'] == 'ok') {
              setState(() {
                confirmFarmCreate(context);
                saveIcon = Icon(Icons.check);
                savedFarm = true;
              });
            } else {
              print(status);
            }
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'สร้างที่นาใหม่',
          style: kLabelStyle,
        ),
        backgroundColor: colorTheam,
        actions: [_saveFarm()],
      ),
      body: Stack(
        children: [
          SizedBox(
            height: 30,
          ),
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
                  _buildFarmNameTB(),
                  SizedBox(height: 10),
                  _buildFarmLocation(),
                  _buildButton(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void savedFarmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'คุณได้สร้างที่นาแล้ว',
            style: kLabelStyle,
          ),
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

  create_farm_only({
    String uid,
    String farmName,
    double farmSize,
    String address,
    String province,
    double latt,
    double long,
  }) async {
    var ip = ip_host.host;
    var url = ip + 'api/create/only';
    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8"
    };

    Map provinceCode = {
      "กรุงเทพมหานคร": 1,
      "นนทบุรี": 2,
      "พระนครศรีอยุธยา": 3,
      "ฉะเชิงเทรา": 4,
      "ราชบุรี": 5,
      "นครปฐม": 6,
    };

    var json = convert.jsonEncode(<String, dynamic>{
      "uid": uid,
      "name": farmName,
      "size": farmSize,
      "formattedAddress": address,
      "province": provinceCode[province],
      "latt": latt, // or String
      "long": long, // or String
    });

    print(json);
    final http.Response response = await http.post(
      url,
      headers: headers,
      body: json,
    );

    if (response.statusCode == 200) {
      var res = convert.jsonDecode(response.body);

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

  void confirmFarmCreate(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(
            'บันทึกข้อมูลที่นาสำเร็จ',
            style: kLabelStyle,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'ชื่อที่นา : ' + farmName,
                style: kTextStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'ขนาดที่นา : ' + farmSize.toString(),
                style: kTextStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'ตำแหน่งที่นา : ' + farmlocation['formattedAddress'],
                style: kTextStyle,
              ),
            ),
            FlatButton(
              child: Text(
                'ยืนยัน',
                style: kTextStyle,
              ),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
