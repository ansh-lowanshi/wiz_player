import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:wiz_player/data/repo/song_repo_impl.dart';
import 'package:wiz_player/data/sources/song_remote_source.dart';
import 'package:wiz_player/domain/entities/song_entity.dart';


class SongDebugPage extends StatefulWidget {
  const SongDebugPage({super.key});

  @override
  State<SongDebugPage> createState() => _SongDebugPageState();
}

class _SongDebugPageState extends State<SongDebugPage> {
  final TextEditingController _controller = TextEditingController();

  final SongRepositoryImpl _repository =
      SongRepositoryImpl(SongRemoteSource());

  late final AudioPlayer _player;

  bool _loading = false;
  String? _error;
  List<SongEntity> _songs = [];

  String? _currentlyPlayingId;

  @override
  void initState() {
    super.initState();
    _initAudio();
  }

  Future<void> _initAudio() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
    _player = AudioPlayer();
  }

  @override
  void dispose() {
    _player.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _searchSongs() async {
    final query = _controller.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _loading = true;
      _error = null;
      _songs.clear();
    });

    try {
      final result = await _repository.searchSongs(
        query,
        limit: 40,
      );

      setState(() {
        _songs = result;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _togglePlay(SongEntity song) async {
    try {
      if (_currentlyPlayingId == song.id && _player.playing) {
        await _player.pause();
        setState(() {
          _currentlyPlayingId = null;
        });
        return;
      }

      await _player.setUrl(song.audioUrl);
      await _player.play();

      setState(() {
        _currentlyPlayingId = song.id;
      });
    } catch (e) {
      debugPrint('Audio error: $e');
    }
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '$minutes:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Song Debug Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            /// 🔍 Search Bar
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Search song...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _loading ? null : _searchSongs,
                  child: const Text('Search'),
                ),
              ],
            ),

            const SizedBox(height: 12),

            if (_loading)
              const Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(),
              ),

            if (_error != null)
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  _error!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),

            /// 🎵 Song List
            Expanded(
              child: ListView.separated(
                itemCount: _songs.length,
                separatorBuilder: (_, __) =>
                    const Divider(height: 1),
                itemBuilder: (context, index) {
                  final song = _songs[index];
                  final isPlaying =
                      _currentlyPlayingId == song.id &&
                          _player.playing;

                  return ListTile(
                    leading: song.imageUrl.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.network(
                              song.imageUrl,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(Icons.music_note),

                    title: Text(
                      song.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    subtitle: Text(
                      '${song.artistName} • ${_formatDuration(song.duration)}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    trailing: IconButton(
                      icon: Icon(
                        isPlaying
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_fill,
                        size: 32,
                      ),
                      onPressed: () => _togglePlay(song),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}