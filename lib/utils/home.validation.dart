import 'package:formz/formz.dart';

enum AmountValidationError { empty,amount}

class Amount extends FormzInput<String, AmountValidationError> {
  const Amount.pure() : super.pure('');

  const Amount.dirty({String value = ''}) : super.dirty(value);

  @override
  AmountValidationError? validator(String? value) {
    String input = value ?? '';
    if (input.isEmpty) {
      return AmountValidationError.empty;
    }
    return null;
  }

}
extension Explanation on AmountValidationError {
  String? get getDesErr {
    switch (this) {
      case AmountValidationError.empty:
        return 'Amount could not be empty';
      default:
        return null;
    }
  }
}
