import 'instrument.dart';
import 'level.dart';

class User {
  final String name;
  final String email;
  final Instrument instrument;
  final Level level;

  const User({
    required this.name,
    required this.email,
    required this.instrument,
    required this.level,
  });
}
