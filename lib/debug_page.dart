import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchAllDebugPage extends StatefulWidget {
  const SearchAllDebugPage({super.key});

  @override
  State<SearchAllDebugPage> createState() => _SearchAllDebugPageState();
}

class _SearchAllDebugPageState extends State<SearchAllDebugPage> {
  final TextEditingController _controller = TextEditingController();

  bool isLoading = false;
  String? error;

  List songs = [];
  List albums = [];
  List artists = [];

  Future<void> searchAll(String query) async {
    setState(() {
      isLoading = true;
      error = null;
      songs = [];
      albums = [];
      artists = [];
    });

    try {
      final uri = Uri.parse(
        'https://saavn.sumit.co/api/search?query=$query',
      );

      final response = await http.get(uri);

      if (response.statusCode != 200) {
        throw Exception("Failed to fetch search results");
      }

      final decoded = jsonDecode(response.body);

      print("FULL RESPONSE:");
      print(decoded);

      final data = decoded['data'];

      songs = data?['songs']?['results'] ?? [];
      albums = data?['albums']?['results'] ?? [];
      artists = data?['artists']?['results'] ?? [];

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  Widget buildSection(String title, List items) {
    if (items.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...items.map((item) {
          final name = item['name']?.toString() ?? 'Unknown';
          final id = item['id']?.toString() ?? '';

          return ListTile(
            title: Text(name),
            subtitle: Text("ID: $id"),
          );
        }).toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search ALL Debug")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _controller,
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  searchAll(value.trim());
                }
              },
              decoration: const InputDecoration(
                hintText: "Search everything...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),

          if (isLoading)
            const Center(child: CircularProgressIndicator()),

          if (error != null)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                error!,
                style: const TextStyle(color: Colors.red),
              ),
            ),

          if (!isLoading && error == null)
            Expanded(
              child: ListView(
                children: [
                  buildSection("Songs", songs),
                  buildSection("Albums", albums),
                  buildSection("Artists", artists),
                ],
              ),
            ),
        ],
      ),
    );
  }
}