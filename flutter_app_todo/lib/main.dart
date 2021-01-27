import 'package:flutter/material.dart';
import 'package:flutter_app_todo/Page/todo_list_add_page.dart';
import 'package:flutter_app_todo/Page/todo_list_detail_page.dart';
import 'package:flutter_app_todo/bloc/todo_list_bloc.dart';
import 'package:flutter_app_todo/todoList_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = TodoListObserver();
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
        create: (context) => TodoListBloc(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  TodoListBloc _todoListBloc;
  var checked = false;
  @override
  Widget build(BuildContext context) {
    var id;
    _todoListBloc = BlocProvider.of<TodoListBloc>(context);
    var _children = <Widget>[];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Todo List'),
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () => _todoListBloc.add(TodoListFetch())),
        ],
      ),
      body: BlocConsumer<TodoListBloc, TodoListState>(
        cubit: _todoListBloc,
        listener: (context, state) {
          if (state is TodoListAlertConfrimDelete) {
            return showDialog(
              context: context,
              barrierDismissible: false,
              builder: (dialogContext) => AlertDialog(
                title: Text(
                  'ยืนยัน',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                content: Text(
                  'ต้องการลบ Todo List ใช่หรือไม่',
                  style: TextStyle(color: Colors.black),
                ),
                actions: [
                  FlatButton(
                    child: new Text(
                      "ใช่",
                    ),
                    onPressed: () {
                      Navigator.pop(dialogContext);
                      _todoListBloc.add(TodoListRemove(id));
                    },
                  ),
                  FlatButton(
                    child: Text(
                      "ไม่",
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () => Navigator.pop(dialogContext),
                  ),
                ],
              ),
            );
          } else if (state is TodoListDeleteSucessful) {
            _todoListBloc.add(TodoListFetch());
          }
        },
        builder: (context, state) {
          if (state is TodoListInitial) {
            _todoListBloc.add(TodoListFetch());
          } else if (state is TodoListFetchedLoading) {
            _children = <Widget>[
              Center(
                child: RefreshProgressIndicator(),
              ),
            ];
          } else if (state is TodoListFetchedEmpty) {
            _children = <Widget>[
              Expanded(
                child: Container(),
              ),
              Expanded(
                child: Center(
                    child: Text(
                  'ไม่มีข้อมูล Todo กดปุ่ม + เพื่อเพิ่ม',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black45,
                  ),
                )),
              ),
              Expanded(
                child: Container(),
              ),
            ];
          } else if (state is TodoListFetchedDone) {
            print(state.todoListFected.length);
            List todoListItem = state.todoListFected;
            _children = <Widget>[
              SingleChildScrollView(
                child: Column(
                  children: List.generate(todoListItem.length, (index) {
                    id = todoListItem[index]['id'];
                    return Card(
                      child: ListTile(
                        contentPadding: EdgeInsets.all(10),
                        title: Center(
                            child: Text('${todoListItem[index]['title']}')),
                        subtitle: Center(
                            child: Text('${todoListItem[index]['detail']}')),
                        trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _todoListBloc.add(TodoListConfrimDelete());
                            }),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TodoListDetailPage(
                                        todoListBloc: _todoListBloc,
                                        id: todoListItem[index]['id'],
                                        title: todoListItem[index]['title'],
                                        detail: todoListItem[index]['detail'],
                                      )));
                        },
                      ),
                    );
                  }),
                ),
              )
              //  (context, index) {
              //   return Card(
              //     child: ListTile(),
              //   );
              // },
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
                builder: (context) => TodoListAddPage(
                      todoListBloc: _todoListBloc,
                    ))),
        tooltip: 'Add Todo',
        child: Icon(Icons.add),
      ),
    );
  }
}
