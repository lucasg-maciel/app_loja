import 'package:flutter/material.dart';

enum FilterOptions {
  favorite,
  all,
  ignored,
}

enum SortOptions {
  price,
  name,
  ascending,
  descending,
}

class ProductSort with ChangeNotifier {
  bool _showFavoriteOnly = false;
  bool _showIgnoredOnly = false;
  bool _isAscending = true;
  bool _isSortedByPrice = false;
  bool _isSortedByName = false;

  bool get showFavoriteOnly => _showFavoriteOnly;
  bool get showIgnoredOnly => _showIgnoredOnly;
  bool get isAscending => _isAscending;
  bool get isSortedByPrice => _isSortedByPrice;
  bool get isSortedByName => _isSortedByName;

  void setFilter(FilterOptions filter) {
    switch (filter) {
      case FilterOptions.favorite:
        _showFavoriteOnly = true;
        _showIgnoredOnly = false;
        break;
      case FilterOptions.ignored:
        _showIgnoredOnly = true;
        _showFavoriteOnly = false;
        break;
      case FilterOptions.all:
        _showFavoriteOnly = false;
        _showIgnoredOnly = false;
        break;
    }
    notifyListeners();
  }

  void setSortOrder(bool ascending) {
    _isAscending = ascending;
    notifyListeners();
  }

  void setSortBy(SortOptions sortBy) {
    switch (sortBy) {
      case SortOptions.price:
        _isSortedByPrice = true;
        _isSortedByName = false;
        break;
      case SortOptions.name:
        _isSortedByName = true;
        _isSortedByPrice = false;
        break;
      default:
        break;
    }
    notifyListeners();
  }
}