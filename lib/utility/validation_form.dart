import 'package:screw_calc/utility/reg_exp.dart';

enum TextFieldValidatorType {
  name,
  displayText,
  optional,
  Number,
}

validation(
    {required TextFieldValidatorType type,
    required String value,
    required String firstPasswordForConfirm}) {
  if (type == TextFieldValidatorType.optional) {
    return null;
  } else if (type == TextFieldValidatorType.displayText) {
    if (value.isEmpty) {
      return "هذا الحقل مطلوب";
    }
    // if (value.length < 2) {
    //   return GlobalWords.short_text.tr;
    // }
  } else if (type == TextFieldValidatorType.Number) {
    if (value.isEmpty) {
      return "هذا الحقل مطلوب";
    }

    if (!regExpNumber.hasMatch(value.trim().replaceAll('‎', '')) ||
        value.trim().contains(".") ||
        value.trim().contains(",")) {
      return "لا يجب ان يحتوي علي حروف خاصة";
    }
  } else if (type == TextFieldValidatorType.name) {
    if (value.isEmpty) {
      return "هذا الحقل مطلوب";
    }
    if (value.length < 2) {
      return "عدد حروف الكلمه قصيرة";
    }
    if (value.length > 20) {
      return "عدد حروف الكلمه كبيرة";
    }

    if (!regExpName.hasMatch(value.trim().replaceAll('‎', ''))) {
      return "لا يجب ان يحتوي علي حروف خاصة";
    }

    return null;
  } else {
    if (value.isEmpty) {
      return "هذا الحقل مطلوب";
    }
    if (value.length < 2) {
      return "عدد حروف الكلمه قصيرة";
    }

    return null;
  }
}
