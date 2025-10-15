import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Validation {
  static String? validateEmail(String? value) {
    final email = value?.trim();
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validateFirstName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'First name is required';
    } else if (value.trim().length > 30) {
      return 'Maximum 30 characters allowed';
    }
    return null;
  }

  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    } else if (value.trim().length > 30) {
      return 'Maximum 30 characters allowed';
    }
    return null;
  }

  static String? validateSecondtName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Last name is required';
    } else if (value.trim().length > 15) {
      return 'Maximum 15 characters allowed';
    }
    return null;
  }

  static String? validateMedicationName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Medication name is required';
    } else if (value.trim().length < 4) {
      return 'Minimum 4 characters required';
    } else if (value.trim().length > 25) {
      return 'Maximum 25 characters allowed';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
      // } else if (!RegExp(r'^\d{10}$').hasMatch(value.trim())) {
      //   return 'Enter a valid 10-digit number';
    }
    return null;
  }

  static String? validatePhoneIndia(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    } else if (!RegExp(r'^\d{10}$').hasMatch(value.trim())) {
      return 'Enter a valid 10-digit number';
    }
    return null;
  }

  static String? validatePinCode(String? value) {
    final trimmedValue = value?.trim();
    if (trimmedValue == null || trimmedValue.isEmpty) {
      return 'Pin code is required';
    } else if (!RegExp(r'^\d{6}$').hasMatch(trimmedValue)) {
      return 'Enter a valid 6-digit pin code';
    }
    return null;
  }

  static String? validatePhone10(String? value, String countryID) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }

    final trimmedValue = value.trim();

    // Check for any non-digit characters
    if (!RegExp(r'^\d+$').hasMatch(trimmedValue)) {
      return 'Phone number must contain only digits';
    }

    // Country-specific rule for India (countryID "102")
    if (countryID == "102" && trimmedValue.length != 10) {
      return 'Enter a valid 10-digit number';
    }

    return null;
  }

  static String? validateGender(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please select a gender';
    }
    return null;
  }

  static String? validateDOB(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Date of Birth is required';
    }

    try {
      final dob = DateFormat('dd/MM/yyyy').parseStrict(value);
      final now = DateTime.now();

      if (dob.isAfter(now)) {
        return 'Date of Birth cannot be in the future';
      }
    } catch (e) {
      return 'Enter date in dd/MM/yyyy format';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    String returnData = "Password must be at least 4 characters long ";
    if (value == null || value.isEmpty) {
      return returnData;
    }

    if (value.length < 4) {
      return returnData;
    }
    return null;
  }

  static String? confirmPasswordValidator(
    String? value,
    TextEditingController originalController,
  ) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != originalController.text) {
      return 'Passwords do not match';
    }

    return null;
  }

  static String? addressValidator(
    String? value, {
    String fieldName = 'This field',
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? postalCodeValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your postal code';
    }

    if (!RegExp(r'^\d{6}$').hasMatch(value)) {
      return 'Enter a valid 6-digit postal code';
    }

    return null;
  }

  static String? validateForCountry(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Country is required';
    } else if (value.trim().length > 15) {
      return 'Maximum 15 characters allowed';
    }
    return null;
  }

  static String? validateForCity(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'City is required';
    } else if (value.trim().length > 15) {
      return 'Maximum 15 characters allowed';
    }
    return null;
  }

  static String? validateForState(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'State is required';
    } else if (value.trim().length > 15) {
      return 'Maximum 15 characters allowed';
    }
    return null;
  }

  static String? field(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? validatedobinput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Date of Birth is required';
    }

    final RegExp dobRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
    if (!dobRegex.hasMatch(value)) {
      return 'Enter DOB in DD/MM/YYYY format';
    }

    try {
      final parts = value.split('/');
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);

      final dob = DateTime(year, month, day);
      final now = DateTime.now();

      // Check if the date is valid
      if (dob.year != year || dob.month != month || dob.day != day) {
        return 'Enter a valid date';
      }

      final age =
          now.year -
          dob.year -
          ((now.month < dob.month ||
                  (now.month == dob.month && now.day < dob.day))
              ? 1
              : 0);

      if (age < 0 || age > 130) {
        return 'Enter a realistic date of birth';
      }

      return null; // valid
    } catch (_) {
      return 'Invalid date';
    }
  }

  static String? validateCVfield(
    String? value, {
    String fieldName = 'This field',
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? validateAccountNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Account number is required';
    }

    final trimmedValue = value.trim();

    // Check for any non-digit characters
    if (!RegExp(r'^\d+$').hasMatch(trimmedValue)) {
      return 'Account number must contain only digits';
    }

    if (!RegExp(r'^.{8,80}$').hasMatch(trimmedValue)) {
      return 'Account number have atleat 8 digits';
    }

    return null;
  }

  static String? validateRoutigNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Routing number is required';
    }

    final trimmedValue = value.trim();

    // Check for any non-digit characters
    if (!RegExp(r'^\d{8,}$').hasMatch(trimmedValue)) {
      // return 'Routing number must contain only digits';
    }
    return null;
  }

  static String? validateDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'date is required';
    }

    try {
      final date = DateFormat('dd/MM/yyyy').parseStrict(value);
    } catch (e) {
      return 'Enter date in dd/MM/yyyy format';
    }

    return null;
  }
}
