import 'package:flutter/material.dart';
import 'package:my_project/services/favorite_service%20.dart';
import 'package:my_project/views/recipe_detail_view.dart';
import 'package:provider/provider.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    // Burada FavoriteService'e erişeceğiz.
    //context.watch servisi dinler.
    // favoriteService.favorites favori tariflerin listesini verir.

    final favoriteService = Provider.of<FavoriteService>(context);
    final favorites = favoriteService.favorites;

    return Scaffold(
      body: favorites.isEmpty
          ? const Center(child: Text("Henüz favori tarifin yok."))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final recipe = favorites[index];

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetailView(recipe: recipe),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Image.network(
                      recipe.image,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(recipe.name),
                    subtitle: Text(recipe.cuisine),
                  ),
                );
              },
            ),
    );
  }
}
