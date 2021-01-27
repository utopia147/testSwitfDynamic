part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class FetchUser extends UserEvent {}

class AddUser extends UserEvent {
  final Map<String, dynamic> userData;

  AddUser(this.userData);
}
