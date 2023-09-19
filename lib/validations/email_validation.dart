bool isEmailValid(String email) {
  // Regular expression for basic email validation
  final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  return emailRegExp.hasMatch(email);
}

class EmailValidation {
  static validateEmail(String emailAddress) {
    if (emailAddress.isEmpty) {
      return "This field is required";
    } else if (isEmailValid(emailAddress) == true) {
      return null;
    } else {
      return "Enter a valid email";
    }
  }
}
