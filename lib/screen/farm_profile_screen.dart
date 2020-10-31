import 'package:flutter/material.dart';
import 'package:v2/screen/farm_profile_information.dart';
import 'package:v2/style/constants.dart';

import 'farm_profile_profit.dart';
import 'farm_profile_timeline.dart';

class FarmProfileScreen extends StatefulWidget {
  final dynamic farm;

  const FarmProfileScreen({Key key, this.farm}) : super(key: key);
  @override
  _FarmProfileScreenState createState() => _FarmProfileScreenState();
}

class _FarmProfileScreenState extends State<FarmProfileScreen> {
  dynamic _farmName;
  dynamic _farmLocationAddress;
  dynamic _farmSize;
  dynamic _evalproduct;
  dynamic _varietiesName;
  dynamic _farmTlP;
  dynamic _farmTlF;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _farmName = widget.farm['farm']['name'];
    _farmLocationAddress = widget.farm['farm']['location']['formattedAddress'];
    _farmSize = widget.farm['farm']['size'];
    if (widget.farm['farm']['evalproduct'] != null) {
      _evalproduct = widget.farm['farm']['evalproduct'];
    } else {
      _evalproduct = {
        'cost': {'value': -1},
        'product': {'value': -1},
        'price': {'value': -1},
        'profit': {'value': -1},
      };
    }
    if (widget.farm['varietie'] != null)
      _varietiesName = widget.farm['varietie']['rice_varieties_name'];

    _farmTlP = widget.farm['farm']['timelinePast'];
    _farmTlF = widget.farm['farm']['timelineFuture'];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          backgroundColor: colorTheam,
          title: Text(
            'Farm Profile',
            style: kLabelStyle,
          ),
          bottom: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            labelStyle: kTextStyle,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.info),
              ),
              Tab(
                icon: Icon(Icons.monetization_on),
              ),
              Tab(
                icon: Icon(Icons.timeline),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                      'แชร์สำเร็จ',
                      style: kLabelStyle,
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
                  ),
                );
              },
            )
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            FarmInformaion(
              farmName: _farmName,
              farmLocationAddress: _farmLocationAddress,
              farmSize: _farmSize,
            ),
            FarmProfileProfit(
              evalproduct: _evalproduct,
              varieties: _varietiesName == null
                  ? 'ยังไม่ได้ดำเนินการ'
                  : _varietiesName,
            ),
            FarmTimeline(
              timelineFuture: _farmTlF,
              timelinePast: _farmTlP,
            ),
          ],
        ),
      ),
    );
  }
}
