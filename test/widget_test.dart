import 'package:flutter_test/flutter_test.dart';
import 'package:mellodica/controllers/fields_validators.dart';

void main() {
  group('FieldsValidators', () {
    final validators = FieldsValidators();

    group('validateEmail', () {
      test('returns error when email is null', () {
        expect(validators.validateEmail(null), 'Email é obrigatório');
      });

      test('returns error when email is empty', () {
        expect(validators.validateEmail(''), 'Email é obrigatório');
      });

      test('returns error for invalid email', () {
        expect(validators.validateEmail('abc'), 'E-mail Inválido');
      });

      test('returns error for email without domain', () {
        expect(validators.validateEmail('user@'), 'E-mail Inválido');
      });

      test('returns null for valid email', () {
        expect(validators.validateEmail('user@example.com'), isNull);
      });
    });

    group('validatePassword', () {
      test('returns error when password is null', () {
        expect(validators.validatePassword(null), 'Senha é obrigatória');
      });

      test('returns error when password is empty', () {
        expect(validators.validatePassword(''), 'Senha é obrigatória');
      });

      test('returns error when password is too short', () {
        expect(validators.validatePassword('abc'), 'Senha deve ter pelo menos 6 caracteres');
      });

      test('returns null for valid password', () {
        expect(validators.validatePassword('123456'), isNull);
      });
    });

    group('required (static)', () {
      test('returns error when value is null', () {
        expect(FieldsValidators.required(null, 'Nome'), 'Nome é obrigatório');
      });

      test('returns error when value is empty', () {
        expect(FieldsValidators.required('', 'Nome'), 'Nome é obrigatório');
      });

      test('returns null when value is present', () {
        expect(FieldsValidators.required('João', 'Nome'), isNull);
      });
    });
  });
}
