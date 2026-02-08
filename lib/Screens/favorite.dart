import 'package:zomo/Provider/favirite_provider.dart';
import 'package:zomo/Screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zomo/models/items_models.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('My Favourites'),
        centerTitle: true,
      ),
      body: Consumer<FavouriteProvider>(
        builder: (context, favProvider, child) {
          final List<Product> favourites = favProvider.favourites;

          if (favourites.isEmpty) {
            return const Center(
              child: Text(
                'No favourites yet ❤️',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            itemCount: favourites.length,
            itemBuilder: (context, index) {
              final product = favourites[index];

              return ListTile(
                leading: Image.asset(
                  product.image,
                  width: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(product.name),
                subtitle: Text('\$${product.price.toStringAsFixed(0)}'),
                trailing: IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.red),
                  onPressed: () {
                    favProvider.toggleFavourite(product);
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductScreen(item: product),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
