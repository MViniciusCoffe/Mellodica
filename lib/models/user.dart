import 'instrument.dart';

class User {
  final String name;
  final String email;
  final Instrument instrument;

  const User({
    required this.name,
    required this.email,
    required this.instrument,
  });
}
