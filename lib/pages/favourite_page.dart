

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_flutter/data/product_data.dart';
import 'package:provider_flutter/models/product_model.dart';
import 'package:provider_flutter/providers/favourite_provider.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favourites", 
          style: TextStyle(
          color: Colors.deepOrange,
          fontWeight: FontWeight.bold,
          fontSize: 30),
          ),
      ),
      body: Consumer<FavouriteProvider>(
        builder: (
          BuildContext context, FavouriteProvider favProvider,Widget? child
        ){
          final favItems = favProvider.favourites.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList();

          if(favItems.isEmpty){
            return const Center(
              child: Text("No favourites added yet!"),
            );
          }

          return ListView.builder(
            itemCount: favItems.length,
            itemBuilder: (context, index) {
              final productId = favItems[index];
              final Product product = ProductData().products.firstWhere((product)=> product.id == productId);
              return Card (
                child:ListTile(
                  title: Text(product.title),
                  subtitle: Text("\$${product.price}"),
                  trailing: IconButton(
                    onPressed: () {
                      favProvider.togggleFavourites(productId);
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Removed from favourites"),
                            duration: Duration(seconds: 1),
                            )
                        );
                    }, 
                    icon: Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                      )
                    )
                )
              );
            }
            );
        },
      ),
    );
  }
}