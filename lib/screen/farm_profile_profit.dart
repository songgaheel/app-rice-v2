import 'package:flutter/material.dart';
import 'package:v2/style/constants.dart';

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
    _varietiesName = widget.varieties;
    print(widget.evalproduct);
    print(_costV);
    print(_productV);
    print(_priceV);
    print(_profitV);
  }

  Widget _selectVarieties() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'พันธุ์ข้าว',
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
                    : _costV.toString() + ' บาท/ไร่',
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
                    : _productV.toString() + ' กก./ไร่',
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
                    : _priceV.toString() + ' บาท/ตัน',
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
                    : _profitV.toString() + ' บาท/ไร่',
                hintStyle: kHintTextStyle),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
