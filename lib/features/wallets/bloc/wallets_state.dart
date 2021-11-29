part of 'wallets_bloc.dart';

class WalletsState extends Equatable {
  final ImageProvider? photo;
  final String? name;
  final String? email;

  const WalletsState({
    this.photo,
    this.name,
    this.email,
  });

  WalletsState copyWith({
    required ImageProvider photo,
    required String email,
    required String name,
  }) {
    return WalletsState(
      email: this.email,
      name: this.name,
      photo: this.photo,
    );
  }

  @override
  List<Object> get props => [];
}
