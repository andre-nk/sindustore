import 'package:formz/formz.dart';

enum PINValidationError { invalid }

class PIN extends FormzInput<String, PINValidationError>{
  const PIN.pure() : super.pure('');

  const PIN.dirty([String value = '']) : super.dirty(value);

  static final RegExp _pinRegExp = RegExp(r'^[/^(\d{6})$/]');

  @override
  PINValidationError? validator(String? value){
    return _pinRegExp.hasMatch(value ?? '')
    ? null
    : PINValidationError.invalid;
  }
}