/// Validators class (add to your utils)
class Validators {
  /// Check if string is valid email
  static bool isEmail(String value) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
    );
    return emailRegex.hasMatch(value);
  }

  /// Check if string is valid phone number
  static bool isPhoneNumber(String value) {
    // Remove all non-digit characters
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');

    // Check for common phone number lengths (8-15 digits)
    if (digitsOnly.length != 10) {
      return false;
    }

    // Additional checks for specific formats
    final phoneRegex = RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
    return phoneRegex.hasMatch(value);
  }

  /// Check if password is strong
  static bool isStrongPassword(String password) {
    if (password.length < 8) return false;

    final hasUpper = password.contains(RegExp(r'[A-Z]'));
    final hasLower = password.contains(RegExp(r'[a-z]'));
    final hasNumber = password.contains(RegExp(r'[0-9]'));
    final hasSpecial = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    return hasUpper && hasLower && hasNumber && hasSpecial;
  }

  /// Check if password has special character
  static bool hasSpecialCharacter(String password) {
    return password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  /// Validate email with detailed error
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!isEmail(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  /// Validate phone with detailed error
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (!isPhoneNumber(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  /// Validate password with detailed error
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    if (!hasSpecialCharacter(value)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }
}
