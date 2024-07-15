import 'package:flutter/material.dart';
import '../models/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(id: '1', title: 'Product 1', price: 29.99),
    Product(id: '2', title: 'Product 2', price: 59.99),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> search(String query) {
    return _items
        .where((prod) => prod.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
