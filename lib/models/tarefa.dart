import 'package:cloud_firestore/cloud_firestore.dart';

class Tarefa {
  final String id;
  final String usuarioId;
  final String titulo;
  final String descricao;
  final bool concluida;
  final DateTime dataCriacao;
  final DateTime? dataConclusao;

  const Tarefa({
    required this.id,
    required this.usuarioId,
    required this.titulo,
    required this.descricao,
    required this.concluida,
    required this.dataCriacao,
    this.dataConclusao,
  });

  factory Tarefa.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();

    if (data == null) {
      throw StateError('Documento de tarefa sem dados: ${snapshot.id}');
    }

    final dataCriacao = data['dataCriacao'];
    if (dataCriacao is! Timestamp) {
      throw StateError('Campo dataCriacao inválido na tarefa: ${snapshot.id}');
    }

    final dataConclusao = data['dataConclusao'];

    return Tarefa(
      id: snapshot.id,
      usuarioId: _requiredString(data, 'usuarioId', snapshot.id),
      titulo: _requiredString(data, 'titulo', snapshot.id),
      descricao: data['descricao'] as String? ?? '',
      concluida: data['concluida'] as bool? ?? false,
      dataCriacao: dataCriacao.toDate(),
      dataConclusao: dataConclusao is Timestamp ? dataConclusao.toDate() : null,
    );
  }

  Map<String, Object?> toFirestore() {
    return {
      'usuarioId': usuarioId,
      'titulo': titulo,
      'descricao': descricao,
      'concluida': concluida,
      'dataCriacao': Timestamp.fromDate(dataCriacao),
      'dataConclusao': dataConclusao == null
          ? null
          : Timestamp.fromDate(dataConclusao!),
    };
  }

  Tarefa copyWith({String? titulo, String? descricao}) {
    return Tarefa(
      id: id,
      usuarioId: usuarioId,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      concluida: concluida,
      dataCriacao: dataCriacao,
      dataConclusao: dataConclusao,
    );
  }

  Tarefa concluir(DateTime quando) {
    return Tarefa(
      id: id,
      usuarioId: usuarioId,
      titulo: titulo,
      descricao: descricao,
      concluida: true,
      dataCriacao: dataCriacao,
      dataConclusao: quando,
    );
  }

  Tarefa reabrir() {
    return Tarefa(
      id: id,
      usuarioId: usuarioId,
      titulo: titulo,
      descricao: descricao,
      concluida: false,
      dataCriacao: dataCriacao,
      dataConclusao: null,
    );
  }

  static String _requiredString(
    Map<String, dynamic> data,
    String field,
    String documentId,
  ) {
    final value = data[field];
    if (value is! String || value.trim().isEmpty) {
      throw StateError('Campo $field inválido na tarefa: $documentId');
    }
    return value;
  }
}
