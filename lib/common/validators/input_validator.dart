class InputValidator {
  static String? validateFirstName(String firstName) {
    if (firstName.trim().isEmpty) {
      return 'First name is required';
    }

    return null;
  }

  static String? validateLastName(String lastName) {
    if (lastName.trim().isEmpty) {
      return 'Last name is required';
    }

    return null;
  }
}
