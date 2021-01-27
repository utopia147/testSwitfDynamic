import 'package:flutter/material.dart';

class UserDetailPage extends StatelessWidget {
  const UserDetailPage(
      {Key key,
      @required this.citizenid,
      @required this.firstname,
      @required this.lastname,
      @required this.nickname,
      @required this.age,
      @required this.bday,
      @required this.email,
      @required this.tel})
      : super(key: key);
  final citizenid;
  final firstname;
  final lastname;
  final nickname;
  final age;
  final bday;
  final email;
  final tel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('User Detail'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            child: CircleAvatar(
              child: Icon(Icons.account_circle, size: 50),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              'ชื่อ:$firstname  นามสกุล:$lastname',
              style: TextStyle(fontSize: 24),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'ชื่อเล่น:$nickname  อายุ:$age  เกิดวันที่:$bday',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'เลขบัตรประจำตัว:$citizenid',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Email:$email',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Tel:$tel',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
