import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:v2/data/apiData.dart';
import 'package:v2/style/constants.dart';
import 'package:buddhist_datetime_dateformat/buddhist_datetime_dateformat.dart';

class FarmProfileNote extends StatefulWidget {
  final dynamic note;
  final dynamic fid;

  const FarmProfileNote({
    Key key,
    this.note,
    this.fid,
  }) : super(key: key);
  @override
  _FarmProfileNoteState createState() => _FarmProfileNoteState();
}

class _FarmProfileNoteState extends State<FarmProfileNote> {
  var _cost;
  var _content;
  dynamic _fid;

  dynamic _note;
  final today = DateTime.now();

  @override
  void initState() {
    super.initState();
    _note = widget.note;
    _fid = widget.fid;
    print(_note);
  }

  Widget _imageNote(dynamic notePic) {
    //print(activities);
    var pic = List();
    double h;
    for (var item in notePic) {
      if (item == '' ||
          item == 'red' ||
          item == 'xx' ||
          item == 'r' ||
          item == null) {
        h = 0;
      } else {
        h = 300;
      }
      print('item');
      print(item);
      pic.add(item);
    }

    return CarouselSlider.builder(
      itemCount: pic.length,
      itemBuilder: (context, i) {
        if (pic == '' ||
            pic == 'red' ||
            pic == 'xx' ||
            pic == 'r' ||
            pic == null) {
          return SizedBox.shrink();
        } else {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Image(
                  height: 200,
                  fit: BoxFit.fill,
                  image: NetworkImage(pic[i]),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  color: Colors.blue,
                  child: Text(
                    '${i + 1}/${pic.length}',
                  ),
                ),
              ),
            ],
          );
        }
      },
      options: CarouselOptions(
        height: h,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: false,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget _noteList() {
    if (_note.length != 0) {
      return ListView.builder(
        itemCount: _note.length,
        itemBuilder: (context, i) {
          return FlatButton(
            onPressed: () async {
              _noteEdit(
                fid: _fid,
                nid: _note[i]['_id'],
                order: _note[i]['order'],
                note: _note[i],
              ).then((val) {
                print('edit');
                print(val);
                setState(() {
                  _note = val;
                });
              });
            },
            child: Card(
              child: Container(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'บันทึก: ' +
                            DateFormat('dd MMMM yyyy', 'th')
                                .formatInBuddhistCalendarThai(DateTime.parse(
                                    _note[i]['noteDate'].toString())),
                        style: kLabelStyle,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        //color: Colors.red,
                        padding: EdgeInsets.only(left: 14, bottom: 8),
                        child: ReadMoreText(
                          _note[i]['content'],
                          trimLines: 5,
                          colorClickableText: Colors.blue,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: '...เพิ่มเติม',
                          trimExpandedText: ' ซ่อน',
                          style: kTextStyle,
                        ),
                      ),
                    ),
                    _imageNote(_note[i]['photo']),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else {
      return Text(
        'ไม่มีบันทึก',
        style: kTextStyle,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return _noteCreate(context);
            },
          ).then((val) {
            print('create note pop');
            print(val);
            setState(() {
              _note = val;
            });
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      body: _noteList(),
    );
  }

  farm_create_note(
    dynamic fid,
    dynamic order,
    dynamic note,
    dynamic noteDate,
  ) async {
    var ip = ip_host.host;
    var url = ip + 'api/farm/createnote';
    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8"
    };
    var json = jsonEncode(<String, dynamic>{
      "fid": fid,
      "order": order == 0 ? order + 1 : order['order'] + 1,
      "noteDate": noteDate,
      "content": note["content"],
      "photo": note["photo"],
      "cost": note["cost"],
    });

    print(json);
    final Response response = await post(
      url,
      headers: headers,
      body: json,
    );

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      print(res);
      return res;
    } else {
      //print('Request failed with status: ${response.statusCode}.');
    }
  }

  farm_read_note(
    dynamic fid,
  ) async {
    var ip = ip_host.host;
    var url = ip + 'api/farm/note';
    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8"
    };
    var json = jsonEncode(<String, dynamic>{
      "fid": fid,
    });

    print(json);
    final Response response = await post(
      url,
      headers: headers,
      body: json,
    );

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      print(res);
      return res;
    } else {
      //print('Request failed with status: ${response.statusCode}.');
    }
  }

  Widget _noteCreate(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_cost != null || _content != null) {
            Map note = {
              'cost': _cost == null ? 0 : _cost,
              'content': _content == null ? '' : _content,
              'photo': '',
            };
            var dateformatt = DateFormat('yyyy-MM-dd' 'T' 'HH:mm:ss.sss');
            var sdate = dateformatt.format(today) + 'Z';
            print('create note');
            var res = await farm_create_note(
              _fid,
              _note.length == 0 ? 0 : _note.last,
              note,
              sdate.toString(),
            );
            print(res);
            if (res['status'] == 'success') {
              var res = await farm_read_note(_fid);
              if (res['status'] == 'success') {
                Navigator.pop(context, res['note']);
                _cost = null;
                _content = null;
              } else {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('ข้อผิดผลาด'),
                      content: Text(res['status'] + ': ' + res['msg']),
                    );
                  },
                );
                Navigator.pop(context);
                _cost = null;
                _content = null;
              }
            } else {
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('ข้อผิดผลาด'),
                    content: Text(res['status'] + ': ' + res['msg']),
                  );
                },
              );
            }
          } else {
            Navigator.pop(context);
          }
        },
        child: Icon(Icons.save),
        backgroundColor: Colors.blue,
      ),
      appBar: AppBar(
        backgroundColor: colorTheam,
        title: Text(
          "เพิ่มบันทึก",
          style: kLabelStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                DateFormat('วันที่ dd MMMM yyyy', 'th')
                    .formatInBuddhistCalendarThai(
                        DateTime.parse(today.toString())),
                style: kTextStyle,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  "บันทึกรายจ่าย",
                  style: kTextStyle,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: TextFormField(
                keyboardType: TextInputType.number,
                maxLines: null,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 8),
                  hintText: 'จำนวนเงิน (บาท)',
                  hintStyle: kHintTextStyle,
                ),
                onChanged: (value) {
                  setState(() {
                    _cost = value;
                  });
                },
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  "บันทึกข้อความ",
                  style: kTextStyle,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 8),
                  hintText: 'พิมพ์บันทึกของคุณที่นี่',
                  hintStyle: kHintTextStyle,
                ),
                onChanged: (value) {
                  setState(() {
                    _content = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  farm_edit_note(
    dynamic fid,
    dynamic nid,
    dynamic order,
    dynamic note,
    dynamic noteDate,
  ) async {
    var ip = ip_host.host;
    var url = ip + 'api/farm/updatenote';
    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8"
    };
    var json = jsonEncode(<String, dynamic>{
      "fid": fid,
      "nid": nid,
      "order": order,
      "noteDate": noteDate,
      "content": note["content"],
      "photo": note["photo"],
      "cost": note["cost"],
    });

    print(json);
    final Response response = await post(
      url,
      headers: headers,
      body: json,
    );

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      print(res);
      return res;
    } else {
      //print('Request failed with status: ${response.statusCode}.');
    }
  }

  farm_delete_note(
    dynamic fid,
    dynamic nid,
  ) async {
    var ip = ip_host.host;
    var url = ip + 'api/farm/deletenote';
    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8"
    };
    var json = jsonEncode(<String, dynamic>{
      "fid": fid,
      "nid": nid,
    });

    print(json);
    final Response response = await post(
      url,
      headers: headers,
      body: json,
    );

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      print(res);
      return res;
    } else {
      //print('Request failed with status: ${response.statusCode}.');
    }
  }

  _noteEdit({
    String fid,
    String nid,
    int order,
    dynamic note,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              if (_cost != null || _content != null) {
                Map note = {
                  'cost': _cost == null ? 0 : _cost,
                  'content': _content == null ? '' : _content,
                  'photo': '',
                };
                var dateformatt = DateFormat('yyyy-MM-dd' 'T' 'HH:mm:ss.sss');
                var sdate = dateformatt.format(today) + 'Z';
                print('edit note');
                var res1 = await farm_edit_note(
                  fid,
                  nid,
                  order,
                  note,
                  sdate.toString(),
                );
                print(res1);
                if (res1['status'] == 'success') {
                  var res2 = await farm_read_note(_fid);
                  if (res2['status'] == 'success') {
                    Navigator.pop(context, res2['note']);
                    _cost = null;
                    _content = null;
                  } else {
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('ข้อผิดผลาด'),
                          content: Text(res2['status'] + ': ' + res2['msg']),
                        );
                      },
                    );
                    Navigator.pop(context);
                    _cost = null;
                    _content = null;
                  }
                } else {
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('ข้อผิดผลาด'),
                        content: Text(res1['status'] + ': ' + res1['msg']),
                      );
                    },
                  );
                }
              } else {
                Navigator.pop(context);
              }
            },
            child: Icon(Icons.save),
            backgroundColor: Colors.blue,
          ),
          appBar: AppBar(
            backgroundColor: colorTheam,
            title: Text(
              "แก้ไขบันทึก",
              style: kLabelStyle,
            ),
            actions: [
              IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    if (_cost != null || _content != null) {
                      print('delete note');
                      var res1 = await farm_delete_note(
                        fid,
                        nid,
                      );
                      print(res1);
                      if (res1['status'] == 'success') {
                        var res2 = await farm_read_note(_fid);
                        if (res2['status'] == 'success') {
                          Navigator.pop(context, res2['note']);
                          _cost = null;
                          _content = null;
                        } else {
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('ข้อผิดผลาด'),
                                content:
                                    Text(res2['status'] + ': ' + res2['msg']),
                              );
                            },
                          );
                          Navigator.pop(context);
                          _cost = null;
                          _content = null;
                        }
                      } else {
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('ข้อผิดผลาด'),
                              content:
                                  Text(res1['status'] + ': ' + res1['msg']),
                            );
                          },
                        );
                      }
                    } else {
                      Navigator.pop(context);
                    }
                  })
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    DateFormat('วันที่ dd MMMM yyyy', 'th')
                        .formatInBuddhistCalendarThai(
                            DateTime.parse(today.toString())),
                    style: kTextStyle,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "บันทึกรายจ่าย",
                      style: kTextStyle,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: TextFormField(
                    initialValue: note['cost'].toString(),
                    keyboardType: TextInputType.number,
                    maxLines: null,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 8),
                      hintText: 'จำนวนเงิน (บาท)',
                      hintStyle: kHintTextStyle,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _cost = value;
                      });
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      "บันทึกข้อความ",
                      style: kTextStyle,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: TextFormField(
                    initialValue: note['content'],
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 8),
                      hintText: 'พิมพ์บันทึกของคุณที่นี่',
                      hintStyle: kHintTextStyle,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _content = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
