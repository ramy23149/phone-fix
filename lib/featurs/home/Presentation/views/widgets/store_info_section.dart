
import 'package:flutter/material.dart';

import '../../../../../Core/text_styles/Styles.dart';

class SoreInfo extends StatelessWidget {
  const SoreInfo({super.key, required this.storeInfo});
  final Map<String, dynamic> storeInfo;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            storeInfo['name'],
            style: Styles.textStyle20,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          Text(
            storeInfo['districte'],
            style: Styles.textStyle14.copyWith(color: Colors.grey),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.phone, size: 16, color: Colors.grey),
              const SizedBox(width: 5),
              Text(
                storeInfo['phoneNumber'].toString().substring(2),
                style: Styles.textStyle14,
              ),
            ],
          ),
        ],
      ),
    );
  }
}