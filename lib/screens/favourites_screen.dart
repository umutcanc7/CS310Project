import 'package:flutter/material.dart';
import '../services/favourites_service.dart';
import '../selected_restaurant.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  late Future<List<Map<String, dynamic>>> _favouritesFuture;

  @override
  void initState() {
    super.initState();
    _favouritesFuture = FavouritesService().fetchFavourites();
  }

  void _refreshFavourites() {
    setState(() {
      _favouritesFuture = FavouritesService().fetchFavourites();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (SelectedRestaurant.name == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Favourites')),
        body: const Center(
          child: Text(
            "Please pick a restaurant from the restaurant page first.",
            style: TextStyle(fontSize: 18, color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    if (SelectedRestaurant.name != 'piazza') {
      return Scaffold(
        appBar: AppBar(title: const Text('Favourites')),
        body: const Center(
          child: Text(
            "You can't. Please pick a restaurant that is added to app.",
            style: TextStyle(fontSize: 18, color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Favourites')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _favouritesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final favourites = snapshot.data ?? [];
          if (favourites.isEmpty) {
            return const Center(child: Text('No favourites yet.'));
          }
          return ListView.builder(
            itemCount: favourites.length,
            itemBuilder: (context, index) {
              final fav = favourites[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: Icon(Icons.star, color: Colors.amber),
                  title: Text(fav['name'] ?? ''),
                  subtitle: Text(
                    fav['category'] != null && fav['category'].isNotEmpty
                        ? fav['category'][0].toUpperCase() + fav['category'].substring(1)
                        : '',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await FavouritesService().removeFavourite(fav['docId']);
                      _refreshFavourites();
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
} 