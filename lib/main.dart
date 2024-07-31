import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/screens/cartscreen.dart';
import './screens/login_screen.dart';
import './screens/product_search_screen.dart';
import './screens/signup_screen.dart';
import './screens/cart_screen.dart';
import './screens/payment_screen.dart';
import './providers/auth.dart';
import './providers/products.dart';
import './providers/cart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProvider(create: (_) => Products()),
        ChangeNotifierProvider(create: (_) => Cart()),
      ],
      child: MaterialApp(
        title: 'Shopping App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginScreen(),
        routes: {
          '/search': (ctx) => ProductSearchScreen(),
          '/signup': (ctx) => SignupScreen(),
          '/cart': (ctx) => CartScreen(),
        },
      ),
    );
  }
}
