/// Temporary form state used while the multi-step signup flow is in progress.
/// This is presentation state, not an API/data model, so it intentionally
/// lives in the presentation layer.
class SignupData {
  String? firstName;
  String? lastName;
  String? email;
  String? dob;
  String? gender;
  String? password;

  SignupData({
    this.firstName,
    this.lastName,
    this.email,
    this.dob,
    this.gender,
    this.password,
  });
}
