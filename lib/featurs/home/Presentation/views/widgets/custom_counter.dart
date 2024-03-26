import 'package:flutter/material.dart';

class CustomCounter extends StatefulWidget {
  const CustomCounter({super.key, required this.onCounterValueChanged,
  });
  final Function(int) onCounterValueChanged;
  @override
  _CustomCounterState createState() => _CustomCounterState();
}

class _CustomCounterState extends State<CustomCounter> {
  int _counter = 1;

  void _incrementCounter() {
    setState(() {
      _counter++;
      widget.onCounterValueChanged(_counter);
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 1) {
        _counter--;
        widget.onCounterValueChanged(_counter);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _decrementCounter,
            fillColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Make it square
            ),
            constraints: const BoxConstraints.tightFor(
              width: 30, // Set width
              height: 30, // Set height
            ),
            child: const Icon(
              Icons.remove,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '$_counter',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(width: 10),
          RawMaterialButton(
            onPressed: _incrementCounter,
            fillColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Make it square
            ),
            constraints: const BoxConstraints.tightFor(
              width: 30.0, // Set width
              height: 30.0, // Set height
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
