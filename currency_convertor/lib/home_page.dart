import 'package:flutter/material.dart';

// Error: The state class should match the widget class name
class CurrencyConvertor extends StatefulWidget {
  const CurrencyConvertor({super.key});
  @override
  State<CurrencyConvertor> createState() => _CurrencyConvertorState();
}

// Error: The state class name should match the pattern _WidgetNameState
class _CurrencyConvertorState extends State<CurrencyConvertor> {
  final TextEditingController textEditingController = TextEditingController();
  double result = 0;
  @override
  void initState() {
    super.initState();
    print(" State init ");
  }

  final border = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(
      color: Colors.black,
      width: 1,
    ),
  );

  @override
  Widget build(BuildContext context) {
    double wdth = 350;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 117, 80, 133),
        elevation: 0,
        title: const Text('Currency Convertor',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 117, 80, 133),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              result.toString(),
              style: const TextStyle(
                fontSize: 70,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 245, 241, 241),
              ),
             
            ),
          
       const     Icon(Icons.monetization_on),
            SizedBox(
              width: wdth,
              child: TextField(
                controller: textEditingController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Please enter an amount in INR',
                  hintStyle: const TextStyle(color: Colors.white),
                  suffixIcon: const Icon(Icons.monetization_on),
                  // Incorrect property 'suffixIconColor'. It should be applied on Icon.
                  fillColor: Colors.amber,
                  filled: true,
                  focusedBorder: border,
                  enabledBorder: border,
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  if (textEditingController.text.isNotEmpty) {
                    setState(() {
                      result = double.parse(textEditingController.text) * 80;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(340, 40),
                  backgroundColor: const Color.fromARGB(255, 15, 15, 15),
                  textStyle: const TextStyle(color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text(
                  ' Convert',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: CurrencyConvertor()));
}
