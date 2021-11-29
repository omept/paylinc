part of 'wallets_bloc.dart';

abstract class WalletsEvent extends Equatable {
  const WalletsEvent();

  @override
  List<Object> get props => [];
}

class WalletsUsernameChanged extends WalletsEvent {
  const WalletsUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class WalletsPasswordChanged extends WalletsEvent {
  const WalletsPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class WalletsSubmitted extends WalletsEvent {
  const WalletsSubmitted();
}
