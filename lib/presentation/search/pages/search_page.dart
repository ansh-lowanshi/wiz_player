import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiz_player/core/config/theme/app_colors.dart';
import 'package:wiz_player/core/config/theme/bloc/theme_bloc.dart';
import 'package:wiz_player/core/config/theme/bloc/theme_event.dart';
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
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _controller.clear();
                      });
                    },
                    icon: Icon(Icons.clear),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).brightness == Brightness.light
                      ? AppColors.grey
                      : AppColors.darkgrey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    // borderSide: BorderSide.none
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
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.error != null) {
                      return Center(
                        child: Text(
                          state.error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    if (state.songs.isEmpty &&
                        state.albums.isEmpty &&
                        state.artists.isEmpty) {
                      return const Center(child: Text("Search for music 🎵"));
                    }

                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// SONGS SECTION
                          if (selected == "Songs" || selected == "All")
                            if (state.songs.isNotEmpty) ...[
                              const SectionTitle(title: "Songs"),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.songs.length,
                                itemBuilder: (context, index) {
                                  final song = state.songs[index];

                                  return ListTile(
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        song.imageUrl,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    title: Text(song.name),
                                    subtitle: Text(song.artistName),
                                    onTap: () {
                                      // TODO: Navigate to player
                                    },
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                            ],

                          /// ALBUMS SECTION
                          if (selected == "Albums" || selected == "All")
                            if (state.albums.isNotEmpty) ...[
                              const SectionTitle(title: "Albums"),
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
                                    title: Text(album.name),
                                    subtitle: Text(album.artistName),
                                    onTap: () {
                                      // TODO: Navigate to album details
                                    },
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                            ],

                          /// ARTISTS SECTION
                          if (selected == "Artists" || selected == "All")
                            if (state.artists.isNotEmpty) ...[
                              const SectionTitle(title: "Artists"),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.artists.length,
                                itemBuilder: (context, index) {
                                  final artist = state.artists[index];

                                  return ListTile(
                                    leading: CircleAvatar(
                                      // child: safeNetworkImage(artist.imageUrl),
                                      radius: 25,
                                    ),
                                    title: Text(artist.name),
                                    onTap: () {
                                      // TODO: Navigate to artist details
                                    },
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

Widget safeNetworkImage(String url, {double size = 50}) {
  if (url.isEmpty || url.contains('artist-default')) {
    return const Icon(Icons.person);
  }

  return Image.network(
    url,
    width: size,
    height: size,
    fit: BoxFit.cover,
    errorBuilder: (_, __, ___) {
      return const Icon(Icons.person);
    },
  );
}
