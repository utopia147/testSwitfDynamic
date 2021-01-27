import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_app_keepdata_person/service/user_service.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());
  UserService _userService = UserService();
  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is FetchUser) {
      yield* _mapFetchUserToState();
    } else if (event is AddUser) {
      yield* _mapAddUserToState(event);
    }
  }

  Stream<UserState> _mapFetchUserToState() async* {
    try {
      yield FetchLoading();
      await Future.delayed(Duration(seconds: 1));
      var fetchedResult = await _userService.fetchUser();
      if (fetchedResult.length != 0) {
        print(fetchedResult);
        yield FetchedDone(fetchedResult);
      } else {
        yield FetchedEmpty();
      }
    } catch (e) {
      print(e);
    }
  }

  Stream<UserState> _mapAddUserToState(event) async* {
    try {
      print(event.userData);
      var addUser = await _userService.addUser(event.userData);
      print(addUser);
      yield AddUserSucessful();
    } catch (e) {
      print(e);
    }
  }
}
