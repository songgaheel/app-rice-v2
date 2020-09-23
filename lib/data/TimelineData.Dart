import 'package:flutter/material.dart';

class Modeltimeline {
  final Icon iconevent;
  final Color iconeventcolor;
  final Icon iconfarm;
  final String name;
  final String date;
  final String content;
  final List<String> activity;
  final List<String> bug;
  final List<String> disease;

  const Modeltimeline({
    this.iconevent,
    this.iconfarm,
    this.iconeventcolor,
    this.name,
    this.date,
    this.content,
    this.activity,
    this.bug,
    this.disease,
  });
}

const List<String> activities = [
  'ตรวจระดับน้ำ 3 เซนติเมตร',
  'ใส่ปุ๋ย',
  'ตรวจและกำจัดวัชพืช'
];

const List<String> bugs = ['ระวังเพลี้ยกระโดดสีน้ำตาล'];
const List<String> diseases = ['ระวังโรคใบไหม้'];

List<Modeltimeline> modeltimeline = [
  Modeltimeline(
    iconevent: Icon(
      Icons.star,
      color: Colors.white,
    ),
    iconeventcolor: Colors.greenAccent,
    iconfarm: Icon(Icons.landscape),
    name: 'นาองครักษ์ นครนายก',
    date: '01 มกราคม 2564',
    content: 'เริ่มต้นการปลูกข้าว พันธุ์ที่ปลูก กข-105',
    activity: ['ตรวจสอบระดับน้ำ 3 เซนติเมตร', 'ตรวจและกำจัดวัชพืช'],
    bug: [],
    disease: [],
  ),
  Modeltimeline(
    iconevent: Icon(
      Icons.star,
      color: Colors.white,
    ),
    iconeventcolor: Colors.greenAccent,
    iconfarm: Icon(Icons.landscape),
    name: 'นาองครักษ์ นครนายก',
    date: '05 มกราคม 2564',
    content: '',
    activity: ['ตรวจระดับน้ำ 3 เซนติเมตร', 'ตรวจและกำจัดวัชพืช'],
    bug: bugs,
    disease: diseases,
  ),
  Modeltimeline(
    iconevent: Icon(
      Icons.cloud,
      color: Colors.white,
    ),
    iconeventcolor: Colors.red,
    iconfarm: Icon(Icons.landscape),
    name: 'นาองครักษ์ นครนายก',
    date: '15 กุมภาพันธ์ 2564',
    content: 'ฝนทิ้งช่วง ระวังภัยแล้ง',
    activity: [],
    bug: [],
    disease: [],
  ),
  Modeltimeline(
    iconevent: Icon(
      Icons.star,
      color: Colors.white,
    ),
    iconeventcolor: Colors.greenAccent,
    iconfarm: Icon(Icons.landscape),
    name: 'นาองครักษ์ นครนายก',
    date: '20 กุมภาพันธ์ 2564',
    content: '',
    activity: activities,
    bug: bugs,
    disease: diseases,
  ),
  Modeltimeline(
    iconevent: Icon(
      Icons.star,
      color: Colors.white,
    ),
    iconeventcolor: Colors.greenAccent,
    iconfarm: Icon(Icons.landscape),
    name: 'นาองครักษ์ นครนายก',
    date: '20 เมษายน 2564',
    content: 'เสร็จสิ้นกระบวนการปลูก',
    activity: [],
    bug: [],
    disease: [],
  ),
];
