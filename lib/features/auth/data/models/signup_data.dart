class SignupData {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? dob;
  String? gender;

  SignupData({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.dob,
    this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'dob': dob,
      'gender': gender,
    };
  }
}
