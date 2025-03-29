import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_flutter/data/product_data.dart';
import 'package:provider_flutter/models/product_model.dart';
import 'package:provider_flutter/pages/cart_page.dart';
import 'package:provider_flutter/pages/favourite_page.dart';
import 'package:provider_flutter/providers/cart_provider.dart';
import 'package:provider_flutter/providers/favourite_provider.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
   final List<Product> products = ProductData().products;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fashion Shop", 
        style: TextStyle(
          color: Colors.deepOrange,
          fontWeight: FontWeight.bold,
          fontSize: 30
        )),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(onPressed: (){
                  Navigator.push(context, 
                    MaterialPageRoute(
                      builder: (context) => const FavouritePage()
                      ),
                      );
          },
          backgroundColor: Colors.deepOrange,
          heroTag: "fav_btn",
          child: const Icon(
            Icons.favorite, 
            color: Colors.white),
            ),

            const SizedBox(width: 20,),

            FloatingActionButton(onPressed: (){
              Navigator.push(context, 
                    MaterialPageRoute(
                      builder: (context) => const CartPage()
                      ),
                      );
            },
            heroTag: "shopping_btn",
            backgroundColor: Colors.deepOrange,
          child: const Icon(
            Icons.shopping_cart,
            color: Colors.white,),
            ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder:  (context, index){
          final Product product = products[index];
          return Card(
            child: Consumer2<CartProvider, FavouriteProvider>(
              builder: (BuildContext context, CartProvider cartProvider, FavouriteProvider favProvider,
              Widget? child) { 
                return ListTile(
                title: Row( 
                  children: [
                    Text(
                      product.title, 
                      style: TextStyle(
                      fontWeight: FontWeight.bold,
              
                    )),
                    // const SizedBox(width: 50,),
                    // Text(
                    //   cartProvider.items.containsKey(product.id) ?
                    //   cartProvider.items[product.id]!.quantity.toString()
                    //   : "0", 
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.bold,
                    //   ),),
                  ],
                ),
                subtitle: 
                Text("\$${product.price.toString()} | Qty : ${
                  cartProvider.items.containsKey(product.id) ?
                      cartProvider.items[product.id]!.quantity.toString()
                      : "0"
                }"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        favProvider.togggleFavourites(product.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                            favProvider.isFavourite(product.id) ? "Added to favourites!" : "Removed from favourites"),
                            duration: Duration(seconds: 1),
                            )
                        );
                    }, 
                    icon:  Icon(
                      favProvider.isFavourite(product.id) ? Icons.favorite : Icons.favorite_border,
                      color: favProvider.isFavourite(product.id) ? Colors.pinkAccent : Colors.grey, 
                      )
                    ),
                    IconButton(
                      onPressed: () {
                        cartProvider.addItem(
                          product.id, 
                          product.price, 
                          product.title
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Added to cart successfully!"),
                              duration:  const Duration(seconds: 1),
                              ),
                           );
                    }, 
                    icon:  Icon(
                      Icons.shopping_cart,
                      color: cartProvider.items.containsKey(product.id)
                       ? Colors.orange
                       : Colors.grey,
                      ),
                    ),
                  ],
                ),
                );
               },
            )
          );
        }
        ),
    );
  }
}