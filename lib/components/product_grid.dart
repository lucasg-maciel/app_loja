import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/product_item.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/models/product_sort.dart';

class ProductGrid extends StatelessWidget {


  const ProductGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sortProvider = Provider.of<ProductSort>(context);
    final provider = Provider.of<ProductList>(context);
    List<Product> loadedProducts;
    if (sortProvider.showIgnoredOnly) {
      loadedProducts = provider.ignoredItems;
    } else if (sortProvider.showFavoriteOnly) {
      loadedProducts = provider.favoriteItems;
    } else {
      loadedProducts = provider.items;
    }

    if (sortProvider.isSortedByName) {
      if (sortProvider.isAscending) {
        loadedProducts.sort((a, b) => a.name.compareTo(b.name));
      } else {
        loadedProducts.sort((a, b) => b.name.compareTo(a.name));
      }
    }

    if (sortProvider.isSortedByPrice) {
      if (sortProvider.isAscending) {
        loadedProducts.sort((a, b) => a.price.compareTo(b.price));
      } else {
        loadedProducts.sort((a, b) => b.price.compareTo(a.price));
      }
    }

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: loadedProducts[i],
        child: const ProductItem(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
