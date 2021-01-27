import 'package:flutter/material.dart';
import 'package:flutter_app_todo/Page/todo_list_edit_page.dart';
import 'package:flutter_app_todo/bloc/todo_list_bloc.dart';

class TodoListDetailPage extends StatelessWidget {
  const TodoListDetailPage(
      {Key key,
      @required this.todoListBloc,
      @required this.id,
      @required this.title,
      @required this.detail})
      : super(key: key);

  final TodoListBloc todoListBloc;
  final int id;
  final String title;
  final String detail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Todo List Detail'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TodoListEditPage(
                          todoListBloc: todoListBloc,
                          id: id,
                          oldTitle: title,
                          oldDetail: detail)));
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'หัวเรื่อง $title',
                style: TextStyle(fontSize: 30),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'รายละเอียด $detail',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
