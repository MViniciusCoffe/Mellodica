import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mellodica/models/tarefa.dart';

void main() {
  group('Tarefa', () {
    Tarefa build({
      bool concluida = false,
      DateTime? dataConclusao,
    }) {
      return Tarefa(
        id: 'tarefa-1',
        usuarioId: 'user-1',
        titulo: 'Estudar Firestore',
        descricao: 'Revisar streams e Security Rules',
        concluida: concluida,
        dataCriacao: DateTime.utc(2026, 10, 4, 12),
        dataConclusao: dataConclusao,
      );
    }

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

    test('concluir marks the task as done and records the date', () {
      final quando = DateTime.utc(2026, 10, 4, 15);
      final tarefa = build().concluir(quando);

      expect(tarefa.concluida, isTrue);
      expect(tarefa.dataConclusao, quando);
    });

    test('reabrir clears the completion date', () {
      final quando = DateTime.utc(2026, 10, 4, 15);
      final tarefa = build(concluida: true, dataConclusao: quando);

      final reaberta = tarefa.reabrir();

      expect(reaberta.concluida, isFalse);
      expect(reaberta.dataConclusao, isNull);
    });

    test('reabrir keeps title and creation date untouched', () {
      final quando = DateTime.utc(2026, 10, 4, 15);
      final tarefa = build(concluida: true, dataConclusao: quando);

      final reaberta = tarefa.reabrir();

      expect(reaberta.id, 'tarefa-1');
      expect(reaberta.usuarioId, 'user-1');
      expect(reaberta.titulo, 'Estudar Firestore');
      expect(
        reaberta.dataCriacao.millisecondsSinceEpoch,
        DateTime.utc(2026, 10, 4, 12).millisecondsSinceEpoch,
      );
    });
  });
}