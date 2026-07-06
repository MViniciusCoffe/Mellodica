import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/song.dart';

class MusicService {
  Future<List<Song>> search(String query, {int index = 0, int limit = 20}) async {
    final uri = Uri.https('api.deezer.com', '/search', {
      'q': query,
      'index': index.toString(),
      'limit': limit.toString(),
    });
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Erro na API: ${response.statusCode}');
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;

    if (body.containsKey('error')) {
      throw Exception('Erro na Deezer: ${body['error']['message']}');
    }

    final data = body['data'] as List<dynamic>?;

    if (data == null) return [];

    return data.map((json) => Song.fromJson(json as Map<String, dynamic>)).toList();
  }
}
