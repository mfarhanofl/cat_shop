import 'package:zomo/Screens/product_screen.dart';
import 'package:zomo/models/items_models.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String search = '';
  List<Product> get FilterItem {
    if (search.isEmpty) {
      return Item;
    }
    return Item.where((item) {
      return item.name.toUpperCase().toLowerCase().contains(
        search.toLowerCase(),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    search = value;
                  });
                },
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: "Search",
                  filled: true,
                  fillColor: Colors.blueGrey.withOpacity(0.1),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                textInputAction: TextInputAction.search,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: FilterItem.length,
                itemBuilder: (context, index) {
                  final item = FilterItem[index];
                  return ListTile(
                    leading: Image.asset(
                      item.image,
                      width: 20,
                      fit: BoxFit.contain,
                    ),
                    title: Text(item.name),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductScreen(item: item),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
