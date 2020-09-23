import 'package:flutter/material.dart';
import 'package:v2/data/FarmData.dart';
import 'package:v2/style/constants.dart';

class AccountScreen extends StatefulWidget {
  final Farm farm;

  const AccountScreen({Key key, this.farm}) : super(key: key);
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Card(
              child: FlatButton(
                onPressed: () {
                  print('user');
                  Navigator.pushNamed(context, '/Account/User/Profile');
                },
                child: Container(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.account_circle),
                        title: Text(
                          'นายข้าว หอมมะลิ',
                          style: kTextStyle,
                        ),
                        subtitle: Text(
                          'กรุงเทพ หนองจอก',
                          style: kTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: farm.length,
              itemBuilder: (context, i) {
                return Card(
                  child: FlatButton(
                    onPressed: () {
                      print('Click profile ${farm[i].name}');
                      Navigator.pushNamed(context, '/Account/Farm/Profile');
                    },
                    child: Container(
                      child: Column(
                        children: [
                          ListTile(
                            leading: farm[i].icon,
                            title: Text(
                              farm[i].name,
                              style: kTextStyle,
                            ),
                            subtitle: Text(
                              farm[i].location,
                              style: kTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
