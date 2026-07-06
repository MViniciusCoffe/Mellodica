import 'package:flutter/material.dart';
import '../services/music_service.dart';
import '../models/song.dart';

class MusicView extends StatefulWidget {
  const MusicView({super.key});

  @override
  State<MusicView> createState() => _MusicViewState();
}

class _MusicViewState extends State<MusicView> {
  final _searchController = TextEditingController();
  final _service = MusicService();
  final _songs = <Song>[];
  bool _isLoading = false;
  bool _hasMore = true;
  int _currentIndex = 0;
  String _lastQuery = '';

  @override
  void initState() {
    super.initState();
    _loadSongs('top');
  }

  Future<void> _loadSongs(String query, {bool loadMore = false}) async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    if (!loadMore) {
      _currentIndex = 0;
      _hasMore = true;
    }

    try {
      final songs = await _service.search(query, index: _currentIndex);
      setState(() {
        if (loadMore) {
          _songs.addAll(songs);
        } else {
          _songs
            ..clear()
            ..addAll(songs);
        }
        _currentIndex += songs.length;
        _hasMore = songs.length >= 20;
        _lastQuery = query;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar: $e')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _onSearch(String query) {
    _loadSongs(query);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Músicas'),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Pesquisar músicas...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: _onSearch,
            ),
          ),
          Expanded(
            child: _songs.isEmpty && _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _songs.isEmpty
                    ? const Center(child: Text('Nenhuma música encontrada'))
                    : NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          if (notification is ScrollEndNotification &&
                              _hasMore &&
                              !_isLoading) {
                            _loadSongs(_lastQuery, loadMore: true);
                          }
                          return false;
                        },
                        child: ListView.builder(
                          itemCount: _songs.length + (_hasMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == _songs.length) {
                              return const Padding(
                                padding: EdgeInsets.all(16),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            final song = _songs[index];
                            return ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  song.coverUrl,
                                  width: 56,
                                  height: 56,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(song.title),
                              subtitle: Text(
                                '${song.artist} • ${song.suggestedInstruments.join(', ')}',
                              ),
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
