import 'package:flutter_app_keepdata_person/repositories/repository.dart';

class UserService {
  Repository _repository;
  UserService() {
    _repository = Repository();
  }

  fetchUser() async {
    return await _repository.selectData('user');
  }

  addUser(userData) async {
    return await _repository.inserData('user', userData);
  }
}
