import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:v2/style/constants.dart';
import 'package:buddhist_datetime_dateformat/buddhist_datetime_dateformat.dart';

class PriceScreen extends StatefulWidget {
  final Widget child;
  final dynamic rice_price_predict;

  PriceScreen({Key key, this.child, this.rice_price_predict}) : super(key: key);

  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  List<charts.Series<Sales, int>> _seriesLineData;
  var _rice_price_predict;

  _generateData() {
    var linesalesdata = [
      new Sales(0, 45),
      new Sales(1, 56),
      new Sales(2, 55),
      new Sales(3, 60),
      new Sales(4, 61),
      new Sales(5, 70),
    ];
    var linesalesdata1 = [
      new Sales(0, 35),
      new Sales(1, 46),
      new Sales(2, 45),
      new Sales(3, 50),
      new Sales(4, 51),
      new Sales(5, 60),
    ];

    var linesalesdata2 = [
      new Sales(0, 20),
      new Sales(1, 24),
      new Sales(2, 25),
      new Sales(3, 40),
      new Sales(4, 45),
      new Sales(5, 60),
    ];

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
        id: 'Air Pollution',
        data: linesalesdata,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff109618)),
        id: 'Air Pollution',
        data: linesalesdata1,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xffff9900)),
        id: 'Air Pollution',
        data: linesalesdata2,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _seriesLineData = List<charts.Series<Sales, int>>();
    _generateData();
    _rice_price_predict = widget.rice_price_predict;
  }

  Widget _priceMonth() {
    if (_rice_price_predict.length > 0) {
      return Scrollbar(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _rice_price_predict.length,
          itemBuilder: (context, i) {
            return Card(
              child: FlatButton(
                onPressed: () async {},
                child: Container(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          DateFormat('MMM ปี yyyy', 'th')
                              .formatInBuddhistCalendarThai(DateTime.parse(
                                  _rice_price_predict[i]['month'])),
                          style: kLabelStyle,
                        ),
                        subtitle: Text(
                          'ราคา ${_rice_price_predict[i]['price']['Value']} ${_rice_price_predict[i]['price']['Unit']}',
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
      appBar: AppBar(
        backgroundColor: colorTheam,
        //backgroundColor: Color(0xff308e1c),
        title: Text(
          'ราคาข้าว',
          style: kLabelStyle,
        ),
      ),
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
                    'ราคา\n' + _rice_price_predict[0]['name'],
                    style: kLabelStyle,
                  ),
                ),
              ),
              Expanded(child: _priceMonth()),
            ],
          ),
        ),
      ),
    );
  }
}

class Pollution {
  String place;
  int year;
  int quantity;

  Pollution(this.year, this.place, this.quantity);
}

class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}

class Sales {
  int yearval;
  int salesval;

  Sales(this.yearval, this.salesval);
}
/*Container(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  Text('ราคาข้าวพันธ์ (กข 15,กข 20,กข 25)', style: kTextStyle),
                  Expanded(
                    child: charts.LineChart(
                      _seriesLineData,
                      defaultRenderer: new charts.LineRendererConfig(
                          includeArea: true, stacked: true),
                      animate: true,
                      animationDuration: Duration(seconds: 5),
                      behaviors: [
                        new charts.ChartTitle('วันที่ (มกราคม 2564)',
                            behaviorPosition: charts.BehaviorPosition.bottom,
                            titleOutsideJustification:
                                charts.OutsideJustification.middleDrawArea),
                        new charts.ChartTitle(
                          'ราคา (บาท/ตัน)',
                          behaviorPosition: charts.BehaviorPosition.start,
                          titleOutsideJustification:
                              charts.OutsideJustification.middleDrawArea,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ), */
