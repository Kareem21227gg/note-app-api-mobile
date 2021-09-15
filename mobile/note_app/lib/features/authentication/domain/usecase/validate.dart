String? emailValidate(String? email) {
  if (email == null) {
    return "email can not be empty";
  } else if (!email.endsWith(".com")) {
    return "please enter a valid email address";
  }
  return null;
}

String? passwordValidate(String? password) {
  if (password == null) {
    return "password can not be empty";
  } else if (password.length < 6) {
    return "password should be 6 characters or more";
  }
  return null;
}

String? nameValidate(String? name) {
  if (name == null) {
    return "name can not be empty";
  }
}
