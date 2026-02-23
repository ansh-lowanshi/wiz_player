import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ArtistDebugPage extends StatefulWidget {
  const ArtistDebugPage({super.key});

  @override
  State<ArtistDebugPage> createState() => _ArtistDebugPageState();
}

class _ArtistDebugPageState extends State<ArtistDebugPage> {
  final TextEditingController _controller = TextEditingController();

  bool isLoading = false;
  String? error;
  List<dynamic> artists = [];

  Future<void> searchArtist(String query) async {
    setState(() {
      isLoading = true;
      error = null;
      artists = [];
    });

    try {
      final uri = Uri.parse(
        'https://saavn.sumit.co/api/search/artists?query=$query',
      );

      final response = await http.get(uri);

      if (response.statusCode != 200) {
        throw Exception('Failed to fetch artists');
      }

      final decoded = jsonDecode(response.body);

      final results =
          decoded['data']?['results'] as List<dynamic>? ?? [];

      setState(() {
        artists = results;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Artist Debug - No Image")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  searchArtist(value.trim());
                }
              },
              decoration: const InputDecoration(
                hintText: "Search artist...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            if (isLoading)
              const Center(child: CircularProgressIndicator()),

            if (error != null)
              Text(
                error!,
                style: const TextStyle(color: Colors.red),
              ),

            if (!isLoading && artists.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: artists.length,
                  itemBuilder: (context, index) {
                    final artist = artists[index];

                    final name = artist['name'] ?? 'Unknown';
                    final id = artist['id'] ?? '';

                    return ListTile(
                      title: Text(name.toString()),
                      subtitle: Text("ID: $id"),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}