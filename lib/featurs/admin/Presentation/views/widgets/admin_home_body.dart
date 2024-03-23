import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery_app/featurs/admin/Presentation/views/widgets/admin_text_field.dart';

import '../../../../../Core/text_styles/Styles.dart';
import 'admin_appbar.dart';
import 'custom_image_contaner.dart';

class AdminHomeBody extends StatefulWidget {
  const AdminHomeBody({super.key});

  @override
  State<AdminHomeBody> createState() => _AdminHomeBodyState();
}

class _AdminHomeBodyState extends State<AdminHomeBody> {
  String? value;
  List<String> items = ['pizza', 'ice_cream', 'Burger', 'Salad'];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AdminAppbar(onPressed: () {
              
            },),
            const Text(
              'Upload the Item picture',
              style: Styles.textStyle18,
            ),
            const SizedBox(
              height: 20,
            ),
            const ImageContaner(),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Item Name',
              style: Styles.textStyle18,
            ),
            const AdminTextField(
              hint: 'Enter Item Name',
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Item Price',
              style: Styles.textStyle18,
            ),
            const AdminTextField(
              hint: 'Enter Item Price',
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Item Details',
              style: Styles.textStyle18,
            ),
            const AdminTextField(
              hint: 'Enter Item Details',
              maxlines: 5,
            ),

            const SizedBox(
              height: 10,
            ),
            const Text('Select Category',style: Styles.textStyle18,),
          
            Container(
              color:const Color(0xffE8E8F7),
              width: double.infinity,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    size: 30,
                    color: Colors.black,
                  ),
                  hint: const Text('Category'),
                  value: value,
                  items: items
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: Styles.textStyle14,
                            ),
                          ))
                      .toList(),
                  onChanged: (value) =>
                    setState(() {
                      this.value = value;
                    })
                  
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
