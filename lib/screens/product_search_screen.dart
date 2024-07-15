import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../providers/cart.dart';
import '../models/product.dart';

class ProductSearchScreen extends StatefulWidget {
  @override
  _ProductSearchScreenState createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> _searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(context).pushNamed('/cart');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(labelText: 'Search'),
              onChanged: (value) {
                setState(() {
                  _searchResults = Provider.of<Products>(context, listen: false)
                      .search(value);
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  title: Text(_searchResults[index].title),
                  subtitle: Text('\$${_searchResults[index].price}'),
                  trailing: IconButton(
                    icon: Icon(Icons.add_shopping_cart),
                    onPressed: () {
                      Provider.of<Cart>(context, listen: false).addItem(
                        _searchResults[index].id,
                        _searchResults[index].title,
                        _searchResults[index].price,
                      );
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text('Success!'),
                          content: Text(
                              '${_searchResults[index].title} added to cart.'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Okay'),
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
