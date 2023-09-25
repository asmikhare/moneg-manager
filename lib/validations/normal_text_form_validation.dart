class NormalTextFormValidation {
  validateNormalText(String text) {
    if (text.isEmpty) {
      return "This field is required";
    } else {
      return null;
    }
  }
}
