bool isStrongPassword(String password) {
  if (password.length < 6) {
    return false;
  } else {
    return true;
  }
}

class PasswordValidation {
  static isStrongPass(String password) {
    if (password.isEmpty) {
      return "This field is required";
    } else if (isStrongPassword(password)) {
      return null;
    } else {
      return "Too short password";
    }
  }
}
