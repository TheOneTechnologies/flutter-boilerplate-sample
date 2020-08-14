import 'package:flutter_naming_convention/ui/login/login_screen.dart';
import 'package:flutter_naming_convention/ui/splash/splash.dart';
import 'package:flutter_naming_convention/utils/util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Login', () {
    test('Empty User Test', () {
      var result = FormValidate.validateUsername('');
      expect(result, 'Please enter username!');
    });

    test('Valid User Test', () {
      var result = FormValidate.validateUsername('riya');
      expect(result, null);
    });
    test('Empty Password Test', () {
      var result = FormValidate.validatePassword('');
      expect(result, 'Please choose a password.');
    });

    test('Valid Password Test', () {
      var result = FormValidate.validatePassword('riya123');
      expect(result, null);
    });
  });

}