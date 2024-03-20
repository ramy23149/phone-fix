import 'package:flutter/material.dart';

void showAlertDialog(BuildContext context,String content) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            icon: const Icon(Icons.done_outline),
            iconColor: Colors.green,
            content:  Text(content),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop(); 
                },
                child: const Text("OK"),
              ),
            ],
          );
        });
  }