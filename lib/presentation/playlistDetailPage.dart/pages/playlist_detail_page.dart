import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wiz_player/core/config/theme/app_colors.dart';
import 'package:wiz_player/core/utils/text_utils.dart';
import 'package:wiz_player/presentation/playerPage/bloc/player_bloc.dart';
import 'package:wiz_player/presentation/playerPage/bloc/player_event.dart';
import 'package:wiz_player/presentation/playerPage/widgets/mini_player.dart';
import 'package:wiz_player/presentation/playlistDetailPage.dart/bloc/playlist_detail_bloc.dart';
import 'package:wiz_player/presentation/playlistDetailPage.dart/bloc/playlist_detail_event.dart';
import 'package:wiz_player/presentation/playlistDetailPage.dart/bloc/playlist_detail_state.dart';

class PlaylistDetailPage extends StatefulWidget {
  final String playlistId;
  final String limit;

  const PlaylistDetailPage({
    super.key,
    required this.playlistId,
    required this.limit,
  });

  @override
  State<PlaylistDetailPage> createState() => _PlaylistDetailPageState();
}

class _PlaylistDetailPageState extends State<PlaylistDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<PlaylistDetailBloc>().add(
      LoadPlaylistDetails(widget.playlistId, widget.limit),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<PlaylistDetailBloc, PlaylistDetailState>(
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

              final playlist = state.playlist;

              if (playlist == null) {
                return const Center(child: Text("Playlist not found"));
              }

              return Stack(
                fit: StackFit.loose,
                children: [
                  Image.network(playlist.imageUrl, fit: BoxFit.cover),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                    child: Container(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black.withOpacity(0.5)
                          : Colors.white.withOpacity(0.5),
                    ),
                  ),

                  CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(top: 80, bottom: 20),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.network(
                                  playlist.imageUrl,
                                  height: 250,
                                ),
                              ),

                              const SizedBox(height: 20),

                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.only(left: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      TextUtils.cleanString(playlist.name),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        // color: Colors.white,
                                      ),
                                    ),

                                    const SizedBox(height: 5),

                                    Text(
                                      TextUtils.cleanString(
                                        playlist.artistName,
                                      ),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        // color: Colors.white70,
                                      ),
                                    ),

                                    Text(
                                      "${playlist.songs.length} Songs",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        // color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final song = playlist.songs[index];

                          return ListTile(
                            leading: Text(
                              (index + 1).toString(),
                              style: const TextStyle(fontSize: 15),
                            ),

                            title: Text(
                              TextUtils.cleanString(song.name),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              // style: const TextStyle(color: Colors.white),
                            ),

                            subtitle: Text(
                              TextUtils.cleanString(song.artistName),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              // style: const TextStyle(color: Colors.white70),
                            ),

                            onTap: () {
                              context.read<PlayerBloc>().add(LoadSong(song.id));

                              // AppNavigation.push(context,PlayerPage(songId: song.id),);
                            },
                          );
                        }, childCount: playlist.songs.length),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 75)),
                    ],
                  ),
                ],
              );
            },
          ),
          Align(alignment: AlignmentGeometry.bottomCenter, child: MiniPlayer()),
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
        ],
      ),
    );
  }
}
