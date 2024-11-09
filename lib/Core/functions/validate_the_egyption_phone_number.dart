
String? validateEgyptianPhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a phone number';
  }

  final RegExp regex = RegExp(r'^1[0-2,5][0-9]{8}$');

  if (!regex.hasMatch(value)) {
    return 'رجاء ادخال رقم هاتف فعال';
  }

  return null;
}
