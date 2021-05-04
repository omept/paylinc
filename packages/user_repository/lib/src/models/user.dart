import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(this.id, this.uuid, this.firstName, this.lastName, this.avatarUrl);
  User.fromJson(Map json) :
      id = json["id"] as String,
      uuid = json["uuid"] as String,
      firstName = json["firstName"],
      lastName = json["lastName"],
      avatarUrl = json["avatarUrl"];

  final String id;
  final String uuid;
  final String firstName;
  final String lastName;
  final String avatarUrl;

  @override
  List<Object> get props => [id, uuid];

  static const empty = User('-', '-', '', '', '');
  
}