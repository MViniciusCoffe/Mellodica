import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/tarefa.dart';
import 'auth_provider.dart';
import 'tarefa_repository.dart';

final tarefaRepositoryProvider = Provider<TarefaRepository>((ref) {
  return TarefaRepository();
});

final tarefasProvider = StreamProvider<List<Tarefa>>((ref) {
  final user = ref.watch(authStateProvider).value;

  if (user == null) {
    return const Stream<List<Tarefa>>.empty();
  }

  return ref.watch(tarefaRepositoryProvider).watchByUser(user.uid);
});
