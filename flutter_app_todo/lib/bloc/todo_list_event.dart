part of 'todo_list_bloc.dart';

@immutable
abstract class TodoListEvent {}

class TodoListAdd extends TodoListEvent {
  final String title;
  final String detail;

  TodoListAdd(this.title, this.detail);
}

class TodoListEdit extends TodoListEvent {
  final int id;
  final String title;
  final String detail;

  TodoListEdit(this.id, this.title, this.detail);
}

class TodoListRemove extends TodoListEvent {
  final int id;

  TodoListRemove(this.id);
}

class TodoListFetch extends TodoListEvent {}

class TodoListConfrimDelete extends TodoListEvent {}
