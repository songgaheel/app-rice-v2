import 'package:flutter/material.dart';
import 'package:v2/style/constants.dart';

class FarmInformaion extends StatefulWidget {
  final dynamic farmName;
  final dynamic farmLocationAddress;
  final dynamic farmSize;

  const FarmInformaion(
      {Key key, this.farmName, this.farmLocationAddress, this.farmSize})
      : super(key: key);
  @override
  _FarmInformaionState createState() => _FarmInformaionState();
}

class _FarmInformaionState extends State<FarmInformaion> {
  final formKey = new GlobalKey<FormState>();
  dynamic _farmName;
  dynamic _farmLocationAddress;
  dynamic _farmSize;

  @override
  void initState() {
    super.initState();
    _farmName = widget.farmName;
    _farmLocationAddress = widget.farmLocationAddress;
    _farmSize = widget.farmSize;
  }

  Widget _buildFarmLocationDD() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ตำแหน่งที่นา',
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
              hintText: _farmLocationAddress,
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
            enabled: false,
            keyboardType: TextInputType.name,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 14),
              prefixIcon: Icon(
                Icons.landscape,
                color: Colors.grey,
              ),
              hintText: _farmName,
              hintStyle: kHintTextStyle,
            ),
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
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              enabled: false,
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.landscape,
                color: Colors.grey,
              ),
              hintText: _farmSize.toString(), //
              hintStyle: kHintTextStyle,
            ),
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
                  _buildFarmNameTB(),
                  SizedBox(height: 10),
                  _buildFarmLocationDD(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
