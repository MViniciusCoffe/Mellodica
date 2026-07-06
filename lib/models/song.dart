class Song {
  final String title;
  final String artist;
  final String coverUrl;
  final String previewUrl;
  final List<String> suggestedInstruments;

  const Song({
    required this.title,
    required this.artist,
    required this.coverUrl,
    required this.previewUrl,
    required this.suggestedInstruments,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    final genreId = json['genre_id'] ?? 0;
    final instruments = _instrumentsForGenre(genreId);
    final artistData = json['artist'] as Map<String, dynamic>?;
    final albumData = json['album'] as Map<String, dynamic>?;

    return Song(
      title: json['title'] ?? 'Sem título',
      artist: artistData?['name'] ?? 'Desconhecido',
      coverUrl: albumData?['cover_medium'] ?? '',
      previewUrl: json['preview'] ?? '',
      suggestedInstruments: instruments,
    );
  }

  static List<String> _instrumentsForGenre(int genreId) {
    switch (genreId) {
      case 1: // Rock
      case 3: // Metal
      case 4: // Hard Rock
      case 15: // Metal
        return ['Guitarra', 'Bateria', 'Baixo'];
      case 2: // Pop
      case 8: // Folk
      case 12: // French Pop
        return ['Violão', 'Teclado', 'Vocal'];
      case 5: // Jazz
      case 6: // Blues
        return ['Violão', 'Saxofone', 'Bateria'];
      case 7: // Country
        return ['Violão', 'Gaita', 'Banjo'];
      case 9: // Soul
      case 10: // Funk
      case 11: // Hip-Hop
      case 16: // R&B
        return ['Teclado', 'Bateria', 'Baixo'];
      case 13: // Classical
        return ['Piano', 'Violino', 'Violoncelo'];
      case 14: // Reggae
        return ['Violão', 'Bateria', 'Baixo'];
      default:
        return ['Violão', 'Teclado', 'Bateria'];
    }
  }
}