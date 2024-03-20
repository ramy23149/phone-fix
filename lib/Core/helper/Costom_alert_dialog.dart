import 'package:flutter/material.dart';

void showAlertDialog(BuildContext context,String content) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
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