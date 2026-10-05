class UserEntity {
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String dob;
  final String gender;
  final String about;
  final String avatarUrl;
  final String coverUrl;
  final String createdAt;

  const UserEntity({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.dob,
    required this.gender,
    required this.about,
    required this.avatarUrl,
    required this.coverUrl,
    required this.createdAt,
  });
}
