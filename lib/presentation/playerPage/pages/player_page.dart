import 'dart:ui';
import 'package:flutter/cupertino.dart';
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
    return Scaffold(
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

          return Stack(
            fit: StackFit.loose,
            children: [
              Image.network(song.imageUrl, fit: BoxFit.cover),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: Container(color: Colors.black.withOpacity(0.4)),
              ),

              Positioned(
                top: 10,
                left: 10,
                child: SafeArea(
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.white,
                      size: 28,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              SafeArea(
                child: Container(
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
                          // color: AppColors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 10),
                      Text(
                        song.artistName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        // style: TextStyle(color: AppColors.white),
                      ),
                      const SizedBox(height: 20),

                      Slider(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        thumbColor: AppColors.cream,
                        min: 0,
                        max: state.duration.inSeconds.toDouble(),
                        value: state.position.inSeconds
                            .clamp(0, state.duration.inSeconds)
                            .toDouble(),
                        activeColor: AppColors.primary,
                        inactiveColor: Colors.grey[300],
                        onChanged: (value) {
                          context.read<PlayerBloc>().seek(
                            Duration(seconds: value.toInt()),
                          );
                        },
                      ),
                      SizedBox(height: 2),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Text(
                              _formatDuration(state.position),
                              // style: TextStyle(color: AppColors.white),
                            ),
                            Text(
                              '-${_formatDuration(state.duration - state.position)}',
                              // style: TextStyle(color: AppColors.white),
                            ),
                          ],
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
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

String _formatDuration(Duration duration) {
  final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

  return '$minutes:$seconds';
}
