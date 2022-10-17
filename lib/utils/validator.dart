class Validator {
  static String? validateName({required String? name}) {
    if (name == null) {
      return null;
    }

    if (name.isEmpty) {
      return 'Name can\'t be empty';
    }

    return null;
  }

  static String? validateEmail({required String? email}) {
    if (email == null) {
      return null;
    }

    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter a correct email';
    }

    return null;
  }

  static String? validatePassword({required String? password}) {
    if (password == null) {
      return null;
    }

    if (password.isEmpty) {
      return 'Password can\'t be empty';
    } else if (password.length < 6) {
      return 'Enter a password with length at least 6';
    }

    return null;
  }

  static String? validatePhone({required String? phone}) {
    String pattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
    RegExp regExp = new RegExp(pattern);
    if (phone == null) {
      return null;
    }

    if (phone.isEmpty) {
      return 'Phone Number can\'t be empty';
    } else if (!regExp.hasMatch(phone)) {
      return 'Enter correct number or remove space!';
    }
    return null;
  }

  static String? validateAnswer({required String? answer}) {
    if (answer == null) {
      return null;
    }
    if (answer.isEmpty) {
      return 'Answer can\'t be empty!';
    }

    return null;
  }
}
