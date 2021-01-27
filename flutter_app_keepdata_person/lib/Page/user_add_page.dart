import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_keepdata_person/bloc/user_bloc.dart';
import 'package:flutter_app_keepdata_person/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserAddPage extends StatelessWidget {
  UserAddPage({Key key, @required this.userBloc}) : super(key: key);
  final UserBloc userBloc;
  final _formKey = GlobalKey<FormState>();
  var _citizenid = TextEditingController();
  var _firstname = TextEditingController();
  var _lastname = TextEditingController();
  var _nickname = TextEditingController();
  var _age = TextEditingController();
  var _bday = TextEditingController();
  var _email = TextEditingController();
  var _tel = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('กรอกประวัตส่วนตัว'),
      ),
      body: BlocConsumer<UserBloc, UserState>(
        cubit: userBloc,
        listener: (context, state) {
          if (state is AddUserSucessful) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 120,
                      width: 120,
                      child: CircleAvatar(
                        child: Icon(
                          Icons.account_box,
                          size: 60,
                        ),
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    autovalidate: true,
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            'กรอกข้อมูล',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'ชื่อ',
                                    labelStyle: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Colors.black26,
                                    )),
                                  ),
                                  controller: _firstname,
                                  validator: (val) {
                                    String errorMsg;
                                    if (val.isEmpty) {
                                      errorMsg = '*กรุณากรอกชื่อ';
                                    }
                                    return errorMsg;
                                  },
                                ),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'นามสกุล',
                                    labelStyle: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Colors.black26,
                                    )),
                                  ),
                                  controller: _lastname,
                                  validator: (val) {
                                    String errorMsg;
                                    if (val.isEmpty) {
                                      errorMsg = '*กรุณากรอกนามสกุล';
                                    }
                                    return errorMsg;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'ชื่อเล่น',
                                    labelStyle: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Colors.black26,
                                    )),
                                  ),
                                  controller: _nickname,
                                  validator: (val) {
                                    String errorMsg;
                                    if (val.isEmpty) {
                                      errorMsg = '*กรอกชื่อเล่น';
                                    }
                                    return errorMsg;
                                  },
                                ),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'อายุ',
                                    labelStyle: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Colors.black26,
                                    )),
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  controller: _age,
                                  validator: (val) {
                                    String errorMsg;
                                    if (val.isEmpty) {
                                      errorMsg = '*กรอกอายุ';
                                    }
                                    return errorMsg;
                                  },
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'วัน/เดือน/ปีเกิด',
                                    labelStyle: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Colors.black26,
                                    )),
                                  ),
                                  controller: _bday,
                                  validator: (val) {
                                    String errorMsg;
                                    if (val.isEmpty) {
                                      errorMsg = '*กรุณากรอกวันเดือนปีเกิด';
                                    }
                                    return errorMsg;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            decoration: InputDecoration(
                              labelText: 'เลขบัตรประจำตัว',
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 14),
                              prefixIcon: Icon(
                                Icons.account_box,
                                color: Colors.black38,
                                size: 20,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.black26,
                              )),
                            ),
                            controller: _citizenid,
                            validator: (val) {
                              String errorMsg;
                              if (val.length < 13 || val.length > 13) {
                                errorMsg = '*กรุณากรอกเลขบัตรประจำตัว 13 หลัก';
                              }
                              return errorMsg;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.black38,
                                  size: 20,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.black26,
                                )),
                              ),
                              controller: _email,
                              validator: (value) {
                                String errorEmail;
                                Pattern regexEmailPattern =
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regex = new RegExp(regexEmailPattern);
                                if (!regex.hasMatch(value)) {
                                  errorEmail =
                                      "*กรุณากรอกอีเมล example@example.com";
                                } else if (regex.hasMatch(value)) {
                                  errorEmail = null;
                                }
                                return errorEmail;
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            decoration: InputDecoration(
                              labelText: 'เบอร์โทรศัพท์',
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 14),
                              prefixIcon: Icon(
                                Icons.phone_android,
                                color: Colors.black38,
                                size: 20,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.black26,
                              )),
                            ),
                            controller: _tel,
                            validator: (value) {
                              String errorMsg;
                              if (value.isEmpty) {
                                errorMsg = '*กรุณากรอกเบอร์โทรศัพท์';
                              }
                              return errorMsg;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RaisedButton(
                                  color: Colors.orange[800],
                                  child: Text('บันทึก',
                                      style: TextStyle(color: Colors.white)),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      // print(images);
                                      var userData = {
                                        'citizenid': _citizenid.text,
                                        'firstname': _firstname.text,
                                        'lastname': _lastname.text,
                                        'nickname': _nickname.text,
                                        'age': _age.text,
                                        'bday': _bday.text,
                                        'email': _email.text,
                                        'tel': _tel.text,
                                      };
                                      userBloc.add(AddUser(userData));
                                    } else {
                                      return showDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder:
                                              (BuildContext dialogContext) {
                                            return AlertDialog(
                                              title: Text(
                                                  'กรูณากรอกข้อมูลให้ครบ!'),
                                              actions: [
                                                FlatButton(
                                                    onPressed: () =>
                                                        Navigator.of(
                                                                dialogContext)
                                                            .pop(),
                                                    child: Text('Close'))
                                              ],
                                            );
                                          });
                                    }
                                  }),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
