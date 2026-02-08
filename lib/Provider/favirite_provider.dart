import 'package:flutter/material.dart';
import '../models/items_models.dart';

class FavouriteProvider extends ChangeNotifier {
  final List<Product> _favourites = [];

  List<Product> get favourites => _favourites;

  bool isFavourite(Product product) {
    return _favourites.contains(product);
  }

  void toggleFavourite(Product product) {
    if (isFavourite(product)) {
      _favourites.remove(product);
    } else {
      _favourites.add(product);
    }
    notifyListeners();
  }
}
