import 'package:flutter/material.dart';

class FarmFeed {
  final Icon icon;
  final String name;
  final String date;
  final String content;
  final List<String> activity;
  final List<String> bug;
  final List<String> disease;

  const FarmFeed({
    this.icon,
    this.name,
    this.date,
    this.content,
    this.activity,
    this.bug,
    this.disease,
  });
}

const List<String> activities = [
  'ตรวจระดับน้ำ',
  'ใส่ปุ๋ย',
  'ตรวจและกำจัดวัชพืช'
];

const List<String> bugs = ['ระวังเพลี้ยกระโดดสีน้ำตาล'];
const List<String> diseases = ['ระวังโรคใบไหม้'];

List<FarmFeed> feed = [
  FarmFeed(
    icon: Icon(Icons.landscape),
    name: 'นาองครักษ์ นครนายก',
    date: '01 มกราคม 2564',
    content: '',
    activity: activities,
    bug: bugs,
    disease: diseases,
  ),
  FarmFeed(
    icon: Icon(Icons.landscape),
    name: 'นาหนองจอก กรุงทพ',
    date: '01 มกราคม 2564',
    content: '',
    activity: ['ตรวจระดับน้ำ', 'ตรวจและกำจัดวัชพืช'],
    bug: bugs,
    disease: diseases,
  ),
  FarmFeed(
    icon: Icon(Icons.landscape),
    name: 'นาคลองหลวง ปทุมธานี',
    date: '01 มกราคม 2564',
    content: '',
    activity: ['ตรวจระดับน้ำ', 'ตรวจและกำจัดวัชพืช'],
    bug: [''],
    disease: diseases,
  ),
];
