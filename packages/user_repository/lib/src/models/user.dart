import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(this.id, this.firstName, this.lastName, this.avatarUrl);

  final String id;
  final String firstName;
  final String lastName;
  final String avatarUrl;

  @override
  List<Object> get props => [id];

  static const empty = User('-', '', '', '');
}