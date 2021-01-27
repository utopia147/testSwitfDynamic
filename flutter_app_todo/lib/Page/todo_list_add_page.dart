import 'package:flutter/material.dart';
import 'package:flutter_app_todo/bloc/todo_list_bloc.dart';
import 'package:flutter_app_todo/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoListAddPage extends StatelessWidget {
  TodoListAddPage({Key key, @required this.todoListBloc}) : super(key: key);
  final TodoListBloc todoListBloc;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController todoListTitle = TextEditingController();
    TextEditingController todoListDetail = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                todoListBloc
                    .add(TodoListAdd(todoListTitle.text, todoListDetail.text));
              }
            },
          ),
        ],
        title: Text('เพิ่ม Todo'),
        centerTitle: true,
      ),
      body: BlocConsumer<TodoListBloc, TodoListState>(
        cubit: todoListBloc,
        listener: (context, state) {
          if (state is TodoListAddSucessful) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyApp()));
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            autovalidate: true,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: Colors.black26),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black54),
                          controller: todoListTitle,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'กรุณาใส่หัวเรื่อง';
                            }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Title',
                            labelStyle:
                                TextStyle(color: Colors.black54, fontSize: 14),
                            prefixIcon: Icon(
                              Icons.view_headline,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.5, color: Colors.black26),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black54),
                          controller: todoListDetail,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'กรุณาใส่รายละเอียด';
                            }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Detail',
                            labelStyle:
                                TextStyle(color: Colors.black54, fontSize: 14),
                            prefixIcon: Icon(
                              Icons.content_copy,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
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
