// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class NumericInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     // Remove any non-numeric characters from the new value
//     String filteredValue = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
//
//     // Return the updated value with the numeric characters only
//     return TextEditingValue(
//       text: filteredValue,
//       selection: TextSelection.collapsed(offset: filteredValue.length),
//     );
//   }
// }
//
// class AlphabeticInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     // Remove any non-alphabetic characters from the new value
//     // String filteredValue = newValue.text.replaceAll(RegExp(r'[^a-zA-Z]'), '');
//     String filteredValue = newValue.text.replaceAll(RegExp(r'[^a-zA-Z\s]'), '');
//
//     // Return the updated value with alphabetic characters only
//     return TextEditingValue(
//       text: filteredValue,
//       selection: TextSelection.collapsed(offset: filteredValue.length),
//     );
//   }
// }
//
// class AlphaNumericSplInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//     TextEditingValue oldValue,
//     TextEditingValue newValue,
//   ) {
//     // Use a regular expression to remove any characters that are not alphabetic,
//     // numeric, space, '@', or '.'.
//     final newValueText =
//         newValue.text.replaceAll(RegExp(r'[^a-zA-Z0-9@. ]'), '');
//
//     return newValue.copyWith(
//       text: newValueText,
//       selection: TextSelection.collapsed(offset: newValueText.length),
//     );
//   }
// }
//
// class AlphabeticSpaceDotInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     // Allow only alphabetic characters, spaces, and dot '.' symbols
//     String newText = newValue.text.replaceAll(RegExp(r'[^a-zA-Z .]'), '');
//
//     return newValue.copyWith(text: newText);
//   }
// }
