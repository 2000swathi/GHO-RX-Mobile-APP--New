import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Validation {
   static final DateFormat _format = DateFormat('dd MMM yyyy');
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
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value.trim())) {
      return 'Phone number must contain only digits';
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

    if (!RegExp(r'^\d+$').hasMatch(trimmedValue)) {
      return 'Phone number must contain only digits';
    }

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
      // Handle both "dd/MM/yyyy" and "dd / MM / yyyy"
      final dateString = value.replaceAll(' ', '');
      final dob = DateFormat('dd/MM/yyyy').parseStrict(dateString);
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

  static String? validateDate(String? value, {String fieldName = 'Date'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    final trimmedValue = value.trim();

    // Accepts formats like "06 June, 2025" or "6 June, 2025"
    final RegExp dateRegex = RegExp(r'^\d{1,2}\s+[A-Za-z]+,\s+\d{4}$');

    if (!dateRegex.hasMatch(trimmedValue)) {
      return 'Enter $fieldName in DD Month, YYYY format (e.g. 06 June, 2025)';
    }

    try {
      final parts = trimmedValue.replaceAll(',', '').split(RegExp(r'\s+'));
      final day = int.parse(parts[0]);
      final monthName = parts[1].toLowerCase();
      final year = int.parse(parts[2]);

      // Map month names to numbers
      final months = {
        'january': 1,
        'february': 2,
        'march': 3,
        'april': 4,
        'may': 5,
        'june': 6,
        'july': 7,
        'august': 8,
        'september': 9,
        'october': 10,
        'november': 11,
        'december': 12,
      };

      final month = months[monthName];
      if (month == null) return 'Enter a valid month name';

      final date = DateTime(year, month, day);

      // Ensure the parsed date matches the input
      if (date.year != year || date.month != month || date.day != day) {
        return 'Enter a valid $fieldName';
      }

      return null; // ✅ Valid date
    } catch (_) {
      return 'Invalid $fieldName';
    }
  }

  static String? validateSpecialty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please choose a specialty';
    }
    return null;
  }

  static String? validateCertifiedBoard(Object? value) {
    if (value == null || value.toString().trim().isEmpty) {
      return 'Please choose a certfified board';
    }
    return null;
  }

  static String? validateSpecialtyType(Object? value) {
    if (value == null || value.toString().trim().isEmpty) {
      return 'Choose a specialty type';
    }
    return null;
  }
  static String? validateLicenecType(Object? value) {
    if (value == null || value.toString().trim().isEmpty) {
      return 'Choose a licence type';
    }
    return null;
  }

  static String? validateID(String? value, {String fieldName = 'ID'}) {
    if (value == null || value.trim().isEmpty) {
      return 'Id is required';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value.trim())) {
      return 'Must contain only digits';
    }
    return null;
  }


  static String? validateProviderName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Field is required';
    }
    return null;
  }

  static String? validateAccreditationNumber(
    String? value, {
    String fieldName = 'Accreditation Number',
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'Field is required';
    }

    {
      if (value.trim().isEmpty) {
        return 'Field is required';
      }

      if (!RegExp(r'^[0-9]+$').hasMatch(value.trim())) {
        return '$fieldName must contain only digits';
      }
      if (!RegExp(r'^[0-9]+$').hasMatch(value.trim())) {
        return '$fieldName must contain only digits';
      }

      return null;
    }
  }

  //issue date
   static String? validateIssueDate(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select issue date";
    }

    try {
      final date = _format.parse(value);
      final now = DateTime.now();
      
      final today = DateTime(now.year, now.month, now.day);
      final issue = DateTime(date.year, date.month, date.day);

      if (issue.isAfter(today)) {
        return "Enter a valid issue date";
      }
    } catch (e) {
      return "Invalid date format";
    }
    return null;
  }

  //expiry date
  static String? validateExpiryDate(String? issueDate, String? expiryDate) {
    if (expiryDate == null || expiryDate.isEmpty) {
      return "Please select expiry date";
    }

    try {
      final expiry = _format.parse(expiryDate);
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      if (!expiry.isAfter(today)) {
        return "Enter a valid expiry date";
      }

      if (issueDate != null && issueDate.isNotEmpty) {
        final issue = _format.parse(issueDate);
        if (!expiry.isAfter(issue)) {
          return "Expiry date must be after issue date";
        }
      }
    } catch (e) {
      return "Invalid date format";
    }

    return null;
  }

}
