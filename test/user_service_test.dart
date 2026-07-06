import 'package:flutter_test/flutter_test.dart';
import 'package:mellodica/services/user_service.dart';
import 'package:mellodica/models/instrument.dart';
import 'package:mellodica/models/level.dart';

void main() {
  late InMemoryUserService service;

  setUp(() {
    service = InMemoryUserService();
    service.clear();
  });

  group('InMemoryUserService', () {
    test('result.success is true when registration is successful', () {
      final result = service.register(
        'MarcusDev',
        'Marcus@dev.com',
        'password',
        Instrument.guitar,
        Level.beginner,
      );

      expect(result.success, isTrue);
      expect(result.error, isNull);
      expect(service.currentUser, isNotNull);
      expect(service.currentUser!.name, equals('MarcusDev'));
      expect(service.currentUser!.email, equals('Marcus@dev.com'));
    });

    test('result.success is false when email is already registered', () {
      service.register(
        'MarcusDev',
        'Marcus@dev.com',
        'password',
        Instrument.guitar,
        Level.beginner,
      );
      final result = service.register(
        'John Doe',
        'Marcus@dev.com',
        'password',
        Instrument.guitar,
        Level.beginner,
      );

      expect(result.success, isFalse);
      expect(result.error, isNotNull);
    });

    test('result.success is false when email is not found during login', () {
      final result = service.login('nonexistent@example.com', 'password');

      expect(result.success, isFalse);
      expect(result.error, isNotNull);
    });

    test('result.success is true when login is successful', () {
      service.register(
        'MarcusDev',
        'Marcus@dev.com',
        'password',
        Instrument.guitar,
        Level.beginner,
      );
      final result = service.login('Marcus@dev.com', 'password');

      expect(result.success, isTrue);
      expect(result.error, isNull);
    });

    test('Logout sets currentUser to null', () {
      service.register(
        'MarcusDev',
        'Marcus@dev.com',
        'password',
        Instrument.guitar,
        Level.beginner,
      );
      service.logout();

      expect(service.currentUser, isNull);
    });
  });
}
