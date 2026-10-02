class SignupUserReq {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String dob;
  final String gender;

  SignupUserReq({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.dob,
    required this.gender,
  });
}
