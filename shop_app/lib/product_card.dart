import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String imgUrl;
  final Color backgroundColor;
  const ProductCard({super.key,  required this.title, required this.price, required this.imgUrl, required this.backgroundColor});

  @override 
  Widget build(BuildContext context) {

 double deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(20),

      ),
      padding: const EdgeInsets.all(20),
      margin:const  EdgeInsets.all(10),
child:  Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Text('$title', style: Theme.of(context).textTheme.titleMedium,),
 const SizedBox(height: 5,),
 Text('\$ $price ' , style: Theme.of(context).textTheme.bodySmall,),
 const SizedBox(height: 5,),
Center(child: Image(image: AssetImage(imgUrl),height: deviceHeight*.3,))
],),
    );
  }
}