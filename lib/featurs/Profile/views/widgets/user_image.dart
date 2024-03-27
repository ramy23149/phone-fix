

import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  const UserImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
              shape: const CircleBorder(),
              elevation: 6.0,
              child: CircleAvatar(
                radius: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.asset(
                    'assets/images/profile.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
  }
}