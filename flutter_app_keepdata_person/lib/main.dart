import 'package:flutter/material.dart';
import 'package:flutter_app_keepdata_person/Page/user_add_page.dart';
import 'package:flutter_app_keepdata_person/Page/user_detail_page.dart';
import 'package:flutter_app_keepdata_person/bloc/user_bloc.dart';
import 'package:flutter_app_keepdata_person/user_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = UserObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => UserBloc(),
        child: MyHomePage(title: 'User'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  UserBloc _userBloc;

  @override
  Widget build(BuildContext context) {
    var _children = <Widget>[];
    var _userBloc = BlocProvider.of<UserBloc>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () => _userBloc.add(FetchUser()))
        ],
      ),
      body: BlocConsumer<UserBloc, UserState>(
        cubit: _userBloc,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is UserInitial) {
            _userBloc.add(FetchUser());
          } else if (state is FetchLoading) {
            _children = <Widget>[
              Center(
                child: RefreshProgressIndicator(),
              )
            ];
          } else if (state is FetchedEmpty) {
            _children = <Widget>[
              Expanded(child: Container()),
              Expanded(
                  child: Container(
                child:
                    Text('ไม่พบข้อมูลสามารถเพิ่มข้อมูลบุคคล กดปุ่ม + ขวาล่าง'),
              )),
            ];
          } else if (state is FetchedDone) {
            List usersData = state.user;
            _children = <Widget>[
              SingleChildScrollView(
                child: Column(
                  children: List.generate(usersData.length, (index) {
                    var citizenid = usersData[index]['citizenid'];
                    var firstname = usersData[index]['firstname'];
                    var lastname = usersData[index]['lastname'];
                    var nickname = usersData[index]['nickname'];
                    var age = usersData[index]['age'];
                    var bday = usersData[index]['bday'];
                    var email = usersData[index]['email'];
                    var tel = usersData[index]['tel'];
                    return Card(
                      child: ListTile(
                        contentPadding: EdgeInsets.all(10),
                        leading: CircleAvatar(
                          child: Container(
                            child: Icon(Icons.account_circle),
                          ),
                        ),
                        title: Text(
                          'ชื่อ: ${usersData[index]['firstname']} นามสกุล: ${usersData[index]['lastname']}',
                        ),
                        subtitle: Text(
                            'Email:${usersData[index]['email']} Tel:${usersData[index]['tel']}'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserDetailPage(
                                        citizenid: citizenid,
                                        firstname: firstname,
                                        lastname: lastname,
                                        nickname: nickname,
                                        age: age,
                                        bday: bday,
                                        email: email,
                                        tel: tel,
                                      )));
                        },
                      ),
                    );
                  }),
                ),
              ),
            ];
          }
          return Column(
            children: _children,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UserAddPage(
                    userBloc: _userBloc,
                  )),
        ),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
