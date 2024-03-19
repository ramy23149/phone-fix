import 'package:flutter/material.dart';



class CustomCounter extends StatefulWidget {
  @override
  _CustomCounterState createState() => _CustomCounterState();
}

class _CustomCounterState extends State<CustomCounter> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
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
            constraints: BoxConstraints.tightFor(
              width: 30, // Set width
              height: 30, // Set height
            ),
            child: Icon(
              Icons.remove,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 10),
          Text(
            '$_counter',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(width: 10),
          RawMaterialButton(
            
            onPressed: _incrementCounter,
            fillColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Make it square
            ),
            constraints: BoxConstraints.tightFor(
              width: 30.0, // Set width
              height: 30.0, // Set height
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
