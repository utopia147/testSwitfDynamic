import 'package:flutter_app_todo/repositories/repositories.dart';

class TodoListService {
  Repository _repository;
  TodoListService() {
    _repository = Repository();
  }
  fetchTodoList() async {
    return await _repository.selectData('todolist');
  }

  saveTodoList(Map<String, dynamic> todoList) async {
    return await _repository.insertData('todolist', todoList);
  }

  updateTodoList(Map<String, dynamic> editTodoList) async {
    return await _repository.updateData('todolist', editTodoList);
  }

  removeTodoList(todoID) async {
    return await _repository.deleteData('todolist', todoID);
  }
}
