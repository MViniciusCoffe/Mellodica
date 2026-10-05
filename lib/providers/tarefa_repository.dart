import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/tarefa.dart';

class TarefaRepository {
  final FirebaseFirestore _firestore;

  TarefaRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('tarefas');

  Future<String> create(Tarefa tarefa) async {
    final document = _collection.doc();
    await document.set(tarefa.toFirestore());
    return document.id;
  }

  Future<Tarefa?> getById({
    required String tarefaId,
    required String usuarioId,
  }) async {
    final snapshot = await _collection.doc(tarefaId).get();

    if (!snapshot.exists) {
      return null;
    }

    final tarefa = Tarefa.fromFirestore(snapshot);
    return tarefa.usuarioId == usuarioId ? tarefa : null;
  }

  Stream<List<Tarefa>> watchByUser(String usuarioId) {
    return _collection
        .where('usuarioId', isEqualTo: usuarioId)
        .orderBy('dataCriacao', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map(Tarefa.fromFirestore).toList(growable: false),
        );
  }

  Future<void> update(Tarefa tarefa) {
    return _collection.doc(tarefa.id).update(tarefa.toFirestore());
  }

  Future<void> delete(String tarefaId) {
    return _collection.doc(tarefaId).delete();
  }
}
