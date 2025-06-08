import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  
  ProductList() {
    for (final product in _items) {
      product.addListener(_onProductChanged);
    }
  }

  void _onProductChanged() {
    notifyListeners();
  }

  List<Product> get items => _items.where((prod) => !prod.isIgnored).toList();
  List<Product> get favoriteItems => _items.where((prod) => prod.isFavorite == true).toList();
  List<Product> get ignoredItems => _items.where((prod) => prod.isIgnored == true).toList();

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

}
