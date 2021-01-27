part of 'todo_list_bloc.dart';

@immutable
abstract class TodoListState {}

class TodoListInitial extends TodoListState {}

class TodoListFetchedLoading extends TodoListState {}

class TodoListFetchedEmpty extends TodoListState {}

class TodoListFetchedDone extends TodoListState {
  final List todoListFected;

  TodoListFetchedDone(this.todoListFected);
}

class TodoListAlertConfrimDelete extends TodoListState {}

class TodoListAddSucessful extends TodoListState {}

class TodoListEditSucessful extends TodoListState {}

class TodoListDeleteSucessful extends TodoListState {}
