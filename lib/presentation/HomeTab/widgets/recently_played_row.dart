import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wiz_player/common/appnavigation/app_navigation.dart';
import 'package:wiz_player/core/config/theme/app_colors.dart';
import 'package:wiz_player/core/services/recently_played_service.dart';
import 'package:wiz_player/domain/repo/song_repo.dart';
import 'package:wiz_player/presentation/playerPage/bloc/player_bloc.dart';
import 'package:wiz_player/presentation/playerPage/bloc/player_event.dart';
import 'package:wiz_player/presentation/playerPage/pages/player_page.dart';

class RecentlyPlayedRow extends StatefulWidget {
  const RecentlyPlayedRow({super.key});

  @override
  State<RecentlyPlayedRow> createState() => _RecentlyPlayedRowState();
}

class _RecentlyPlayedRowState extends State<RecentlyPlayedRow> {
  final RecentlyPlayedService _recentService = RecentlyPlayedService();

  List songs = [];
  bool loading = true;

  @override
  void didUpdateWidget(covariant RecentlyPlayedRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    _loadSongs();
  }

  @override
  void initState() {
    super.initState();
    _loadSongs();
  }

  Future<void> _loadSongs() async {
    final ids = _recentService.getSongs();
    final repo = context.read<SongRepository>();

    if (ids.isEmpty) {
      setState(() {
        loading = false;
      });
      return;
    }

    for (final id in ids) {
      final song = await repo.serchSongById(id);
      setState(() {
        songs.add(song);
        loading = false;
      });
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return SizedBox(
        height: 160,
        child: Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
            color: AppColors.primary,
            size: 50,
          ),
        ),
      );
    }

    if (songs.isEmpty) {
      return const SizedBox();
    }

    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: (songs.length / 3).ceil(),
        itemBuilder: (context, index) {
          final song = songs[index];

          return GestureDetector(
            onTap: () {
              context.read<PlayerBloc>().add(LoadSong(song.id));

              AppNavigation.push(context, PlayerPage(songId: song.id));
            },

            child: Container(
              width: 130,
              margin: const EdgeInsets.only(right: 12),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      song.imageUrl,
                      width: 130,
                      height: 110,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    song.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  Text(
                    song.artistName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
