class UserEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String dob;
  final String gender;
  final String about;
  final String pfp;
  final String cover;

  const UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.dob,
    required this.gender,
    required this.about,
    required this.pfp,
    required this.cover,
  });
}
