import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mellodica/models/tarefa.dart';

void main() {
  group('Tarefa', () {
    test('serializes its fields to Firestore data', () {
      final createdAt = DateTime.utc(2026, 10, 4, 12);
      final completedAt = DateTime.utc(2026, 10, 4, 13);
      final tarefa = Tarefa(
        id: 'tarefa-1',
        usuarioId: 'user-1',
        titulo: 'Estudar Firestore',
        descricao: 'Revisar streams e Security Rules',
        concluida: true,
        dataCriacao: createdAt,
        dataConclusao: completedAt,
      );

      final data = tarefa.toFirestore();

      expect(data['usuarioId'], 'user-1');
      expect(data['titulo'], 'Estudar Firestore');
      expect(data['descricao'], 'Revisar streams e Security Rules');
      expect(data['concluida'], isTrue);
      expect(
        (data['dataCriacao'] as Timestamp).toDate().millisecondsSinceEpoch,
        createdAt.millisecondsSinceEpoch,
      );
      expect(
        (data['dataConclusao'] as Timestamp).toDate().millisecondsSinceEpoch,
        completedAt.millisecondsSinceEpoch,
      );
    });
  });
}
