import 'package:flutter/material.dart';
import 'package:my_project/services/favorite_service%20.dart';
import 'package:my_project/services/recipe_service.dart';
import 'package:provider/provider.dart';

import 'favorites_view.dart';
import 'recipe_detail_view.dart';
import '../models/recipe.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final RecipeService _recipeService = RecipeService();
  late Future<List<Recipe>> _recipesFuture;
  int _selectedIndex = 0; //0 home, 1 favorites sayfası olacak

  @override
  void initState() {
    super.initState();
    _recipesFuture = _recipeService.getRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? "Recipe App" : "Favorites"),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [_buildHomeBody(), const FavoritesView()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
        ],
      ),
    );
  }

  Widget _buildHomeBody() {
    return FutureBuilder<List<Recipe>>(
      future: _recipesFuture,
      builder: (context, snapshot) {
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        // Error
        if (snapshot.hasError) {
          return const Center(
            child: Text(
              "Tarifler yüklenemedi.",
              style: TextStyle(color: Colors.black),
            ),
          );
        }

        final recipes = snapshot.data!;
        if (recipes.isEmpty) {
          return const Center(child: Text("Henüz tarif bulunamadı."));
        }

        return ListView.builder(
          itemCount: recipes.length,
          itemBuilder: (context, index) {
            final recipe = recipes[index];

            return Card(
              margin: const EdgeInsets.all(12),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeDetailView(recipe: recipe),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Resim + favori butonu üst üste
                    Stack(
                      children: [
                        Image.network(
                          recipe.image,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 180,
                              color: Colors.grey,
                              child: const Center(
                                child: Icon(Icons.broken_image, size: 40),
                              ),
                            );
                          },
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Consumer<FavoriteService>(
                            builder: (context, favoriteService, child) {
                              final isFavorite = favoriteService.isFavorite(
                                recipe,
                              );

                              return Material(
                                color: Colors.white.withOpacity(0.85),
                                shape: const CircleBorder(),
                                child: IconButton(
                                  onPressed: () {
                                    if (isFavorite) {
                                      favoriteService.removeFavorite(recipe);
                                    } else {
                                      favoriteService.addFavorite(recipe);
                                    }
                                  },
                                  icon: Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isFavorite
                                        ? Colors.red
                                        : Colors.black,
                                    size: 26,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            recipe.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text("Cuisine: ${recipe.cuisine}"),
                          Text("Difficulty: ${recipe.difficulty}"),
                          Text("Preparation: ${recipe.prepTimeMinutes} min"),
                          Text("Cooking: ${recipe.cookTimeMinutes} min"),
                          Text("Rating: ${recipe.rating} ⭐"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
