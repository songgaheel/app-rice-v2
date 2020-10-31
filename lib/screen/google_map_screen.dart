////////////////////////////////////////////////////////////////////////////////
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:v2/style/constants.dart';
//import 'package:location/location.dart';

class MyMapPage extends StatefulWidget {
  @override
  _MyMapPageState createState() => _MyMapPageState();
}

class _MyMapPageState extends State<MyMapPage> {
  Completer<GoogleMapController> _controller = Completer();
  //LocationData currentLocation;
  LatLng _lastLongPress;
  var googlePlace = GooglePlace("AIzaSyAgIlwWm-g9ucv6fiYXLTq9Jj9G9zqrmnY");
  var formattedAddress;
  var province;
  var latt; // or String
  var long; // or String
  Map address; // or String}

  @override
  void initState() {
    super.initState();
    _lastLongPress = LatLng(13.7650836, 100.5379664);
    formattedAddress = "แตะค้างตำแหน่งที่ต้องการ";
  }

  Widget _buildSelectLocationButton() {
    return Container(
      padding: EdgeInsets.all(8),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5,
        onPressed: () {
          address = {
            "formattedAddress": formattedAddress,
            "province": province,
            "latt": latt, // or String
            "long": long,
          };
          Navigator.pop(context, address);
        },
        padding: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: Colors.white,
        child: Text(
          'ยืนยัน',
          style: kTextStyle,
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'เลือกที่นาของคุณ',
          style: kLabelStyle,
        ),
        backgroundColor: colorTheam,
      ),
      body: Column(
        children: [
          Container(
            child: SizedBox(
              height: 450,
              child: GoogleMap(
                myLocationEnabled: true,
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(13.7650836, 100.5379664),
                  zoom: 16,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: {
                  Marker(
                    markerId: MarkerId("1"),
                    position: _lastLongPress,
                  ),
                },
                onLongPress: (LatLng pos) async {
                  print(pos.latitude);
                  print(pos.longitude);

                  var political = await googlePlace.search.getNearBySearch(
                    Location(
                      lat: pos.latitude,
                      lng: pos.longitude,
                    ),
                    1000,
                    language: "th",
                  );
                  DetailsResponse result = await googlePlace.details.get(
                    political.results.first.placeId.toString(),
                    fields: "formatted_address,address_components",
                    language: 'th',
                  );
                  print(political.results.first.placeId);
                  print(result.result.formattedAddress);

                  for (var i = 0;
                      i < result.result.addressComponents.length;
                      i++) {
                    if (result.result.addressComponents[i].types.toString() ==
                        "[administrative_area_level_1, political]") {
                      print('จังหวัด');
                      print(result.result.addressComponents[i].longName);
                      province = result.result.addressComponents[i].longName;
                    }
                    //print(result.result.addressComponents[i].types);
                    //print(result.result.addressComponents[i].longName);
                  }

                  setState(() {
                    _lastLongPress = pos;
                    latt = _lastLongPress.latitude;
                    long = _lastLongPress.latitude;
                    formattedAddress = result.result.formattedAddress;
                  });
                },
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.all(14),
              child: Text(
                'ที่อยู่ : ' + formattedAddress.toString(),
                style: kTextStyle,
              ),
            ),
          ),
          _buildSelectLocationButton(),
        ],
      ),
    );
  }
}
