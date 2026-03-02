import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wiz_player/common/appnavigation/app_navigation.dart';
import 'package:wiz_player/core/config/theme/app_colors.dart';
import 'package:wiz_player/core/config/theme/bloc/theme_bloc.dart';
import 'package:wiz_player/core/config/theme/bloc/theme_event.dart';
import 'package:wiz_player/presentation/playerPage/pages/player_page.dart';
import 'package:wiz_player/presentation/search/bloc/search_bloc.dart';
import 'package:wiz_player/presentation/search/bloc/search_evet.dart';
import 'package:wiz_player/presentation/search/bloc/search_state.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _controller = TextEditingController();
  String selected = 'All';

  final filters = ['All', 'Songs', 'Artists', 'Albums'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.music_note_outlined, color: AppColors.primary),
            SizedBox(width: 10),
            Text('WizPlayer'),
          ],
        ),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  context.read<ThemeBloc>().add(ToggleTheme());
                },
                icon: Icon(Icons.brightness_6),
              ),
            ],
          ),
        ],
        toolbarHeight: 65,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                autofocus: true,
                controller: _controller,
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  context.read<SearchBloc>().add(
                    SearchRequest(value, selected),
                  );
                },
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  hintText: 'Search for Songs, Artists...',
                  prefixIcon: IconButton(
                    onPressed: () {
                      context.read<SearchBloc>().add(
                        SearchRequest(_controller.text.trim(), selected),
                      );
                    },
                    icon: Icon(Icons.search),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _controller.clear();
                      });
                      context.read<SearchBloc>().add(ClearSearch());
                    },
                    icon: Icon(Icons.clear),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).brightness == Brightness.light
                      ? AppColors.grey
                      : AppColors.darkgrey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 8,
                children: filters.map((filter) {
                  return ChoiceChip(
                    label: Text(filter),
                    selected: selected == filter,
                    onSelected: (_) {
                      setState(() {
                        selected = filter;
                      });
                      if (_controller.text.trim().isNotEmpty) {
                        context.read<SearchBloc>().add(
                          SearchRequest(_controller.text.trim(), selected),
                        );
                      }
                    },
                    selectedColor: AppColors.primary.withOpacity(0.15),
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.light
                        ? AppColors.lightBackground
                        : AppColors.darkBackground,
                  );
                }).toList(),
              ),
              Expanded(
                child: BlocBuilder<SearchBloc, SearchState>(
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
                      return Center(
                        child: Text(
                          state.error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    if (selected == "All") {
                      if (state.globalSearch == null) {
                        return const Center(child: Text("Search for music 🎵"));
                      }
                    } else {
                      if (state.songs.isEmpty &&
                          state.albums.isEmpty &&
                          state.artists.isEmpty) {
                        return const Center(child: Text("Search for music 🎵"));
                      }
                    }

                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (selected == "All" &&
                              state.globalSearch != null) ...[
                            if (state.globalSearch!.songs.isNotEmpty) ...[
                              const SectionTitle(title: "Songs"),
                              ...state.globalSearch!.songs.map(
                                (song) => ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      song.imageUrl,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(
                                    song.title,
                                    maxLines: 1,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  subtitle: Text(
                                    song.artistName,
                                    maxLines: 1,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],

                            if (state.globalSearch!.artists.isNotEmpty) ...[
                              const SectionTitle(title: "Artists"),
                              ...state.globalSearch!.artists.map(
                                (artist) => ListTile(
                                  leading: buildSafeArtistImage(
                                    artist.imageUrl,
                                  ),
                                  title: Text(
                                    artist.title,
                                    maxLines: 1,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  // subtitle: Text("ID: ${artist.id}"),
                                ),
                              ),
                            ],

                            if (state.globalSearch!.albums.isNotEmpty) ...[
                              const SectionTitle(title: "Albums"),
                              ...state.globalSearch!.albums.map(
                                (album) => ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      album.imageUrl,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(
                                    album.title,
                                    maxLines: 1,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  // subtitle: Text("ID: ${album.id}"),
                                  subtitle: Text(
                                    album.artistName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ],

                          if (selected == "Songs" &&
                              state.songs.isNotEmpty) ...[
                            SizedBox(height: 10),
                            // const SectionTitle(title: "Songs"),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.songs.length,
                              itemBuilder: (context, index) {
                                final song = state.songs[index];

                                return ListTile(
                                  onTap: () {
                                    AppNavigation.push(
                                      context,
                                      PlayerPage(songId: song.id),
                                    );
                                  },
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      song.imageUrl,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(
                                    song.name,
                                    maxLines: 1,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  subtitle: Text(
                                    song.artistName,
                                    maxLines: 1,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                          ],

                          if (selected == "Albums" &&
                              state.albums.isNotEmpty) ...[
                            // const SectionTitle(title: "Albums"),
                            SizedBox(height: 10),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.albums.length,
                              itemBuilder: (context, index) {
                                final album = state.albums[index];

                                return ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      album.imageUrl,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(
                                    album.name,
                                    maxLines: 1,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  subtitle: Text(
                                    album.artistName,
                                    maxLines: 1,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                          ],

                          if (selected == "Artists" &&
                              state.artists.isNotEmpty) ...[
                            // const SectionTitle(title: "Artists"),
                            SizedBox(height: 10),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.artists.length,
                              itemBuilder: (context, index) {
                                final artist = state.artists[index];

                                return ListTile(
                                  leading: buildSafeArtistImage(
                                    artist.imageUrl,
                                  ),
                                  title: Text(
                                    artist.name,
                                    maxLines: 1,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}

Widget buildSafeArtistImage(String url) {
  // Detect blocked placeholder images
  if (url.contains('artist-default') || url.contains('jiosaavn.com/_i')) {
    return const CircleAvatar(child: Icon(Icons.person));
  }

  return CircleAvatar(
    backgroundColor: Colors.grey.shade200,
    child: ClipOval(
      child: Image.network(
        url,
        fit: BoxFit.cover,
        width: 50,
        height: 50,
        errorBuilder: (_, __, ___) {
          return const Icon(Icons.person);
        },
      ),
    ),
  );
}
