import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiz_player/common/appnavigation/app_navigation.dart';
import 'package:wiz_player/core/config/theme/app_colors.dart';
import 'package:wiz_player/core/config/theme/bloc/theme_bloc.dart';
import 'package:wiz_player/core/config/theme/bloc/theme_event.dart';

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
                  
                },
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  hintText: 'Search songs, artists...',
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
            ],
          ),
        ),
      ),
    );
  }
}
