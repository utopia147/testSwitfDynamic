import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:flutter_app_todo/repositories/repositories.dart';
import 'package:flutter_app_todo/service/todo_list_service.dart';
import 'package:meta/meta.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc() : super(TodoListInitial());
  TodoListService _todoListService = TodoListService();

  @override
  Stream<TodoListState> mapEventToState(
    TodoListEvent event,
  ) async* {
    if (event is TodoListFetch) {
      yield* _mapTodoListFetchToState();
    } else if (event is TodoListAdd) {
      yield* _mapTodoListAddToState(event);
    } else if (event is TodoListEdit) {
      yield* _mapTodoListEditToState(event);
    } else if (event is TodoListConfrimDelete) {
      yield TodoListAlertConfrimDelete();
    } else if (event is TodoListRemove) {
      yield* _mapTodoListRemoveToState(event);
    }
  }

  Stream<TodoListState> _mapTodoListFetchToState() async* {
    try {
      yield TodoListFetchedLoading();
      await Future.delayed(Duration(seconds: 1));
      var result = await _todoListService.fetchTodoList();
      print(result);
      if (result.length != 0) {
        yield TodoListFetchedDone(result);
      } else {
        yield TodoListFetchedEmpty();
      }
    } catch (e) {
      print(e);
    }
  }

  Stream<TodoListState> _mapTodoListAddToState(event) async* {
    try {
      // print(event.title);
      // print(event.detail);
      Map<String, dynamic> todoListData = {
        'title': event.title,
        'detail': event.detail
      };
      var result = await _todoListService.saveTodoList(todoListData);
      print(result);
      yield TodoListAddSucessful();
    } catch (e) {
      print(e);
    }
  }

  Stream<TodoListState> _mapTodoListEditToState(event) async* {
    try {
      // print(event.title);
      // print(event.detail);
      Map<String, dynamic> editTodoListData = {
        'id': event.id,
        'title': event.title,
        'detail': event.detail
      };
      var result = await _todoListService.updateTodoList(editTodoListData);
      print(result);
      yield TodoListEditSucessful();
    } catch (e) {
      print(e);
    }
  }

  Stream<TodoListState> _mapTodoListRemoveToState(event) async* {
    try {
      var result = await _todoListService.removeTodoList(event.id);
      print(result);
      yield TodoListDeleteSucessful();
    } catch (e) {
      print(e);
    }
  }
}
