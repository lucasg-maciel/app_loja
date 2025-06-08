import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/product_item.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavoriteOnly;
  final bool showIgnoredOnly;
  final bool isSortedByPrice;
  final bool isSortedByName;
  final bool isAscending;

  const ProductGrid(this.showFavoriteOnly, this.showIgnoredOnly, this.isSortedByPrice, this.isSortedByName, this.isAscending, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    List<Product> loadedProducts;
    if (showIgnoredOnly) {
      loadedProducts = provider.ignoredItems;
    } else if (showFavoriteOnly) {
      loadedProducts = provider.favoriteItems;
    } else {
      loadedProducts = provider.items;
    }
    
    if(isSortedByName){
      if(isAscending){
        loadedProducts.sort((a, b) => a.name.compareTo(b.name));
      } else {
        loadedProducts.sort((a, b) => b.name.compareTo(a.name));
      }
    }

    if(isSortedByPrice){
      if(isAscending){
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
