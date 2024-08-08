import 'package:flutter/material.dart';
import 'package:shop_app/global_variable.dart';

class ProductDetails extends StatefulWidget {
  final Map<String, Object> productDetails;
  const ProductDetails({super.key, required this.productDetails});
  
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int selectedSize =0;
  
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'details',
          style: Theme.of(context).textTheme.bodySmall,
        )),
      ),
      body: Column(
        children: [
          Text(
            widget.productDetails['title'] as String,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(widget.productDetails['imageUrl'] as String),
          ),
          Spacer(
            flex: 2,
          ),
          Container(
            
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Color.fromRGBO(202, 227, 252, 1),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(40),
                )),
            child: Column(
              children: [
                Text(
                  '\$${widget.productDetails['price']}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
               const  SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                      itemCount: (widget.productDetails['size'] as List<int>).length,
                      itemBuilder: (context, index) {
                        final size = (widget.productDetails['size'] as List<int>)[index];
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: GestureDetector(
                            onTap: ()=>setState(() {
                              selectedSize=size;
                            }),
                            child: Chip(label: Text(size.toString())
                            , 
                            backgroundColor: selectedSize == size ? Theme.of(context).colorScheme.primary:null,
                            )),
                        );
                      }),
                ),
 
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      minimumSize: Size(double.infinity, 50)
                    ),
                    onPressed: (){}, 
                    child: Text('Add To cart',
                    style: TextStyle(color: Colors.black),
                    )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
