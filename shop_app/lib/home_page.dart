import 'package:flutter/material.dart';
import 'package:shop_app/global_variable.dart';
import 'package:shop_app/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> filters = const ['All', 'Adidas', 'Sparx', 'Bata', 'Nike'];
  late String selectedFilter;
  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    const borderr = OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromRGBO(225, 225, 225, 1)),
        borderRadius: BorderRadius.horizontal(left: Radius.circular(30)));
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
             Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Shoes\nCollectoins",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Expanded(
                    child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: borderr,
                      enabledBorder: borderr),
                )),
              ],
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  final filter = filters[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                        onTap: () => setState(() {
                              selectedFilter = filter;
                            }),
                        child: Chip(
                          backgroundColor: selectedFilter == filter
                              ? Theme.of(context).colorScheme.primary
                              : Color.fromRGBO(225, 225, 225, 1),
                          label: Text(filter),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          side: BorderSide(
                              color: Color.fromRGBO(225, 225, 225, 1)),
                        )),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];

                  return ProductCard(
                      title: product['title'] as String,
                      price: product['price'] as String,
                      imgUrl: product['imageUrl'] as String,
                      backgroundColor: index.isEven?const Color.fromRGBO(216, 240, 253,1):const Color.fromRGBO(245, 247, 249, 1),
                      );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
