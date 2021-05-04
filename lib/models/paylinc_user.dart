import "package:user_repository/user_repository.dart";

class PaylincUser extends User {
  const PaylincUser(String id, String uuid, String firstName, String lastName, String avatarUrl, int countryId) : this.countryId = countryId, super(id, uuid, firstName, lastName, avatarUrl);

  final int countryId;
  static const empty = PaylincUser('-', '-', '', '', '', 0);
}