class EmailValidator {
  static String? validate(String email) {
    if (email.trim().isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

    if (!emailRegex.hasMatch(email.trim())) {
      return 'Enter a valid email';
    }

    return null;
  }
}
