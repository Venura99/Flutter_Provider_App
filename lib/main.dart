import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_flutter/pages/product_page.dart';
import 'package:provider_flutter/providers/cart_provider.dart';
import 'package:provider_flutter/providers/favourite_provider.dart';

void main() {
  runApp(
      // ChangeNotifierProvider(
      // create: (context) => CartProvider(),          //single provider
      // child: const MyApp(),
      // )

      MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CartProvider()
        ),
        ChangeNotifierProvider(
          create: (contex) => FavouriteProvider()
        ),
      ],
      child: const MyApp(),
      )
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductsPage(),
    );
  }
}
