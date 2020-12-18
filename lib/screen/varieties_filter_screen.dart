import 'package:flutter/material.dart';
import 'package:v2/style/constants.dart';

import 'varieties_detail_secreen.dart';

class VarietiesFilter extends StatefulWidget {
  final dynamic varieties;

  const VarietiesFilter({Key key, this.varieties}) : super(key: key);
  @override
  _VarietiesFilterState createState() => _VarietiesFilterState();
}

class _VarietiesFilterState extends State<VarietiesFilter> {
  var _varieties;
  var _varietiesfilter;
  var _varietiesHeight;
  var _varietiesLifeTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('varieties filter');
    _varieties = widget.varieties;
    _varietiesfilter = _varieties;
    _varietiesHeight = 'ทั้งหมด';
    _varietiesLifeTime = 'ทั้งหมด';
  }

  /*          
              'ทั้งหมด',
              'น้อยกว่า 100 วัน',
              'ระหว่าง 100 ถึง 120 วัน',
              'มากกว่า 120 วัน',
              
              'ทั้งหมด',
              'น้อยกว่า 100 ซม.',
              'ระหว่าง 100 ถึง 110 ซม.',
              'ระหว่าง 110 ถึง 120 ซม.',
              'มากกว่า 120 ซม.',
    */

  void _varietiesFilterH() {
    var varityList = List();
    if (_varietiesHeight == 'ทั้งหมด' && _varietiesLifeTime == 'ทั้งหมด') {
      setState(() {
        _varietiesfilter = _varieties;
      });
    } else if (_varietiesHeight == 'ทั้งหมด') {
      print('_varietiesHeight _varietiesFilterL  == ทั้งหมด');
      _varietiesfilter = _varieties;
      switch (_varietiesHeight) {
        case 'น้อยกว่า 100 ซม.':
          {
            print(_varietiesfilter.length);
            print(_varietiesHeight);
            for (var variety in _varieties) {
              if (variety['rice_height'] < 100) varityList.add(variety);
            }
          }
          break;
        case 'ระหว่าง 100 ถึง 110 ซม.':
          {
            print(_varietiesfilter.length);
            print(_varietiesHeight);
            for (var variety in _varieties) {
              if (variety['rice_height'] > 99 && variety['rice_height'] < 111)
                varityList.add(variety);
            }
          }
          break;
        case 'ระหว่าง 110 ถึง 120 ซม.':
          {
            print(_varietiesfilter.length);
            print(_varietiesHeight);
            for (var variety in _varieties) {
              if (variety['rice_height'] > 109 && variety['rice_height'] < 121)
                varityList.add(variety);
            }
          }
          break;
        case 'มากกว่า 120 ซม.':
          {
            print(_varietiesfilter.length);
            print(_varietiesHeight);
            for (var variety in _varieties) {
              if (variety['rice_height'] > 120) varityList.add(variety);
            }
          }
          break;
        default:
      }

      _varietiesfilter = varityList;
      print('3');
      print(_varietiesfilter.length);
    } else {
      print('_varietiesHeight _varietiesFilterL  != ทั้งหมด');
      switch (_varietiesHeight) {
        case 'น้อยกว่า 100 ซม.':
          {
            print(_varietiesfilter.length);
            print(_varietiesHeight);
            for (var variety in _varietiesfilter) {
              if (variety['rice_height'] < 100) varityList.add(variety);
            }
          }
          break;
        case 'ระหว่าง 100 ถึง 110 ซม.':
          {
            print(_varietiesfilter.length);
            print(_varietiesHeight);
            for (var variety in _varietiesfilter) {
              if (variety['rice_height'] > 99 && variety['rice_height'] < 111)
                varityList.add(variety);
            }
          }
          break;
        case 'ระหว่าง 110 ถึง 120 ซม.':
          {
            print(_varietiesfilter.length);
            print(_varietiesHeight);
            for (var variety in _varietiesfilter) {
              if (variety['rice_height'] > 109 && variety['rice_height'] < 121)
                varityList.add(variety);
            }
          }
          break;
        case 'มากกว่า 120 ซม.':
          {
            print(_varietiesfilter.length);
            print(_varietiesHeight);
            for (var variety in _varietiesfilter) {
              if (variety['rice_height'] > 120) varityList.add(variety);
            }
          }
          break;
        default:
      }

      _varietiesfilter = varityList;
      print('3');
      print(_varietiesfilter.length);
    }
  }

  void _varietiesFilterL() {
    var varityList = List();
    if (_varietiesHeight == 'ทั้งหมด' && _varietiesLifeTime == 'ทั้งหมด') {
      setState(() {
        _varietiesfilter = _varieties;
      });
    } else if (_varietiesHeight == 'ทั้งหมด') {
      _varietiesfilter = _varieties;
      print('_varietiesFilterL _varietiesHeight == ทั้งหมด');
      switch (_varietiesLifeTime) {
        case 'น้อยกว่า 100 วัน':
          {
            print(_varietiesfilter.length);
            print(_varietiesLifeTime);
            for (var variety in _varieties) {
              if (variety['rice_life_time'] < 100) varityList.add(variety);
            }
          }
          break;
        case 'ระหว่าง 100 ถึง 120 วัน':
          {
            print(_varietiesfilter.length);
            print(_varietiesLifeTime);
            for (var variety in _varieties) {
              if (variety['rice_life_time'] > 99 &&
                  variety['rice_life_time'] < 121) varityList.add(variety);
            }
          }
          break;
        case 'มากกว่า 120 วัน':
          {
            print(_varietiesfilter.length);
            print(_varietiesLifeTime);
            for (var variety in _varieties) {
              if (variety['rice_life_time'] > 120) varityList.add(variety);
            }
          }
          break;
        default:
      }

      _varietiesfilter = varityList;
      print('3');
      print(_varietiesfilter.length);
    } else {
      print('_varietiesFilterL _varietiesHeight != ทั้งหมด');
      switch (_varietiesLifeTime) {
        case 'น้อยกว่า 100 วัน':
          {
            print(_varietiesfilter.length);
            print(_varietiesLifeTime);
            for (var variety in _varietiesfilter) {
              if (variety['rice_life_time'] < 100) varityList.add(variety);
            }
          }
          break;
        case 'ระหว่าง 100 ถึง 120 วัน':
          {
            print(_varietiesfilter.length);
            print(_varietiesLifeTime);
            for (var variety in _varietiesfilter) {
              if (variety['rice_life_time'] > 99 &&
                  variety['rice_life_time'] < 121) varityList.add(variety);
            }
          }
          break;
        case 'มากกว่า 120 วัน':
          {
            print(_varietiesfilter.length);
            print(_varietiesLifeTime);
            for (var variety in _varietiesfilter) {
              if (variety['rice_life_time'] > 120) varityList.add(variety);
            }
          }
          break;
        default:
      }

      _varietiesfilter = varityList;
      print('3');
      print(_varietiesfilter.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          'องค์ความรู้เรื่องข้าว',
          style: kLabelStyle,
        ),
        backgroundColor: colorTheam,
      ),
      body: Padding(
        //physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
        ),
        child: Column(
          children: [
            _selectLifeTime(),
            _selectHeight(),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'พันธุ์ข้าว (${_varietiesfilter.length} พันธุ์)',
                  style: kLabelStyle,
                ),
              ),
            ),
            Expanded(
              child: _listVarietiesFilter(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _selectLifeTime() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ช่วงอายุข้าว',
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
                'ทั้งหมด',
                style: kHintTextStyle,
              ),
            ),
            value: _varietiesLifeTime,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 42,
            underline: SizedBox(),
            isExpanded: true,
            onChanged: (String newValue) {
              setState(() {
                _varietiesLifeTime = newValue;
              });
              _varietiesFilterL();
            },
            items: <String>[
              'ทั้งหมด',
              'น้อยกว่า 100 วัน',
              'ระหว่าง 100 ถึง 120 วัน',
              'มากกว่า 120 วัน',
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

  Widget _selectHeight() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ช่วงความสูงข้าว',
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
                'ทั้งหมด',
                style: kHintTextStyle,
              ),
            ),
            value: _varietiesHeight,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 42,
            underline: SizedBox(),
            isExpanded: true,
            onChanged: (String newValue) {
              setState(() {
                _varietiesHeight = newValue;
              });
              _varietiesFilterH();
            },
            items: <String>[
              'ทั้งหมด',
              'น้อยกว่า 100 ซม.',
              'ระหว่าง 100 ถึง 110 ซม.',
              'ระหว่าง 110 ถึง 120 ซม.',
              'มากกว่า 120 ซม.',
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

  Widget _listVarietiesFilter() {
    if (_varietiesfilter.length > 0) {
      return Scrollbar(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _varietiesfilter.length,
          itemBuilder: (context, i) {
            return Card(
              child: FlatButton(
                onPressed: () async {
                  print(
                      'Click profile ${_varietiesfilter[i]['rice_varieties_name']}');
                  var disease4 = '';
                  var disease3 = '';
                  var disease2 = '';
                  var disease1 = '';
                  _varietiesfilter[i].forEach((key, value) {
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
                        riceVarityInfo: _varietiesfilter[i],
                        disease4: disease4,
                        disease3: disease3,
                        disease2: disease2,
                        disease1: disease1,
                      ),
                    ),
                  );
                },
                child: Container(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.search,
                          size: 40,
                        ),
                        title: Text(
                          _varietiesfilter[i]['rice_varieties_name'],
                          style: kTextStyle,
                        ),
                        subtitle: Text(
                          'อายุ ${_varietiesfilter[i]['rice_life_time']} วัน / ความสูง ${_varietiesfilter[i]['rice_height']} ซม.',
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
      return Text('ไม่มีข้อมูลพันธุ์ข้าว');
    }
  }
}
