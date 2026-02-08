import 'package:zomo/models/category_models.dart';
import 'package:zomo/models/items_models.dart';
import 'package:zomo/widget/product_card_file.dart';
import 'package:zomo/widget/search_screen.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final selectedCategory = cat[selectedIndex].text;

    final filteredItems = selectedCategory == "All"
        ? Item
        : Item.where(
            (item) =>
                item.category.trim().toLowerCase() ==
                selectedCategory.trim().toLowerCase(),
          ).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// TITLE
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(text: "Hello!\nWhat would you like to\n"),
                        TextSpan(
                          text: "Buy?",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.search, size: 34),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// CATEGORY LIST
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.12,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: cat.length,
                  itemBuilder: (context, index) {
                    final category = cat[index];
                    final isSelected = selectedIndex == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: isSelected
                                  ? Colors.blue
                                  : Colors.grey.shade200,
                              child: Icon(
                                category.icon,
                                color: isSelected ? Colors.white : Colors.blue,
                                size: 25,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              category.text,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: isSelected ? Colors.blue : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              /// PRODUCT GRID
              Expanded(
                child: GridView.builder(
                  itemCount: filteredItems.length,
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];
                    return ProductCard(item: item);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
