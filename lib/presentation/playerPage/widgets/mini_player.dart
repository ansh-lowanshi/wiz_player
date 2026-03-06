import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiz_player/common/appnavigation/app_navigation.dart';
import 'package:wiz_player/core/config/theme/app_colors.dart';
import 'package:wiz_player/core/utils/text_utils.dart';
import 'package:wiz_player/presentation/playerPage/bloc/player_bloc.dart';
import 'package:wiz_player/presentation/playerPage/bloc/player_event.dart';
import 'package:wiz_player/presentation/playerPage/bloc/player_state.dart';
import 'package:wiz_player/presentation/playerPage/pages/player_page.dart';
import 'dart:ui';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, state) {
        final song = state.song;

        if (song == null) {
          return const SizedBox();
        }

        return Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: () {
              AppNavigation.push(context, PlayerPage(songId: song.id));
            },
            onHorizontalDragEnd: (deails) {
              final velocity = deails.primaryVelocity ?? 0;
              if (velocity < 0) {
                context.read<PlayerBloc>().add(PlayNext());
              } else if (velocity > 0) {
                context.read<PlayerBloc>().add(PlayPrevious());
              }
            },

            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: SizedBox(
                height: 75,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(song.imageUrl, fit: BoxFit.cover),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black.withOpacity(0.2)
                            : Colors.white.withOpacity(0.2),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  song.imageUrl,
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      TextUtils.cleanString(song.name),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      TextUtils.cleanString(song.artistName),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              IconButton(
                                iconSize: 32,
                                onPressed: () {
                                  context.read<PlayerBloc>().add(PlayPause());
                                },
                                icon: Icon(
                                  state.isPlaying
                                      ? Icons.pause_circle_filled
                                      : Icons.play_circle_fill,
                                  color: Colors.white,
                                ),
                              ),
                              // IconButton(
                              //   iconSize: 30,
                              //   onPressed: () {
                              //     context.read<PlayerBloc>().add(PlayNext());
                              //   },
                              //   icon: Icon(Icons.skip_next),
                              // ),
                            ],
                          ),

                          const SizedBox(height: 5),
                          Container(
                            height: 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                colors: [AppColors.primary, AppColors.cream],
                              ),
                            ),
                            width: state.duration.inMilliseconds == 0
                                ? 0
                                : MediaQuery.of(context).size.width *
                                      (state.position.inMilliseconds /
                                          state.duration.inMilliseconds),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
