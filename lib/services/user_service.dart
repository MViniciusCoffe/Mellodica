import '../models/user.dart';
import '../models/instrument.dart';

class Result {
  final bool success;
  final String? error;

  const Result({required this.success, this.error});
}

class InMemoryUserService {
  static final InMemoryUserService _instance = InMemoryUserService._internal();

  factory InMemoryUserService() => _instance;

  InMemoryUserService._internal();

  final Map<String, User> _users = {};
  User? _currentUser;

  User? get currentUser => _currentUser;

  Result register(
    String name,
    String email,
    String password,
    Instrument instrument,
  ) {
    if (_users.containsKey(email)) {
      return Result(success: false, error: 'Email já cadastrado');
    }

    final user = User(name: name, email: email, instrument: instrument);
    _users[email] = user;
    _currentUser = user;
    return const Result(success: true);
  }

  Result login(String email, String password) {
    if (!_users.containsKey(email)) {
      return Result(success: false, error: 'Email não encontrado');
    }

    _currentUser = _users[email];
    return const Result(success: true);
  }

  void logout() {
    _currentUser = null;
  }

  void clear() {
    _users.clear();
    _currentUser = null;
  }
}
