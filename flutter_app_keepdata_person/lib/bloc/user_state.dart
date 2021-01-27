part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class FetchLoading extends UserState {}

class FetchedEmpty extends UserState {}

class FetchedDone extends UserState {
  List<Map<String, dynamic>> user;
  FetchedDone(this.user);
}

class AddUserSucessful extends UserState {}
