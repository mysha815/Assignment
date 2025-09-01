import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/Recipe Model.dart';
class RecipeList extends StatelessWidget {
  const RecipeList({super.key});

  @override
  Widget build(BuildContext context) {
    final data = jsonDecode(jsonData);
    final List recipesJson = data['recipes'];
    final List<Recipe> recipes =
    recipesJson.map((e) => Recipe.fromJson(e)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Food Recipes"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              leading: const Icon(Icons.fastfood, color: Colors.blue),
              title: Text(
                recipe.title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text(recipe.description),
            ),
          );
        },
      ),
    );
  }
}

