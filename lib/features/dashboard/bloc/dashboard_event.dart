part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class DashboardUsernameChanged extends DashboardEvent {
  const DashboardUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class DashboardPasswordChanged extends DashboardEvent {
  const DashboardPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class DashboardSubmitted extends DashboardEvent {
  const DashboardSubmitted();
}
