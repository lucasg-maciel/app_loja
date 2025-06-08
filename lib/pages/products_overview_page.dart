import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/badgee.dart';
import 'package:shop/components/product_grid.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/product_sort.dart';
import 'package:shop/utils/app_routes.dart';


class ProductsOverviewPage extends StatefulWidget {
  const ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {

  @override
  Widget build(BuildContext context) {
    final sortProvider = Provider.of<ProductSort>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Loja'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.arrow_drop_down_circle_outlined),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: SortOptions.ascending,
                child: Text('Ordenação Ascendente'),
              ),
              const PopupMenuItem(
                value: SortOptions.descending,
                child: Text('Ordenação Descendente'),
              ),
            ],
            onSelected: (SortOptions selectedValue) {
              setState(() {
                if (selectedValue == SortOptions.ascending) {
                  sortProvider.setSortOrder(true);
                } else {
                  sortProvider.setSortOrder(false);
                }
              });
            },
          ),
          PopupMenuButton(
            icon: const Icon(Icons.sort),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: SortOptions.price,
                child: Text('Ordenar por Preço'),
              ),
              const PopupMenuItem(
                value: SortOptions.name,
                child: Text('Ordenar por Nome'),
              ),
            ],
            onSelected: (SortOptions sortValue) {
              setState(() {
                if (sortValue == SortOptions.price) {
                  sortProvider.setSortBy(SortOptions.price);
                  sortProvider.setSortOrder(false);
                } else {
                  sortProvider.setSortOrder(true);
                  sortProvider.setSortBy(SortOptions.name);
                }
              });
            },
          ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.favorite,
                child: Text('Somente Favoritos'),
              ),
              const PopupMenuItem(
                value: FilterOptions.all,
                child: Text('Todos'),
              ),
              const PopupMenuItem(
                value: FilterOptions.ignored,
                child: Text('Produtos Ignorados'),
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                sortProvider.setFilter(selectedValue);
              });
            },
          ),
          Consumer<Cart>(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.cart);
              },
              icon: const Icon(Icons.shopping_cart),
            ),
            builder: (ctx, cart, child) => Badgee(
              value: cart.itemsCount.toString(),
              child: child!,
            ),
          ),
        ],
      ),
      body: ProductGrid(),
      drawer: const AppDrawer(),
    );
  }
}
