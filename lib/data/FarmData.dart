import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Farm {
  final Icon icon;
  final String name;
  final double size;
  final String location; //<String, String,String>

  Farm({this.icon, this.name, this.size, this.location});
}

List<Farm> farm = [
  Farm(
      name: 'นาองครักษ์ นครนายก',
      size: 11.1,
      location: 'ภาคกลาง : นครนายก',
      icon: Icon(Icons.landscape)),
  Farm(
    name: 'นาหนองจอก กรุงทพ',
    size: 11.1,
    location: 'ภาคกลาง : กรุงเทพ',
    icon: Icon(Icons.landscape),
  ),
  Farm(
    name: 'นาคลองหลวง ปทุมธานี',
    size: 11.1,
    location: 'ภาคกลาง : ปทุมธานี',
    icon: Icon(Icons.landscape),
  ),
];
