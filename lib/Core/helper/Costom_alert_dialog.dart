import 'package:flutter/material.dart';

void showAlertDialog(BuildContext context,String content,Icon? icon,Color? color,[void Function()? onPressed]) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            icon: icon,
            iconColor: color,
            content:  Text(content),
            actions: [
              MaterialButton(
                onPressed: onPressed ?? () {
                  Navigator.of(context).pop(); 
                },
                child: const Text("OK"),
              ),
            ],
          );
        });
  }