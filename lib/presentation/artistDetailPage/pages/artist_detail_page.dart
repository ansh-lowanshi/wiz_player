import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wiz_player/common/appnavigation/app_navigation.dart';
import 'package:wiz_player/core/config/theme/app_colors.dart';
import 'package:wiz_player/core/utils/text_utils.dart';
import 'package:wiz_player/domain/repo/album_repo.dart';
import 'package:wiz_player/presentation/albumDetailPage/bloc/album_detail_bloc.dart';
import 'package:wiz_player/presentation/albumDetailPage/pages/album_page.dart';
import 'package:wiz_player/presentation/playerPage/bloc/player_bloc.dart';
import 'package:wiz_player/presentation/playerPage/bloc/player_event.dart';
import 'package:wiz_player/presentation/playerPage/pages/player_page.dart';
import 'package:wiz_player/presentation/playerPage/widgets/mini_player.dart';
import '../bloc/artist_detail_bloc.dart';
import '../bloc/artist_detail_event.dart';
import '../bloc/artist_detail_state.dart';

class ArtistDetailPage extends StatefulWidget {
  final String artistId;

  const ArtistDetailPage({super.key, required this.artistId});

  @override
  State<ArtistDetailPage> createState() => _ArtistDetailPageState();
}

class _ArtistDetailPageState extends State<ArtistDetailPage> {
  int _songPageIndex = 0;
  @override
  void initState() {
    super.initState();
    context.read<ArtistDetailBloc>().add(LoadArtistDetail(widget.artistId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<ArtistDetailBloc, ArtistDetailState>(
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

              final artist = state.artistData;

              if (artist == null) {
                return const Center(child: Text("Artist not found"));
              }

              return Stack(
                children: [
                  Image.network(
                    artist.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),

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
                        child: Padding(
                          padding: const EdgeInsets.only(top: 80, bottom: 20),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 120,
                                backgroundImage: NetworkImage(artist.imageUrl),
                              ),

                              const SizedBox(height: 20),

                              Text(
                                TextUtils.cleanString(artist.name),
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Top Songs",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10),

                              SizedBox(
                                height: 200,
                                child: PageView.builder(
                                  itemCount: (artist.songs.length / 3).ceil(),
                                  controller: PageController(
                                    viewportFraction: 1,
                                  ),
                                  onPageChanged: (index) {
                                    setState(() {
                                      _songPageIndex = index;
                                    });
                                  },
                                  itemBuilder: (context, pageIndex) {
                                    int start = pageIndex * 3;
                                    int end = start + 3;

                                    final pageSongs = artist.songs.sublist(
                                      start,
                                      end > artist.songs.length
                                          ? artist.songs.length
                                          : end,
                                    );

                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: pageSongs.map((song) {
                                        return GestureDetector(
                                          onTap: () {
                                            context.read<PlayerBloc>().add(
                                              LoadSong(song.id),
                                            );

                                            // AppNavigation.push(
                                            //   context,
                                            //   PlayerPage(songId: song.id),
                                            // );
                                          },
                                          child: Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Image.network(
                                                  song.imageUrl,
                                                  width: 55,
                                                  height: 55,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),

                                              const SizedBox(width: 10),

                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      TextUtils.cleanString(
                                                        song.name,
                                                      ),
                                                      style: TextStyle(
                                                        fontSize: 19,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      TextUtils.cleanString(
                                                        song.label,
                                                      ),
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                (artist.songs.length / 3).ceil(),
                                (index) => AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  height: 6,
                                  width: _songPageIndex == index ? 18 : 6,
                                  decoration: BoxDecoration(
                                    color: _songPageIndex == index
                                        ? AppColors.primary
                                        : Theme.of(context).brightness ==
                                              Brightness.dark
                                        ? Colors.white.withOpacity(0.2)
                                        : Colors.black.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Top Albums",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10),

                              SizedBox(
                                height: 200,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: artist.albums.length,
                                  itemBuilder: (context, index) {
                                    final album = artist.albums[index];

                                    return GestureDetector(
                                      onTap: () {
                                        AppNavigation.push(
                                          context,
                                          BlocProvider(
                                            create: (context) =>
                                                AlbumDetailBloc(
                                                  context
                                                      .read<AlbumRepository>(),
                                                ),
                                            child: AlbumDetailPage(
                                              albumId: album.id,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 150,
                                        margin: const EdgeInsets.only(
                                          right: 15,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            /// ALBUM IMAGE
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.network(
                                                album.imageUrl,
                                                height: 150,
                                                width: 150,
                                                fit: BoxFit.cover,
                                              ),
                                            ),

                                            const SizedBox(height: 8),

                                            Text(
                                              TextUtils.cleanString(album.name),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SliverToBoxAdapter(child: SizedBox(height: 120)),
                    ],
                  ),
                ],
              );
            },
          ),

          /// MINI PLAYER
          const Align(alignment: Alignment.bottomCenter, child: MiniPlayer()),

          /// BACK BUTTON
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
