part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  final ImageProvider? photo;
  final String? name;
  final String? email;

  const DashboardState({
    this.photo,
    this.name,
    this.email,
  });

  DashboardState copyWith({
    required ImageProvider photo,
    required String email,
    required String name,
  }) {
    return DashboardState(
      email: this.email,
      name: this.name,
      photo: this.photo,
    );
  }

  @override
  List<Object> get props => [];
}
