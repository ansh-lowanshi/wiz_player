import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wiz_player/core/config/theme/app_colors.dart';
import 'package:wiz_player/presentation/playerPage/bloc/player_bloc.dart';
import 'package:wiz_player/presentation/playerPage/bloc/player_event.dart';
import 'package:wiz_player/presentation/playerPage/bloc/player_state.dart';

class PlayerPage extends StatefulWidget {
  final String songId;

  const PlayerPage({super.key, required this.songId});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PlayerBloc(context.read())..add(LoadSong(widget.songId)),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<PlayerBloc, PlayerState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: AppColors.primary,
                  size: 50,
                ),
              );
            }

            if (state.error != null) {
              return Center(child: Text(state.error!));
            }

            final song = state.song;

            if (song == null) {
              return const Center(child: Text("No Song Found"));
            }

            return Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: Image.network(song.imageUrl, height: 350),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    song.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10),
                  Text(
                    song.artistName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 40),

                  LinearProgressIndicator(
                    value: 0.5,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                  ),
                  BlocBuilder<PlayerBloc, PlayerState>(
                    builder: (context, state) {
                      return IconButton(
                        iconSize: 64,
                        onPressed: () {
                          context.read<PlayerBloc>().add(PlayPause());
                        },
                        icon: Icon(
                          state.isPlaying
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_fill,
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
