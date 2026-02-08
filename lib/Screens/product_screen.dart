import 'package:zomo/Provider/cart_provider.dart';
import 'package:zomo/models/items_models.dart';
import 'package:zomo/widget/product_card_file.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  final Product item;

  const ProductScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    // 🔹 Related items: same category, except current item
    final List<Product> relatedItems = Item.where((i) {
      return i.category.trim().toLowerCase() ==
              item.category.trim().toLowerCase() &&
          i.id != item.id;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          item.name.trim(),
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// PRODUCT IMAGE
              Container(
                height: MediaQuery.of(context).size.height * 0.28,
                width: double.infinity,
                color: Colors.white,
                child: Hero(
                  tag: item.id,
                  child: Image.asset(item.image, fit: BoxFit.contain),
                ),
              ),

              /// DETAILS
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// NAME
                    Text(
                      item.name.trim(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// PRICE
                    Text(
                      "₹${item.price.toDouble().toStringAsFixed(0)}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// DESCRIPTION TITLE
                    const Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// DESCRIPTION TEXT
                    Text(
                      item.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// RELATED PRODUCTS TITLE
                    const Text(
                      "Related Products",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// RELATED PRODUCTS LIST
                    SizedBox(
                      height: 230,
                      child: relatedItems.isEmpty
                          ? const Center(child: Text("No related products"))
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: relatedItems.length,
                              itemBuilder: (context, index) {
                                final relatedItem = relatedItems[index];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: SizedBox(
                                    width: 160,
                                    child: ProductCard(item: relatedItem),
                                  ),
                                );
                              },
                            ),
                    ),

                    const SizedBox(height: 30),

                    /// ADD TO CART BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          cartProvider.add(item);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("${item.name} added to cart"),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          "Add to Cart",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
